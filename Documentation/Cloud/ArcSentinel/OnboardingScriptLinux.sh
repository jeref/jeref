# Add the service principal application ID and secret here
servicePrincipalClientId="e1bb490a-aa4b-4883-b551-cfad1dccdcd1";
servicePrincipalSecret="YaG8Q~mKTWakmE1eSnJEDf2KpUhmAW~ZJXaa6ad5";


export subscriptionId="ac1db263-48ca-4eb2-9c5c-2903f6734dd3";
export resourceGroup="Azure-Arc-rg";
export tenantId="3b65fa04-6ed7-4bfe-a5c8-0523fd14d634";
export location="canadacentral";
export authType="principal";
export correlationId="9360e1d0-4a19-4015-902f-179b173ca7ab";
export cloud="AzureCloud";

# Download the installation package
output=$(wget https://aka.ms/azcmagent -O ~/install_linux_azcmagent.sh 2>&1);
if [ $? != 0 ]; then wget -qO- --method=PUT --body-data="{\"subscriptionId\":\"$subscriptionId\",\"resourceGroup\":\"$resourceGroup\",\"tenantId\":\"$tenantId\",\"location\":\"$location\",\"correlationId\":\"$correlationId\",\"authType\":\"$authType\",\"operation\":\"onboarding\",\"messageType\":\"DownloadScriptFailed\",\"message\":\"$output\"}" "https://gbl.his.arc.azure.com/log" &> /dev/null || true; fi;
echo "$output";

# Install the hybrid agent
bash ~/install_linux_azcmagent.sh;

# Run connect command
sudo azcmagent connect --service-principal-id "$servicePrincipalClientId" --service-principal-secret "$servicePrincipalSecret" --resource-group "$resourceGroup" --tenant-id "$tenantId" --location "$location" --subscription-id "$subscriptionId" --cloud "$cloud" --correlation-id "$correlationId";
