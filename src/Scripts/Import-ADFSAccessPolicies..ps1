Function Import-ADFSAccessPolicies{

    $Path = Get-Content -Path "$($PSScriptRoot)\Config\RootPath.config"
    $PolicyPath = "$Path\Scripts\AccessControlPolicies\"
    $Policies = Get-ChildItem -Path $PolicyPath

Foreach($policy in $Policies){

Try{

    $NewAP = New-AdfsAccessControlPolicy -Name "Block Off Corp and VPN" -Identifier "DenyNonCorporateandNonVPN" -PolicyMetadataFile $policy.FullName

}
Catch
{

    Write-Host $Error[0]

}

}


}