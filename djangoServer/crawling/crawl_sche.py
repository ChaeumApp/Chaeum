from apscheduler.schedulers.background import BackgroundScheduler
from django_apscheduler.jobstores import register_events, DjangoJobStore
from .crawl_item import main
from .noti_price import IngredientPriceManager
from apscheduler.triggers.cron import CronTrigger
from django.conf import settings
import logging

logger = logging.getLogger()

def start():
    scheduler = BackgroundScheduler(timezone=settings.TIME_ZONE)
    scheduler.add_jobstore(DjangoJobStore(), 'default')

    scheduler.add_job(
        main,
        trigger=CronTrigger(hour="00", minute="20"),
        id = "main",
        max_instances=1,
        replace_existing=True
    )
    
    # scheduler.add_job(
    #     IngredientPriceManager.notify_pricedrop,
    #     trigger=CronTrigger(hour="12", minute="0"),
    #     id = "notiPrice",
    #     max_instances=1,
    #     replace_existing=True
    # )
    
    register_events(scheduler)

    try:
        logger.info("Starting scheduler...")
        scheduler.start()
    except KeyboardInterrupt:
        logger.info("Stopping scheduler...")
        scheduler.shutdown()