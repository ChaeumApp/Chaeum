from django.shortcuts import render
from django.http import HttpResponse

import os
import sys
import django

from itertools import product

# current_dir = os.path.dirname(os.path.abspath(__file__))
# parent_dir = os.path.abspath(os.path.join(current_dir, ".."))
# sys.path.append(parent_dir)

# os.environ.setdefault("DJANGO_SETTINGS_MODULE", "djangoServer.settings")

# django.setup()

from recommend.models import *  
from django.db.models import F, Q

import scipy
import numpy as np

# Create your views here.
def recommend(request, user_id):
    IngredientRecommend.objects.all().delete()
    
    user_ids = User.objects.values_list('user_id', flat=True)
    user_num = len(user_ids)
    ingr_num = len(Ingredient.objects.all())
    combis = product(list(user_ids), range(1, ingr_num+1))

    ingredient_recommend_list = []

    for combi in combis:
        ingredient_recommend = IngredientRecommend(
            user_id=combi[0],
            ingr_id=combi[1],
            ingr_recommend_score=0
        )
        ingredient_recommend_list.append(ingredient_recommend)

    # ingredient_recommend_list를 한꺼번에 저장합니다.
    IngredientRecommend.objects.bulk_create(ingredient_recommend_list)

    ingr_prefs = IngredientPreference.objects.filter(user_id=user_id)
    for pref in ingr_prefs:
        ingredient = pref.ingr_id
        pref_rating = pref.pref_rating
        ingr_recommend = IngredientRecommend.objects.get(
            user_id=user_id,
            ingr_id=ingredient)
        ingr_recommend.ingr_recommend_score += pref_rating
        ingr_recommend.save()

    recommend_substitute(request, user_id, 0.5)
    recommend_als(request, user_id, user_ids, ingr_num, 0.5)
    response = HttpResponse("Recommendation process completed successfully")
    return response
    


def recommend_substitute(request, user_id, weight):
    if weight == 0:
        return

    ingr_prefs = IngredientPreference.objects.filter(user_id=user_id)

    # 모든 그룹에 대한 스코어 업데이트를 계산할 딕셔너리
    update_dict = {}

    # 재료별 선호도를 그룹 스코어 업데이트에 반영
    for pref in ingr_prefs:
        ingredient = pref.ingr_id
        pref_rating = pref.pref_rating

        # 해당 ingredient에 대한 관련 그룹을 가져옴
        groups = IngredientGroup.objects.filter(ingr_id=ingredient)

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

        # 사용자와 재료의 관련 IngredientRecommend 업데이트
        IngredientRecommend.objects.filter(
            user_id=user_id,
            ingr_id__in=ingredients.values('ingr_id')
        ).update(ingr_recommend_score=F('ingr_recommend_score') + score_delta)


def recommend_als(request, user_id, user_ids, ingr_num, weight):
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
        
    
    R = np.zeros((len(user_ids), ingr_num+1))
    userid_to_idx = {value: index for index, value in enumerate(user_ids)}
    ingr_prefs = IngredientPreference.objects.all()

    for ingr_pref in ingr_prefs:
        R[userid_to_idx[ingr_pref.user_id]][ingr_pref.ingr_id] = ingr_pref.pref_rating
        # print(ingr_pref.ingr_pref_pk)

    als = AlternatingLeastSquares(R=R, reg_param=0.005, epochs=100, verbose=False, k=25)
    als.fit()

    result = als.get_complete_matrix()
    for user, user_pref in enumerate(result):
        user = user_ids[user]
        for ingr, user_ingr_pref in enumerate(user_pref):
            if abs(user_ingr_pref) > 0.01:
                # Update the IngredientRecommend score using Django ORM
                ingr_recommend,created = IngredientRecommend.objects.get_or_create(
                    user_id=user,
                    ingr_id=ingr,
                    defaults={'ingr_recommend_score': 0}
                )
                ingr_recommend.ingr_recommend_score = F('ingr_recommend_score') + user_ingr_pref * weight
                ingr_recommend.save()
        
