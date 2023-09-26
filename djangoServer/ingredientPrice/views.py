from django.shortcuts import get_object_or_404
from recommend.models import Item, IngredientPrice
from django.http import JsonResponse
import re

def update_price(request, ingr_id, item_crawling_date):
    items = Item.objects.filter(ingr_id=ingr_id, item_crawling_date=item_crawling_date)
    
    def find_gram(title):
        g_pattern = r'(\d+(\.\d+)?)g'
        kg_pattern = r'(\d+(\.\d+)?)kg'
        g_matches = re.findall(g_pattern, title, re.IGNORECASE)
        kg_matches = re.findall(kg_pattern, title, re.IGNORECASE)

        if kg_matches:
            return float(kg_matches[-1][0]) * 1000
        elif g_matches:
            return float(g_matches[-1][0])
        return None

    def find_pieces(title):
        pcs_pattern = r'(\d+)개(?!입)'
        pcs_matches = re.findall(pcs_pattern, title, re.IGNORECASE)
        pcs_matches = list(map(int, pcs_matches))
        if pcs_matches:
            return min(pcs_matches)
        else:
            return 1
    
    for item in items:
        title = item.item_name
        price = item.item_price
        gram = find_gram(title)
        pieces = find_pieces(title)
        
        if gram:
            item.price_per_100g = 100 * price // (gram * pieces)
            item.save()  # 변경 사항 저장
    
    # 새로운 값으로 업데이트 된 아이템들을 반환
    updated_items = [
        {
            'item_id': item.item_id,
            'price_per_100g': item.price_per_100g,
        }
        for item in items
    ]
    valid_items = [item for item in items if item.price_per_100g is not None and item.price_per_100g >= 0]

    # valid_items가 비어있지 않은지 확인
    if valid_items:
        sorted_items = sorted(valid_items, key=lambda x: x.price_per_100g)
        total_items = len(sorted_items)
        
        # 상위 및 하위 20%의 인덱스를 찾기
        lower_bound_index = total_items * 20 // 100
        upper_bound_index = total_items - lower_bound_index
        
        # 상위 및 하위 20%를 제외한 아이템들의 price_per_100g의 평균 계산
        middle_items = sorted_items[lower_bound_index:upper_bound_index]
        
        # middle_items가 비어있지 않은지 확인
        if middle_items:
            average_price = sum(item.price_per_100g for item in middle_items) / len(middle_items)
        else:
            average_price = None
    else:
        average_price = None

    if average_price is not None:
        new_price = IngredientPrice(ingr_id=ingr_id, date=item_crawling_date, price=average_price)
        new_price.save()

    return JsonResponse({'average_price_per_100g': average_price}, safe=False)

