<#PSScriptInfo

.VERSION 1.0

.GUID 

.AUTHOR simeononsecurity.ch

.COMPANYNAME SimeonOnSecurity

.COPYRIGHT 2020 SimeonOnSecurity. All rights reserved.

.TAGS Shodan PowerShell Modules ShodanPS cmdlet

.PROJECTURI https://github.com/simeononsecurity/Shodan_PS

.DESCRIPTION "Look up the IP address for the provided list of hostnames. Ex: Get-ShodanDNSResolve -domain google.com,bing.com -API"

.RELEASENOTES
Init

#>
function Get-ShodanDNSResolve {
param(
[string]$api,
[string]$domains
)
$apistring="&key=$api"
If (!$api){
    Write-Host "Please set the 'api' variable to your shodan API key."
}Else {
    If (!$domain){
        Write-Host "Please specify an domain address with -domain [string]"
    }Else {
        (Invoke-WebRequest -UseBasicParsing "https://api.shodan.io/dns/resolve?hostnames=$domain$apistring").content -Split {$_ -eq ',' -or $_ -eq '{' -or $_ -eq '}'} | ConvertFrom-String -Delimiter ":" -PropertyNames Domain, IP
    }
}
}
