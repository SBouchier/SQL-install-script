Function Check-Install {
    [Cmdletbinding()] 
    Param (
        [Parameter(Mandatory=$True)]
        [string]$InstanceName
    )

    $search = "*"+$InstanceName+"*"
    Get-service $search
}
