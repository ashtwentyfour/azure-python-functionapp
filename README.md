# Simple Azure Python Function App

Azure [Python function](https://docs.microsoft.com/en-us/azure/azure-functions/create-first-function-vs-code-python) which fetches weather data for a city/town using the [OpenWeather](https://openweathermap.org/) API

### Prerequisites

* OpenWeather [subscription](https://openweathermap.org/api)
* Azure [subscription](https://azure.microsoft.com/en-ca/pricing/purchase-options/pay-as-you-go/)
* Azure [command-line interface (CLI)](https://docs.microsoft.com/en-us/cli/azure/)
* [Azure Functions Core Tools](https://docs.microsoft.com/en-us/azure/azure-functions/functions-run-local?tabs=v4%2Cmacos%2Ccsharp%2Cportal%2Cbash)

### Deployment

* Set OpenWeather ```API_KEY``` environment variable:

```bash
export API_KEY=XXXX
```

* Automated deployment example:

```bash
./deploy.sh f7e82efd-3aae-423e-b194-xxxxxxxxxxxx function-rg-1 eastus functionsa2022 weather-function-2022
```

```f7e82efd-3aae-423e-b194-xxxxxxxxxxxx``` - Azure subscription ID
```function-rg-1``` - Azure resource group that will be created
```eastus``` - Azure region
```functionsa2022``` - Azure storage account that will be created
```weather-function-2022``` - Azure functionapp name

* Cleanup resources:

```bash
./cleanup.sh f7e82efd-3aae-423e-b194-xxxxxxxxxxxx function-rg-1
```

```f7e82efd-3aae-423e-b194-xxxxxxxxxxxx``` - Azure subscription ID
```function-rg-1``` - Azure resource group that will be deleted

* The deploy script will output a sample request URL if the deployment is successful

```bash
Example invocation => curl -X GET 'https://weather-function-2022.azurewebsites.net/api/WeatherFunction?country=ca&city=Cambridge'
```