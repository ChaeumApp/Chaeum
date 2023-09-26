from django.apps import AppConfig


class CrawlingConfig(AppConfig):
    default_auto_field = 'django.db.models.BigAutoField'
    name = 'crawling'

    def ready(self):
        from . import crawl_sche
        crawl_sche.start()
