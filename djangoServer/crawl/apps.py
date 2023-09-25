from django.apps import AppConfig
from django.conf import settings


class CrawlConfig(AppConfig):
    default_auto_field = 'django.db.models.BigAutoField'
    name = 'crawl'

    def ready(self):
        if settings.SCHEDULER_DEFAULT:
            from . import crawl_sche
            crawl_sche.start()
