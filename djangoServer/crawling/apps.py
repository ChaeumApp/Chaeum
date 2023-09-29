from django.apps import AppConfig
import logging

logger = logging.getLogger('my')

class CrawlingConfig(AppConfig):
    default_auto_field = 'django.db.models.BigAutoField'
    name = 'crawling'

    def ready(self):
        logger.info("apps.py ready method start...")
        from itemCrawler import main
        main.start()
