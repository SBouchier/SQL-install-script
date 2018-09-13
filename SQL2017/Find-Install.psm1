<#
.SYNOPSIS
A function to check if a service is running for the newly created instance.

.DESCRIPTION
This function takes an instance name as an input and searches the
machine's services for any matching services, then returns them.
Can be called automatically via a -FindInstall switch on the SQL2017
function or it may be called manually by the end user.

.EXAMPLE
Find-Install -InstanceName 'NameToFindHere'

.NOTES
Maintainer: Simon Bouchier
#>

Function Find-Install {
    [Cmdletbinding()]
    Param (
        [Parameter(Mandatory=$True)]
        [ValidateNotNullOrEmpty()]
        #The instance name to search the system services for
        [String]$InstanceName
    )

    $search = "*"+$InstanceName+"*"

    if (Get-service $search){
    Get-service $search
    }
    else {
        Write-Host "No services were found for the search term: "$InstanceName
    }
}