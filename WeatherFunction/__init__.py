"""HTTP trigger handler"""
import logging
import json

import azure.functions as func
from . import weather

def main(req: func.HttpRequest) -> func.HttpResponse:
    """Function execution"""
    logging.info('Python weather function processed a request')

    city = req.params.get('city')
    country = req.params.get('country')
    if not city or not country:
        try:
            req_body = req.get_json()
        except ValueError:
            pass
        else:
            city = req_body.get('city')
            country = req_body.get('country')

    forecast = weather.daily_forecast(city, country)

    if forecast['cod'] == 200:
        return func.HttpResponse(json.dumps(forecast), status_code=200)

    return func.HttpResponse(json.dumps(forecast), status_code=int(forecast['cod']))
