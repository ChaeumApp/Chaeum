from django.shortcuts import get_object_or_404
from recommend.models import Item, IngredientPrice
from django.http import JsonResponse
import re

def update_price(ingr_id, item_crawling_date):
    items = Item.objects.filter(ingr_id=ingr_id, item_crawling_date=item_crawling_date)
    if len(items) == 0:
        return
    
    def find_gram(title):
        g_pattern = r'(\d+(\.\d+)?)g'
        kg_pattern = r'(\d+(\.\d+)?)kg'
        ml_pattern = r'(\d+(\.\d+)?)ml'
        l_pattern = r'(\d+(\.\d+)?)L'
        g_matches = re.findall(g_pattern, title, re.IGNORECASE)
        kg_matches = re.findall(kg_pattern, title, re.IGNORECASE)
        ml_matches = re.findall(ml_pattern, title, re.IGNORECASE)
        l_matches = re.findall(l_pattern, title, re.IGNORECASE)

        if kg_matches:
            return float(kg_matches[-1][0]) * 1000
        elif g_matches:
            return float(g_matches[-1][0])
        elif ml_matches:
            return float(ml_matches[-1][0])
        elif l_matches:
            return float(l_matches[-1][0]) * 1000
        return None

    def find_pieces(title):
        pcs_pattern = r'(\d+)개(?!입)'
        pcs_matches = re.findall(pcs_pattern, title, re.IGNORECASE)
        pcs_matches = list(map(int, pcs_matches))
        if pcs_matches:
            return min(pcs_matches)
        else:
            return 1
        
    def trimmed_mean(price_per_gram):
        # 배열을 정렬
        sorted_prices = sorted(price_per_gram)
        
        # 상위 20%와 하위 20%의 인덱스를 구함
        n = len(sorted_prices)
        lower_index = int(0.2 * n)
        upper_index = n - lower_index

        # 상위 20%와 하위 20% 값을 제외한 중간 범위의 값들을 가져옴
        trimmed_prices = sorted_prices[lower_index:upper_index]
        if len(trimmed_prices) == 0:
            return -1
        else:
            # 평균값을 반환
            return sum(trimmed_prices) / len(trimmed_prices)


    price_per_100g = []

    for item in items:
        title = item.item_name
        price = item.item_price
        gram = find_gram(title)
        pieces = find_pieces(title)
        
        if gram:
            if gram * pieces == 0: pass
            else: price_per_100g.append(100 * price // (gram * pieces))

    average_price = trimmed_mean(price_per_100g)
    if average_price == -1:
        print(f'소분류 {ingr_id}의 trimmed_prices가 없습니다.')

    if average_price is not None:
        new_price = IngredientPrice(ingr_id=ingr_id, date=item_crawling_date, price=average_price)
        new_price.save()

    return JsonResponse({'average_price_per_100g': average_price}, safe=False)
