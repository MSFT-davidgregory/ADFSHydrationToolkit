## Set Strict Mode for Module. https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/set-strictmode
#Set-StrictMode -Version 3.0

    $STS =  Read-Host -Prompt "Please enter the base ADFS URL i.e sts.domain.com"
    $creds = Get-Credential
    $Username =  $creds.GetNetworkCredential().UserName
    $Password =  $creds.GetNetworkCredential().Password
    $Username | Set-Content -Path "$($PSScriptRoot)\Scripts\config/Username.config"
    $secpasswd = ConvertTo-SecureString $Password -AsPlainText -Force
    $secureStringText = $secpasswd | ConvertFrom-SecureString 
    Set-Content -Path "$($PSScriptRoot)\Scripts\config\Password.config" $secureStringText
    $STS | Set-Content -Path "$($PSScriptRoot)\Scripts\config\STS.config"
    $PSScriptRoot | Set-Content -Path "$($PSScriptRoot)\Scripts\config\RootPath.config"

    #Get public and private function definition files.
    $Scripts  = (Get-ChildItem -Path $PSScriptRoot\Scripts\*.ps1 -ErrorAction SilentlyContinue)

#Dot source the files
Foreach($import in $Scripts)
{
    Try{
        . $import.fullname
    }

    Catch{

        Write-Error -Message "Failed to import function $($import.fullname): $_"
    }
}

# Here I might...
# Read in or create an initial config file and variable
# Export Public functions ($Public.BaseName) for WIP modules
# Set variables visible to the module and its functions only

Export-ModuleMember -Function $Scripts.Basename

