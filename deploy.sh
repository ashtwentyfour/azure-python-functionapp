#!/bin/bash

echo "Azure subscription ID = $1"
echo "Azure resource group = $2"
echo "Azure region = $3"
echo "Azure storage account = $4"
echo -e "Azure functionapp = $5 \n"

# Azure login
echo -e "Cloud login \n"
az login
echo -e "\n"

# set subscription
echo -e "Setting subscription... \n"
az account set --subscription $1
echo -e "Azure subscription successfully set to - $1 \n"

# create resource group
echo -e "Creating resource group... \n"
az group create --location $3 --resource-group $2
echo -e "\n"

# create storage account
echo -e "Creating storage account... \n"
az storage account create -n $4 -g $2 -l $3 --sku Standard_LRS
echo -e "\n"

# create functionapp
echo -e "Creating function app... \n"
az functionapp create -g $2 -n $5 --runtime python -s $4 --os-type Linux --consumption-plan-location $3 --runtime-version 3.8
echo -e "\n"

sleep 30

# deploy function code
echo -e "Deploying source code... \n"
cd weather-function && func azure functionapp publish $5
echo -e "\n"

# set environment variable
echo -e "Setting API_KEY environment variable... \n"
az functionapp config appsettings set --name $5 --resource-group $2 --settings "API_KEY=$API_KEY"
echo -e "\n"

# get invocation URL example
functionHostName=$(az functionapp show --name $5 --resource-group $2 --query "defaultHostName" --output tsv)
functionUrlExample="https://$functionHostName/api/WeatherFunction?country=ca&city=Cambridge"
echo "Example invocation => curl -X GET '$functionUrlExample'"
