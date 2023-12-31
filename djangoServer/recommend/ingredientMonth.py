import os
import sys
import django


current_dir = os.path.dirname(os.path.abspath(__file__))
parent_dir = os.path.abspath(os.path.join(current_dir, ".."))
sys.path.append(parent_dir)

os.environ.setdefault("DJANGO_SETTINGS_MODULE", "djangoServer.settings")

django.setup()

from recommend.models import *
arr = [
["잣",
"자몽",
"한라봉",
"도미",
"멸치",
"생태",
"삼치",
"조기",
"홍어",
"개불",
"과메기",
"꼬막",
"낙지",
"대게",
"매생이",
"문어",
"생미역",
"홍게",
"더덕",
"딸기",
"시금치",
"연근",
"우엉",],
["잣",
"자몽",
"한라봉",
"도미",
"멸치",
"삼치",
"조기",
"홍어",
"개불",
"꼬막",
"낙지",
"대게",
"매생이",
"문어",
"바지락",
"홍게",
"더덕",
"딸기",
"시금치",
"연근",
"우엉",],
["자몽",
"한라봉",
"도다리",
"도미",
"멸치",
"홍어",
"꼬막",
"대게",
"매생이",
"문어",
"바지락",
"소라",
"쭈꾸미",
"톳",
"홍게",
"더덕",
"딸기",
"마늘",
"미나리",
"부추",
"비트",
"애호박",
"양배추",
"연근",
"우엉",],
["도다리",
"우럭",
"홍어",
"꽃게",
"대게",
"매생이",
"문어",
"바지락",
"소라",
"쭈꾸미",
"톳",
"홍게",
"가지",
"고사리",
"더덕",
"두릅",
"딸기",
"마늘",
"미나리",
"부추",
"비트",
"애호박",
"양배추",
"양파",
"오이",],
["매실",
"도다리",
"메로",
"병어",
"우럭",
"장어",
"꽃게",
"다슬기",
"생다시마",
"대게",
"매생이",
"멍게",
"소라",
"쭈꾸미",
"톳",
"홍게",
"가지",
"고사리",
"두릅",
"딸기",
"마늘",
"부추",
"비트",
"애호박",
"양배추",
"양파",
"오이",
"죽순",
"파프리카",
"피망",],
["매실",
"살구",
"오렌지",
"참외",
"메로",
"병어",
"장어",
"꽃게",
"다슬기",
"생다시마",
"소라",
"한치",
"홍게",
"가지",
"감자",
"고추",
"복분자",
"부추",
"비트",
"애호박",
"양배추",
"양파",
"오이",
"파프리카",
"피망",
],
["복숭아",
"살구",
"오렌지",
"자두",
"참외",
"갈치",
"병어",
"생다시마",
"소라",
"오징어",
"한치",
"가지",
"감자",
"고추",
"도라지",
"멜론",
"복분자",
"부추",
"블루베리",
"수박",
"아욱",
"애호박",
"양상추",
"양파",
"오이",
"옥수수",
"토마토",
"파프리카",
"피망",],
["잣",
"복숭아",
"오렌지",
"자두",
"참외",
"포도",
"갈치",
"민어",
"병어",
"오징어",
"전복",
"한치",
"가지",
"감자",
"고구마",
"고추",
"도라지",
"멜론",
"복분자",
"부추",
"블루베리",
"생강",
"수박",
"아욱",
"애호박",
"양상추",
"옥수수",
"토마토",],
["땅콩",
"잣",
"귤",
"모과",
"배",
"석류",
"오렌지",
"포도",
"갈치",
"고등어",
"광어",
"연어",
"조기",
"굴",
"꽃게",
"낙지",
"새우",
"오징어",
"전복",
"홍게",
"감자",
"고구마",
"고추",
"당근",
"대파",
"멜론",
"부추",
"블루베리",
"생강",
"애호박",
"야콘",
"옥수수",
"은행",
"쪽파",
"토마토",],
["땅콩",
"잣",
"단감",
"홍시",
"귤",
"모과",
"배",
"사과",
"석류",
"오렌지",
"포도",
"가자미",
"갈치",
"고등어",
"광어",
"꽁치",
"삼치",
"연어",
"전어",
"조기",
"굴",
"꽃게",
"낙지",
"새우",
"오징어",
"전복",
"해삼",
"홍게",
"홍합",
"고구마",
"고추",
"늙은호박",
"당근",
"대파",
"마",
"멜론",
"무",
"브로콜리",
"생강",
"애호박",
"야콘",
"연근",
"쪽파",],
["땅콩",
"잣",
"단감",
"홍시",
"귤",
"배",
"사과",
"석류",
"가자미",
"고등어",
"광어",
"꽁치",
"도미",
"멸치",
"삼치",
"전어",
"조기",
"홍어",
"가리비",
"과메기",
"굴",
"꼬막",
"꽃게",
"낙지",
"대게",
"매생이",
"문어",
"새우",
"오징어",
"해삼",
"홍게",
"홍합",
"고추",
"늙은호박",
"당근",
"대파",
"마",
"무",
"배추",
"브로콜리",
"생강",
"시금치",
"연근",
"유자",
"쪽파",
"콜라비",],
["잣",
"귤",
"사과",
"석류",
"자몽",
"한라봉",
"가자미",
"광어",
"도미",
"멸치",
"생태",
"삼치",
"조기",
"홍어",
"가리비",
"과메기",
"굴",
"꼬막",
"낙지",
"대게",
"매생이",
"문어",
"생미역",
"새우",
"홍게",
"홍합",
"늙은호박",
"대파",
"무",
"배추",
"브로콜리",
"시금치",
"연근",
"유자",
"쪽파",
"콜라비",],
]

for month_id, lst in enumerate(arr, start=1):
    for ingr_name in lst:
        try:
            ingr_instance = Ingredient.objects.get(ingr_name=ingr_name)
            ingr_id = ingr_instance.ingr_id
            print((month_id, ingr_id), end="")
            print(",")
        except:
            raise KeyError
        