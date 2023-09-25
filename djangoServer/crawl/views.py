import datetime
from django.shortcuts import render
# from .models import Subscription

def expiry_check():
    # 날짜 세팅
    today = datetime.date.today()

    # Subscriptions = Subscription.objects.filter(expiry = False)

    # if len(Subscriptions) != 0:
    #     for sub in Subscriptions:
    #         if sub.end_date < today:
    #             sub.expiry = True
    #             sub.save()
