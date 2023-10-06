from django.shortcuts import render
from django.http import HttpResponse

import os
import sys
import django

from implicit.als import AlternatingLeastSquares as ALS

from scipy.sparse import csr_matrix
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
    start_time = time.time()
    # 존재하는 모든 user_id를 가져옴
    user_ids = User.objects.values_list('user_id', flat=True)
    # ingredient는 중간에 빠진 값이 없어 개수로 가져옴
    ingr_num = len(Ingredient.objects.all())
    recommend_lst  = [0] * (ingr_num + 1)

    def recommend_substitute(request, user_id, weight):
        nonlocal recommend_lst
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
                update_dict[group_id] += 0.000001 * pref_rating * weight

        # 그룹별로 스코어 업데이트
        for group_id, pref_rating in update_dict.items():
            # 해당 그룹에 속하는 모든 재료
            ingredients = IngredientGroup.objects.filter(group_id=group_id)

            # 사용자의 재료에 해당하는 recommend_lst 업데이트
            for ingredient in ingredients:
                recommend_lst[ingredient.ingr_id] += pref_rating
    
    def recommend_month(request, user_id, ingr_num, weight):
        nonlocal recommend_lst

        if weight == 0:
            return
        
        today = datetime.date.today()
        this_month = int(today.strftime('%m'))
        ingredient_month_data = IngredientMonth.objects.filter(month_id=this_month).values('ingr_id')

        for item in ingredient_month_data:
            ingr_id = item['ingr_id']
            recommend_lst[ingr_id] += 0.003 * weight

    # userid를 키로 갖고 idx를 값으로 갖는 dictionary 생성
    userid_to_idx = {value: index for index, value in enumerate(user_ids)}
    print(userid_to_idx)

    # 선호도를 추천 점수로 갖는 초기 R 생성
    ingr_prefs = IngredientPreference.objects.all()
    R = np.zeros((len(user_ids), ingr_num+1))
    for ingr_pref in ingr_prefs:
        R[userid_to_idx[ingr_pref.user_id]][ingr_pref.ingr_id] = ingr_pref.pref_rating

    R = csr_matrix(R)

    model = ALS(iterations=15, regularization=0.5, factors=25)
    model.fit(R)
    
    recommendations = model.recommend(userid_to_idx[user_id], R[userid_to_idx[user_id]], N=ingr_num, filter_already_liked_items=False)
        
    idxs, values = recommendations
    for k in range(ingr_num):
        recommend_lst [idxs[k]] = values[k]

    recommend_substitute(request, user_id, 1)
    recommend_month(request, user_id, ingr_num, 1)

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

    end_time = time.time()
    print(end_time - start_time)

    response = HttpResponse("Recommendation process completed successfully")
    return response
    
            
