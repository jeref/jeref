try {
    # Add the service principal application ID and secret here
    $servicePrincipalClientId="e1bb490a-aa4b-4883-b551-cfad1dccdcd1";
    $servicePrincipalSecret="YaG8Q~mKTWakmE1eSnJEDf2KpUhmAW~ZJXaa6ad5";

    $env:SUBSCRIPTION_ID = "ac1db263-48ca-4eb2-9c5c-2903f6734dd3";
    $env:RESOURCE_GROUP = "Azure-Arc-rg";
    $env:TENANT_ID = "3b65fa04-6ed7-4bfe-a5c8-0523fd14d634";
    $env:LOCATION = "canadacentral";
    $env:AUTH_TYPE = "principal";
    $env:CORRELATION_ID = "4488a9b0-ca45-41ff-94f5-14064ceb3954";
    $env:CLOUD = "AzureCloud";

    [Net.ServicePointManager]::SecurityProtocol = [Net.ServicePointManager]::SecurityProtocol -bor 3072;

    # Download the installation package
    Invoke-WebRequest -UseBasicParsing -Uri "https://aka.ms/azcmagent-windows" -TimeoutSec 30 -OutFile "$env:TEMP\install_windows_azcmagent.ps1";

    # Install the hybrid agent
    & "$env:TEMP\install_windows_azcmagent.ps1";
    if ($LASTEXITCODE -ne 0) { exit 1; }

    # Run connect command
    & "$env:ProgramW6432\AzureConnectedMachineAgent\azcmagent.exe" connect --service-principal-id "$servicePrincipalClientId" --service-principal-secret "$servicePrincipalSecret" --resource-group "$env:RESOURCE_GROUP" --tenant-id "$env:TENANT_ID" --location "$env:LOCATION" --subscription-id "$env:SUBSCRIPTION_ID" --cloud "$env:CLOUD" --correlation-id "$env:CORRELATION_ID";
}
catch {
    $logBody = @{subscriptionId="$env:SUBSCRIPTION_ID";resourceGroup="$env:RESOURCE_GROUP";tenantId="$env:TENANT_ID";location="$env:LOCATION";correlationId="$env:CORRELATION_ID";authType="$env:AUTH_TYPE";operation="onboarding";messageType=$_.FullyQualifiedErrorId;message="$_";};
    Invoke-WebRequest -UseBasicParsing -Uri "https://gbl.his.arc.azure.com/log" -Method "PUT" -Body ($logBody | ConvertTo-Json) | out-null;
    Write-Host  -ForegroundColor red $_.Exception;
}
