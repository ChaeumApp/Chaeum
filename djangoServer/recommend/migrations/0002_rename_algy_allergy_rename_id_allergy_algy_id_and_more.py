# Generated by Django 4.1.7 on 2023-09-22 14:08

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('recommend', '0001_initial'),
    ]

    operations = [
        migrations.RenameModel(
            old_name='Algy',
            new_name='Allergy',
        ),
        migrations.RenameField(
            model_name='allergy',
            old_name='id',
            new_name='algy_id',
        ),
        migrations.RenameField(
            model_name='allergy',
            old_name='name',
            new_name='algy_name',
        ),
        migrations.AlterModelTable(
            name='allergy',
            table='allergy_tb',
        ),
    ]