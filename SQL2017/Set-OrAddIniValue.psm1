
<#
.SYNOPSIS
A function that takes key and value inputs that have been provided by the user and edits the .ini to add them.

.DESCRIPTION
The function is not called directly by the user, but their values that they
provide to SQL2017's function above are added here by invoking this function
for each argument that needs to be added to the config file.

.EXAMPLE
Set-OrAddIniValue -FilePath 'LinkToPath' -key 'KeyHere' -value 'NewValueHere'

.NOTES
Maintainer: Simon Bouchier
#>
Function Set-OrAddIniValue {
    Param(
        [Parameter(Mandatory=$True)]
        [ValidateScript({Test-Path -Path $_ -PathType Leaf -IsValid})]
        #the location of the config file to ammend
        [String]$FilePath,

        [Parameter(Mandatory=$True)]
        #the name of the parameter that needs changing or adding to the config file
        [String]$Key,

        [Parameter(Mandatory=$True)]
        #the new value to assign to the given key
        [String]$Value
    )

    #fetch the content from the filepath given.
    $content = Get-Content $FilePath

        #if the key already exists in the content...
        if ($content -match "^$key=") {
            #replace the value with the newly given one
            $content= $content -replace "^$key=(.*)", "$key=$value"
        }
        #otherwise, add a new key and value pairing.
        else {
            $content += "$key=$value"
        }
    
    #save the new file.
    $content | Set-Content $FilePath
}
