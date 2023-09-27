from django.shortcuts import render
from django.http import JsonResponse

import os
import sys
import django

from itertools import product


current_dir = os.path.dirname(os.path.abspath(__file__))
parent_dir = os.path.abspath(os.path.join(current_dir, ".."))
sys.path.append(parent_dir)

os.environ.setdefault("DJANGO_SETTINGS_MODULE", "djangoServer.settings")

django.setup()

from recommend.models import *

# Create your views here.
def recommend_substitute(request, user_id, percent):
    user_num = len(User.objects.all())
    ingr_num = len(Ingredient.objects.all())
    combis = product(range(1, user_num+1), range(1, ingr_num+1))

    for combi in combis:
        # print(combi)
        IngredientRecommend.objects.create(
            user_id=combi[0],
            ingr_id=combi[1],
            ingr_recommend_score=0
        ).save()
    
    # ingredient_preference_init = [IngredientRecommend.objects.create(
    #         user_id=combi[0],
    #         ingr_id=combi[1],
    #         ingr_recommend_score=0
    #     ) for combi in combis]
    
    # IngredientRecommend.objects.bulk_create(ingredient_preference_init)
    
    
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

        ingr_recommend.ingr_recommend_score += 0.5 * pref_rating * percent/100
        ingr_recommend.save()

    for group in groups_lst:
        related_ingredients = IngredientGroup.objects.filter(group_id=group[0])
        for ingredient in related_ingredients:
            ingr_recommend = IngredientRecommend.objects.get(
                    ingr_id = ingredient.ingr_id,
                    user_id = user_id
            )

            ingr_recommend.ingr_recommend_score += 0.5 * group[1] * percent/100
            ingr_recommend.save()

        # substitutes = IngredientGroup.objects.filter(ingr_id=pref.ingr_id)
        # for sub in substitutes:
        #     Ing
        #     ingr_substitute = IngredientRecommend.objects.get_or_create(
        #             ingr_id = pref.ingr_id,
        #             defaults={
        #                 'user_id': user_id,
        #                 'ingr_recommend_score': 0
        #                 }
        #     )




# def recommend_cgd(request, user_id):
