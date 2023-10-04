from recommend.models import *
from django.db.models import F, ExpressionWrapper, FloatField, Subquery, OuterRef
from datetime import datetime, timedelta
import firebase_admin
from firebase_admin import credentials, messaging

import logging
logger = logging.getLogger('my')

class IngredientPriceManager():
    @classmethod
    def notify_pricedrop(cls):
        today = datetime.now().date()
        yesterday = today - timedelta(days=1)

        yesterday_price_subquery = IngredientPrice.objects.filter(ingr_id=OuterRef('ingr_id'), date=yesterday).values('price')
        today_price_subquery = IngredientPrice.objects.filter(ingr_id=OuterRef('ingr_id'), date=today).values('price')

        prices_combined = IngredientPrice.objects.filter(date=today).annotate(
            yesterday_price=Subquery(yesterday_price_subquery),
            today_price=Subquery(today_price_subquery),
            price_difference=ExpressionWrapper(
                F('today_price') - F('yesterday_price'),
                output_field=FloatField()
            )
        )

        dropped_ingr_ids = prices_combined.filter(price_difference__lt=-0.3 * F('yesterday_price')).values_list('ingr_id', flat=True)
        logger.info(list(set(dropped_ingr_ids)))
        
        if dropped_ingr_ids:
            for ingr_id in dropped_ingr_ids:
                cls.send_notification(ingr_id)

    @classmethod
    def send_notification(cls, ingr_id):
        # 1. saved_ingredient_tb에서 ingr_id를 가지고 있는 모든 데이터를 조회하여 user_id를 리스트로 모음
        users_with_ingr = SavedIngredient.objects.filter(ingr_id=ingr_id).values_list('user_id', flat=True)

        # 2. user_devtoken_tb에서 user_id에 해당하는 token_id를 찾아 하나의 리스트로 모음
        tokens = UserDeviceToken.objects.filter(user_id__in=users_with_ingr).values_list('token_id', flat=True)

        # 3. Firebase FCM을 사용하여 알림을 보냅니다.
        if tokens:
            ingr_name = Ingredient.objects.get(ingr_id=ingr_id).ingr_name
            price_change_percent = IngredientPrice.objects.get(ingr_id=ingr_id, date=datetime.now().date()).price_change_percent
            message = messaging.MulticastMessage(
                tokens=list(tokens),
                notification=messaging.Notification(
                    title="채움 가격 하락 알림",
                    body=f"{ingr_name}의 가격이 어제보다 {price_change_percent:.2f}% 하락했어요!"
                )
            )
            try:
                response = messaging.send_multicast(message)
                print("Successfully sent message:", response)
            except Exception as e:
                print("Error sending message:", e)
