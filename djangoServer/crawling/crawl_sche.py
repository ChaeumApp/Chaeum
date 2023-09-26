# import sys
# import os
# import django
# current_dir = os.path.dirname(os.path.abspath(__file__))
# parent_dir = os.path.abspath(os.path.join(current_dir, ".."))
# sys.path.append(parent_dir)
# os.environ.setdefault("DJANGO_SETTINGS_MODULE", "djangoServer.settings")
# django.setup()

from apscheduler.schedulers.background import BackgroundScheduler
from django_apscheduler.jobstores import register_events, DjangoJobStore
from .crawl_item import main
from apscheduler.triggers.cron import CronTrigger
from django.conf import settings

def start():
    scheduler = BackgroundScheduler(timezone=settings.TIME_ZONE)
    scheduler.add_jobstore(DjangoJobStore(), 'default')

    scheduler.add_job(
        main,
        trigger=CronTrigger(hour="04", minute="00"),
        id = "crawl",
        max_instances=1,
        replace_existing=True
    )
    
    register_events(scheduler)

    try:
        scheduler.start()
    except KeyboardInterrupt:
        scheduler.shutdown()