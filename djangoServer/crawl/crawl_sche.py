from apscheduler.schedulers.background import BackgroundScheduler
from django_apscheduler.jobstores import register_events, DjangoJobStore
from .views import expiry_check

def start():
    scheduler = BackgroundScheduler(timezone = settings.Time_ZONE)
    scheduler.add_jobstore(DjangoJobStore, 'default')
    register_events(scheduler)
    @scheduler.scheduled_job('cron', hour = 23, name = 'expiry_check')

    def auto_check():
        expiry_check()
    scheduler.start()