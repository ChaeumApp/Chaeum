from django.db import models

# Create your models here.
class IngredientPreference(models.Model):
    ingr_pref_pk = models.IntegerField(primary_key=True)
    user = models.ForeignKey('User', on_delete=models.CASCADE)
    ingr = models.ForeignKey('Ingredient', on_delete=models.CASCADE)
    pref_rating = models.FloatField(null=True)

    class Meta:
        db_table = "ingredient_preference_tb"
        constraints = [
            models.UniqueConstraint(
                fields = ['user_id', 'ingr_id'],
                name = 'preference id'
            )
        ]

class IngredientRecommend(models.Model):
    ingr_recommend_pk = models.IntegerField(primary_key=True)
    user = models.ForeignKey('User', on_delete=models.CASCADE)
    ingr = models.ForeignKey('Ingredient', on_delete=models.CASCADE)
    ingr_recommend_score = models.FloatField(null=True)

    class Meta:
        db_table = "ingredient_recommend_tb"
        constraints = [
            models.UniqueConstraint(
                fields = ['user_id', 'ingr_id'],
                name = 'recommend id'
            )
        ]
        

class Ingredient(models.Model):
    ingr_id = models.IntegerField(primary_key=True)
    ingr_name = models.CharField(max_length=30)
    subcat = models.ForeignKey('Subcat', on_delete=models.CASCADE, null=True)
    cat = models.ForeignKey('Category', on_delete=models.CASCADE)

    class Meta:
        db_table = "ingredient_tb"


class Subcat(models.Model):
    subcat_id = models.SmallIntegerField(primary_key=True)
    subcat_name = models.CharField(max_length=30)
    cat = models.ForeignKey('Category', on_delete=models.CASCADE)

    class Meta:
        db_table = "subcat_tb"

class Category(models.Model):
    cat_id = models.SmallIntegerField(primary_key=True)
    cat_name = models.CharField(max_length=30)
    
    class Meta:
        db_table = "category_tb"


class User(models.Model):
    user_id = models.IntegerField(primary_key=True)
    user_email = models.CharField(max_length=50, null=True)
    user_pwd = models.CharField(max_length=100)
    user_birthday = models.DateField(null=True)
    user_gender = models.CharField(max_length=5, null=True)
    user_activated = models.BooleanField(default=False)
    vegan = models.ForeignKey('Vegan', on_delete=models.CASCADE)
    
    class Meta:
        db_table = "user_tb"


class Vegan(models.Model):
    vegan_id = models.IntegerField(primary_key=True)
    vegan_name = models.CharField(max_length=50)

    class Meta:
        db_table = "vegan_tb"

class IngredientPrice(models.Model):
    ingr_price_id = models.IntegerField(primary_key=True)
    ingr = models.ForeignKey('Ingredient', on_delete=models.CASCADE)
    date = models.DateField()
    price = models.IntegerField()

    class Meta:
        db_table = "ingredient_price_tb"
        constraints = [
            models.UniqueConstraint(
                fields = ['ingr_id', 'date'],
                name = 'ingredient date id'
            )
        ]