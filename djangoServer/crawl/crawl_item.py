import csv
import requests
import re
from bs4 import BeautifulSoup
from urllib import parse
from datetime import datetime
import pandas as pd
import os
import time
import sys
import django

current_dir = os.path.dirname(os.path.abspath(__file__))
parent_dir = os.path.abspath(os.path.join(current_dir, ".."))
sys.path.append(parent_dir)

# settings_module_path = os.path.abspath(os.path.join(current_dir, "../djangoServer/settings.py"))
os.environ.setdefault("DJANGO_SETTINGS_MODULE", "djangoServer.settings")
django.setup()
from recommend.models import Item
from djangoServer import settings

url = "https://www.coupang.com/np/search"
base_url = "https://www.coupang.com/"
path = "/content/drive/MyDrive/chaeum/"

headers = {"User-Agent":"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/116.0.0.0 Safari/537.36", "Accept-Language": "ko-KR,ko;q=0.8,en-US;q=0.5,en;q=0.3"}

# 검색 카테고리 설정

def cp_crawling(keyword, inclusions, exclusions, category, debug):
    print(f"""
    keyword : {keyword},
    inclusions: {inclusions},
    exclusions: {exclusions},
    category: {category},
    debug: {debug}
    """)

    result_list = []

    for page in range(1, 6): # 1페이지부터 5페이지까지 조회 (총 72*5 = 360개)
        params = {
            "q" : keyword,
            # 판매량 순 정렬 (관련 없는 상품이 상위에 올라갈 확률이 높아짐)
            # "sorter": "saleCountDesc",
            "listSize" : 72,
            "component" : category,
            "page" : page
            }

    time.sleep(0.1)
    res = requests.get(url, params=params, headers=headers)

    if res.status_code == 200:
        soup = BeautifulSoup(res.text) # 가져온 HTML 문서를 파서를 통해 BeautifulSoup 객체로 만듦
        item_list = soup.select('ul#productList li')
        error_cnt = 0

        for item in item_list:    
            try:
                ad_badge = item.find("span", attrs={"class": "ad-badge-text"})
                if ad_badge:
                    if debug: print("광고 상품 제외")
                    continue

                is_out_of_stock = item.find("div", attrs={"class": "out-of-stock"})
                if is_out_of_stock:
                    if debug: print("일시 품절 상품 제외")
                    continue

                item_name = item.select_one('div.name').text.strip()
                item_name_blankless = item_name
                item_name_blankless.replace(" ", "")

                if inclusions:
                    for i in inclusions:
                        i = i.replace(" ", "")
                        if i in item_name_blankless:
                            break
                        else:
                            if debug: print("포함 단어가 하나도 없는 상품 제외")
                            continue

                exclude_flag = False
                if exclusions:
                    for e in exclusions:
                        e = e.replace(" ", "")
                        if e and e in item_name_blankless:
                            if debug: print("제외 단어 하나라도 있는 상품 제외")
                            exclude_flag = True
                            continue
                        if exclude_flag:
                            continue

                id = item.select_one('a').get('data-item-id')

                link = item.select_one('a').get('href')
                link = parse.urljoin(base_url, link)

                thumbnail = item.select_one('img.search-product-wrap-img').get('data-img-src')
                if not thumbnail:
                    thumbnail = item.select_one('img.search-product-wrap-img').get('src')
                thumbnail = parse.urljoin(base_url, thumbnail)

                price = item.select_one('strong.price-value').text.strip()
                price = ''.join(price.split(','))

                # item_obj = Item(
                #     item_name = item_name,
                #     item_image = thumbnail,
                #     item_price = int(price),
                #     item_store = "Coupang",
                #     item_storelink = link,
                #     item_crawling_date = datetime.now().date()
                # )
                result_list.append([id, item_name, price, link, thumbnail])
            except Exception as e:
                print(e)
                error_cnt += 1

    date = datetime.now().strftime('%Y-%m-%d')

    filename = f'coupang_{keyword}'
    df = pd.DataFrame(result_list, columns = ['id', 'title', 'price', 'link', 'thumbnail'])
    if not os.path.exists(path + date):
        os.makedirs(path + date)
    df.to_csv(path + date + "/" + filename +".csv", index=True, encoding="UTF-8")

    if debug:
        print(f'error 발생 횟수 : {error_cnt}')

    length = len(result_list)
    print(f"갯수: {length}")

    if 100 <= length < 300:
        return None
    else:
        return [keyword, length]


FOOD = 194176
FRUIT = 194182
VEGETABLE = 194332
MEAT = 194588
FISH = 194729
MILK = 195683
KIMCHI = 432495
NOODLE = 195343
POWDER = 195476
BREAD = 195166

debug = False

num_to_category = [
    None,
    FOOD,
    VEGETABLE,
    FOOD,
    MEAT,
    FISH,
    MILK,
    KIMCHI,
    NOODLE,
    NOODLE,
    POWDER,
    FOOD,
    BREAD
]

small_lst = []
big_lst = []

for i in range(1, 12):
    num = str(i).zfill(2)
    with open(path + f'subcate_list/subcategory_{num}.csv', 'r', encoding='UTF-8') as file:
        category = num_to_category[i]
        r = csv.reader(file)

    for line in r:
        keyword, inclusions, exclusions = line
        inclusions = list(inclusions.split(","))
        exclusions = list(exclusions.split(","))

        result = cp_crawling(keyword, inclusions, exclusions, category, debug)
        if result:
            if result[1]>200:
                big_lst.append(result)
            else:
                small_lst.append(result)

print(sorted(small_lst,key=lambda x:x[1]))
print(sorted(big_lst,key=lambda x:x[1], reverse=True))