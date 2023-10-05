from django.shortcuts import render
from django.http import HttpResponse

import os
import sys
import django


# current_dir = os.path.dirname(os.path.abspath(__file__))
# parent_dir = os.path.abspath(os.path.join(current_dir, ".."))
# sys.path.append(parent_dir)

# os.environ.setdefault("DJANGO_SETTINGS_MODULE", "djangoServer.settings")

# django.setup()

from recommend.models import *  

import numpy as np

import datetime
import time

# Create your views here.
def init(request, user_id):
    ingr_num = len(Ingredient.objects.all())
    for ingr_id in range(1, ingr_num+1):
        IngredientRecommend.objects.create(
            user_id=user_id,
            ingr_id=ingr_id,
            ingr_recommend_score = 0
        ).save()
    response = HttpResponse("Recommendation init table has made successfully")
    return response


def recommend(request, user_id):
    # start_time = time.time()
    def recommend_als(request, user_id, user_ids, ingr_num, weight):
        nonlocal R
        print("recommend als init start")
        if weight == 0:
            return
        class AlternatingLeastSquares():
            def __init__(self, R, k, reg_param, epochs, verbose=False):
                """
                :param R: rating matrix
                :param k: latent parameter
                :param learning_rate: alpha on weight update
                :param reg_param: beta on weight update
                :param epochs: training epochs
                :param verbose: print status
                """
                self._R = R
                self._num_users, self._num_items = R.shape
                self._k = k
                self._reg_param = reg_param
                self._epochs = epochs
                self._verbose = verbose


            def fit(self):
                if self._verbose == True:
                    print("Fit start!")
                # init latent features
                self._users = np.random.normal(size=(self._num_users, self._k))
                self._items = np.random.normal(size=(self._num_items, self._k))

                # train while epochs
                self._training_process = []
                self._user_error = 0; self._item_error = 0; 

                for epoch in range(self._epochs):
                    for i, Ri in enumerate(self._R):
                        self._users[i] = self.user_latent(i, Ri)
                        self._user_error = self.cost()
                        
                    for j, Rj in enumerate(self._R.T):
                        self._items[j] = self.item_latent(j, Rj)
                        self._item_error = self.cost()
                        
                    cost = self.cost()
                    self._training_process.append((epoch, cost))

                    # print status
                    if self._verbose == True and ((epoch + 1) % 10 == 0):
                        print("Iteration: %d ; cost = %.4f" % (epoch + 1, cost))


            def cost(self):
                """
                compute root mean square error
                :return: rmse cost
                """
                xi, yi = self._R.nonzero()
                cost = 0
                for x, y in zip(xi, yi):
                    cost += pow(self._R[x, y] - self.get_prediction(x, y), 2)
                return np.sqrt(cost/len(xi))


            def user_latent(self, i, Ri):
                """
                :param error: rating - prediction error
                :param i: user index
                :param Ri: Rating of user index i
                :return: convergence value of user latent of i index
                """

                du = np.linalg.solve(np.dot(self._items.T, np.dot(np.diag(Ri), self._items)) + self._reg_param * np.eye(self._k),
                                        np.dot(self._items.T, np.dot(np.diag(Ri), self._R[i].T))).T
                return du

            def item_latent(self, j, Rj):
                """
                :param error: rating - prediction error
                :param j: item index
                :param Rj: Rating of item index j
                :return: convergence value of itemr latent of j index
                """

                di = np.linalg.solve(np.dot(self._users.T, np.dot(np.diag(Rj), self._users)) + self._reg_param * np.eye(self._k),
                                        np.dot(self._users.T, np.dot(np.diag(Rj), self._R[:, j])))
                return di


            def get_prediction(self, i, j):
                """
                get predicted rating: user_i, item_j
                :return: prediction of r_ij
                """
                return self._users[i, :].dot(self._items[j, :].T)


            def get_complete_matrix(self):
                """
                :return: complete matrix R^
                """
                return self._users.dot(self._items.T)
            
        als = AlternatingLeastSquares(R=R, reg_param=0.005, epochs=10, verbose=False, k=25)
        als.fit()

        als_result = als.get_complete_matrix()
        recommend_lst = als_result[userid_to_idx[user_id]]
        return recommend_lst


    def recommend_substitute(request, user_id, recommend_lst, weight):
        if weight == 0:
            return

        ingr_prefs = IngredientPreference.objects.filter(user_id=user_id)

        # 모든 그룹에 대한 스코어 업데이트를 계산할 딕셔너리
        update_dict = {}

        # 재료별 선호도를 그룹 스코어 업데이트에 반영
        for pref in ingr_prefs:
            ingr_id = pref.ingr_id
            pref_rating = pref.pref_rating

            # 해당 ingredient에 대한 관련 그룹을 가져옴
            groups = IngredientGroup.objects.filter(ingr_id=ingr_id)

            for group in groups:
                group_id = group.group_id
                # IngredientRecommend 업데이트를 위한 딕셔너리에 추가
                if group_id not in update_dict:
                    update_dict[group_id] = 0.0
                update_dict[group_id] += 0.5 * pref_rating * weight

        # 그룹별로 스코어 업데이트
        for group_id, score_delta in update_dict.items():
            # 해당 그룹에 속하는 모든 재료
            ingredients = IngredientGroup.objects.filter(group_id=group_id)

            # 사용자의 재료에 해당하는 recommend_lst 업데이트
            for ingredient in ingredients:
                recommend_lst[ingredient.ingr_id] += score_delta
        
        return recommend_lst
    

    def recommend_month(request, user_id, ingr_num, recommend_lst, weight):
        if weight == 0:
            return
        
        today = datetime.date.today()
        this_month = int(today.strftime('%m'))
        ingredients_month = IngredientMonth.objects.filter(month_id=this_month)
        for ingredient in ingredients_month:
            recommend_lst[ingredient.ingr_id] += 30 * weight
        
        return recommend_lst


    # 존재하는 모든 user_id를 가져옴
    user_ids = User.objects.values_list('user_id', flat=True)
    # ingredient는 중간에 빠진 값이 없어 개수로 가져옴
    ingr_num = len(Ingredient.objects.all())

    # userid를 키로 갖고 idx를 값으로 갖는 dictionary 생성
    userid_to_idx = {value: index for index, value in enumerate(user_ids)}

    # 선호도를 추천 점수로 갖는 초기 R 생성
    ingr_prefs = IngredientPreference.objects.all()
    R = np.zeros((len(user_ids), ingr_num+1))
    for ingr_pref in ingr_prefs:
        R[userid_to_idx[ingr_pref.user_id]][ingr_pref.ingr_id] = ingr_pref.pref_rating

    recommend_lst = recommend_als(request, user_id, user_ids, ingr_num, 1)
    recommend_lst = recommend_substitute(request, user_id, recommend_lst, 1)
    recommend_lst = recommend_month(request, user_id, ingr_num, recommend_lst, 1)

    for ingr_id, ingr_recommend_score in enumerate(recommend_lst):
        # index 0 건너뛰기
        if ingr_id == 0: continue
        # IngredientRecommend에 업데이트
        ingr_recommend = IngredientRecommend.objects.get(
            user_id=user_id,
            ingr_id=ingr_id,
        )
        ingr_recommend.ingr_recommend_score = ingr_recommend_score
        ingr_recommend.save()

    # end_time = time.time()
    # print(f"{(end_time-start_time)}초")
    response = HttpResponse("Recommendation process completed successfully")
    return response
    
            
