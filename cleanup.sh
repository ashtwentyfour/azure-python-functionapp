#!/bin/bash

echo "Azure subscription ID = $1"
echo -e "Deleting Azure resource group - $2 \n"

# Azure login
echo -e "Cloud login \n"
az login
echo -e "\n"

# set subscription
az account set --subscription $1

# delete reources
echo -e "Deleting resource group $2 ... \n"
az group delete -n $2 --yes