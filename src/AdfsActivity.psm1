## Set Strict Mode for Module. https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/set-strictmode
Set-StrictMode -Version 3.0

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

