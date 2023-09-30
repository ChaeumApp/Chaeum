from django.shortcuts import render
from django.http import JsonResponse

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

# from implicit.evaluation import *
from implicit.als import AlternatingLeastSquares as ALS
import scipy
import numpy as np

# Create your views here.
def recommend(request, user_id):
    IngredientRecommend.objects.all().delete()
    
    user_num = len(User.objects.all())
    ingr_num = len(Ingredient.objects.all())
    combis = product(range(1, user_num+1), range(1, ingr_num+1))

    for combi in combis:
        IngredientRecommend.objects.create(
            user_id=combi[0],
            ingr_id=combi[1],
            ingr_recommend_score=0
        ).save()
    
    recommend_substitute(request, user_id, 0.5)
    recommend_als(request, user_id, user_num, ingr_num, 0.5)

    # ingredient_preference_init = [IngredientRecommend.objects.create(
    #         user_id=combi[0],
    #         ingr_id=combi[1],
    #         ingr_recommend_score=0
    #     ) for combi in combis]
    
    # IngredientRecommend.objects.bulk_create(ingredient_preference_init)
    
    
def recommend_substitute(request, user_id, weight):
    if weight == 0: return
    ingr_prefs = IngredientPreference.objects.filter(user_id=user_id)

    groups_lst = []

    for pref in ingr_prefs:
        ingredient = pref.ingr_id
        pref_rating = pref.pref_rating
        groups = IngredientGroup.objects.filter(ingr_id=ingredient)
        for group in groups:
            groups_lst.append([group.group_id, pref_rating])

        ingr_recommend = IngredientRecommend.objects.get(
                ingr_id = pref.ingr_id,
                user_id = user_id
        )

        ingr_recommend.ingr_recommend_score += 0.5 * pref_rating * weight
        ingr_recommend.save()

    for group in groups_lst:
        related_ingredients = IngredientGroup.objects.filter(group_id=group[0])
        for ingredient in related_ingredients:
            ingr_recommend = IngredientRecommend.objects.get(
                    ingr_id = ingredient.ingr_id,
                    user_id = user_id
            )

            ingr_recommend.ingr_recommend_score += 0.5 * group[1] * weight
            ingr_recommend.save()


def recommend_als(request, user_id, user_num, ingr_num, weight):
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
        
    # R = np.array([
    #     [10, 0, 0, 0, 0],
    #     [10, 9, 2, 2, 0],
    #     [0, 0, 0, 2, 0],
    #     [0, 0, 0, 0, 4],
    #     [0, 0, 0, 2, 0],
    #     [0, 0, 0, 0, 4],
    #     [0, 0, 0, 2, 0],
    #     [0, 0, 0, 0, 4],
    #     ])
    
    R = np.zeros((user_num+1, ingr_num+1))
    
    ingr_prefs = IngredientPreference.objects.all()

    for ingr_pref in ingr_prefs:
        R[ingr_pref.user_id][ingr_pref.ingr_id] = ingr_pref.pref_rating
        print(ingr_pref.ingr_pref_pk)

    als = AlternatingLeastSquares(R=R, reg_param=0.005, epochs=300, verbose=True, k=30)
    als.fit()

    result = als.get_complete_matrix()
    for user, user_pref in enumerate(result):
        for ingr, user_ingr_pref in enumerate(user_pref):
            if user_ingr_pref > 1e-8 or user_ingr_pref < -1e-8:
                print(f'user: {user}    ingr: {ingr}    user_ingr_pref:{user_ingr_pref}') 
                ingr_recommend = IngredientRecommend.objects.get(
                        ingr_id = ingr,
                        user_id = user
                )

                ingr_recommend.ingr_recommend_score += user_ingr_pref * weight
                ingr_recommend.save()
        
    
    # R = scipy.sparse.csr_matrix(np.array([
    #     [1, 0, 0, 1, 3],
    #     [2, 0, 3, 1, 1],
    #     [1, 2, 0, 5, 0],
    #     [1, 0, 0, 4, 4],
    #     [2, 1, 5, 4, 0],
    #     [5, 1, 5, 4, 0],
    #     [0, 0, 0, 1, 0],
    #     ]))

    # als_model = ALS(factors=2, regulariztion=0.01, iterations=10)
    # als_model.fit(R.T)

    # print(np.dot(als_model.user_factors, als_model.item_factors.T))
