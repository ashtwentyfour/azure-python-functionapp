import logging
import os
import requests

def daily_forecast(city, country):
    """Fetch weather data for city-country"""
    api_key = os.getenv('API_KEY')
    req_url = 'https://api.openweathermap.org/data/2.5/weather?q=' + \
               city + ',' + country + \
               '&appid=' + api_key + '&units=metric'
    try:
        response = requests.get(req_url)
        response.raise_for_status()
    except requests.exceptions.HTTPError as herr:
        logging.error(herr)
    except requests.exceptions.ConnectionError as cerr:
        logging.error(cerr)
    except requests.exceptions.Timeout as terr:
        logging.error(terr)
    except requests.exceptions.RequestException as err:
        logging.error(err)

    return response.json()
