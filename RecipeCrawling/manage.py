#!/usr/bin/env python
"""Django's command-line utility for administrative tasks."""
import os
import sys

import requests, json
from bs4 import BeautifulSoup
import pandas as pd
import time

def food_info(page_num):
    '''
    This function gives you food information for the given input.

    PARAMETERS
        - name(str): name of Korean food in Korean ex) food_info("김치찌개")
    RETURN
        - res(list): list of dict that containing info for some Korean food related to 'name'
            - res['name'](str): name of food
            - res['ingredients'](str): ingredients to make the food
            - res['recipe'](list[str]): contain recipe in order
    '''
    url = f"https://www.10000recipe.com/profile/recipe.html?uid=gdubu33&page={page_num}"
    response = requests.get(url)
    if response.status_code == 200:
        html = response.text
        soup = BeautifulSoup(html, 'html.parser')
    else:
        print("HTTP response error :", response.status_code)
        return
    food_list = soup.find_all(attrs={'class': 'thumbnail'})
    res = []

    for recipeNum in range(0, 20):
        food_id = food_list[recipeNum]['href'].split('/')[-1]
        new_url = f'https://www.10000recipe.com/recipe/{food_id}'
        headers = {'user-agent' : 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/116.0.0.0 Safari/537.36'}
        new_response = requests.get(new_url, headers=headers)
        if new_response.status_code == 200:
            html = new_response.text
            soup = BeautifulSoup(html, 'html.parser')
        else:
            print("HTTP response error :", response.status_code)
            return
        try:
            food_info = soup.find(attrs={'type': 'application/ld+json'})
            result = json.loads(food_info.text)
            # Find the iframe element by its id
            iframe = soup.find('iframe', id='ifrmRecipeVideo')

            # Get the value of the org_src attribute
            org_src_value = iframe.get('org_src')
        except:
            continue
        name = result['name']
        if "recipeIngredient" not in result:
            continue

        ingredient = ','.join(result['recipeIngredient'])
        recipe = [result['recipeInstructions'][i]['text'] for i in range(len(result['recipeInstructions']))]
        thumbnail = result['image'][0]
        for i in range(len(recipe)):
            recipe[i] = f'{i + 1}. ' + recipe[i]

        dic = {'name': name, 'ingredient': ingredient, 'recipe': recipe, 'thumbnail': thumbnail, 'youtube': org_src_value }
        res.append(dic)
    return res

def main():
    # -*- coding: utf-8 -*-
    """Run administrative tasks."""
    os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'djangoProject.settings')
    ingredients = {}
    try:
        from django.core.management import execute_from_command_line
        start_page = 231
        end_page = 245
        for i in range(start_page, end_page):
            results = food_info(i)
            for j in range(0, len(results)):
                ingredients[20*(i-1)+j] = results[j]
            #     ingredient_info = results[j]['ingredient'].split(',')
            #     for c in ingredient_info:
            #         sentence = c.split(' ')[:-1]
            #         full_ingredient = ""
            #         for idx, ingredient in enumerate(sentence):
            #             if ingredient.startswith(ingredients_exception) and idx != 0:
            #                 pass
            #             else:
            #                 full_ingredient = full_ingredient + " " + ingredient
            #         if full_ingredient in ingredients:
            #             ingredients[full_ingredient] += 1
            #         else:
            #             ingredients[full_ingredient] = 1
            print(i)
            if i != end_page:
                print("잠들게요")
                time.sleep(10)
                print("깼어요")
            # print(ingredients)
            # print()
    except ImportError as exc:
        raise ImportError(
            "Couldn't import Django. Are you sure it's installed and "
            "available on your PYTHONPATH environment variable? Did you "
            "forget to activate a virtual environment?"
        ) from exc

    columns = ["name", "ingredient", "recipe", "thumbnail", "youtube"]
    file_name = "./10000recipe.xlsx"

    df = pd.DataFrame(ingredients, index=columns)
    df.transpose()
    df.to_excel(file_name, sheet_name="New", index=False)

    execute_from_command_line(sys.argv)


if __name__ == '__main__':
    main()
