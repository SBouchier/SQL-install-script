Function Check-Install {
    [Cmdletbinding()] 
    Param (
        [Parameter(Mandatory=$True)]
        [string]$InstanceName
    )


    $search = "*"+$InstanceName+"*"
    Get-service $search


    #Remove-Module -Name SqlServer
    #Install-Module -Name SqlServer -Scope CurrentUser
    #Get-Module SqlServer -ListAvailable
    #Get-SqlCredential -InputObject $serverName -Name "Test"
    #Get-Credential
    #Get-SqlInstance -Credential $Credential -MachineName "Computer005" -AcceptSelfSignedCertificate
    #Get-SqlLogin -ServerInstance $instanceID
    #$Credential = $host.ui.PromptForCredential("Need credentials", "Please enter your user name and password.", "", "NetBiosUserName")
    #write-host $Credential
    
    #$conn = New-Object Microsoft.SqlServer.Management.Common.ServerConnection -ArgumentList $env:ComputerName
    #$conn.ApplicationName = "test1"
	#$conn.StatementTimeout = 0
	#$conn.Connect()
	#$smo = New-Object Microsoft.SqlServer.Management.Smo.Server -ArgumentList $conn
    #Get-SqlInstance -Path $serverName
}
