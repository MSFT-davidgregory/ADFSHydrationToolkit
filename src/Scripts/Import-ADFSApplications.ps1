Function Import-ADFSApplications{

    Import-ADFSAccessPolicies

    $Path = Get-Content -Path "$($PSScriptRoot)\Config\RootPath.config"
    $Apps = Get-ChildItem "$Path\Scripts\Apps\"

ForEach ($App in $Apps)
{

Try{

    $RP = Get-Content $App.FullName

    $RelyingParty = $RP | Convertfrom-json

    $TargetIdentifier = $RelyingParty.Identifier

    $NewADFSRelyingPartyTrust = Add-ADFSRelyingPartyTrust -Identifier $TargetIdentifier -Name $RelyingParty.Name

    Set-ADFSRelyingPartyTrust -TargetName $RelyingParty.Name -AutoUpdateEnabled $RelyingParty.AutoUpdateEnabled
    Set-ADFSRelyingPartyTrust -TargetName $RelyingParty.Name -DelegationAuthorizationRules $RelyingParty.DelegationAuthorizationRules
    Set-ADFSRelyingPartyTrust -TargetName $RelyingParty.Name -IssuanceAuthorizationRules $RelyingParty.IssuanceAuthorizationRules
    Set-ADFSRelyingPartyTrust -TargetName $RelyingParty.Name -WSFedEndpoint $RelyingParty.WSFedEndpoint
    Set-ADFSRelyingPartyTrust -TargetName $RelyingParty.Name -IssuanceTransformRules $RelyingParty.IssuanceTransformRules
    Set-ADFSRelyingPartyTrust -TargetName $RelyingParty.Name -ClaimAccepted $RelyingParty.ClaimsAccepted
    Set-ADFSRelyingPartyTrust -TargetName $RelyingParty.Name -EncryptClaims $RelyingParty.EncryptClaims
    Set-ADFSRelyingPartyTrust -TargetName $RelyingParty.Name -EncryptionCertificate $RelyingParty.EncryptionCertificate
    Set-ADFSRelyingPartyTrust -TargetName $RelyingParty.Name -MetadataUrl $RelyingParty.MetadataUrl
    Set-ADFSRelyingPartyTrust -TargetName $RelyingParty.Name -MonitoringEnabled $RelyingParty.MonitoringEnabled
    Set-ADFSRelyingPartyTrust -TargetName $RelyingParty.Name -NotBeforeSkew $RelyingParty.NotBeforeSkew
    Set-ADFSRelyingPartyTrust -TargetName $RelyingParty.Name -ImpersonationAuthorizationRules $RelyingParty.ImpersonationAuthorizationRules
    Set-ADFSRelyingPartyTrust -TargetName $RelyingParty.Name -ProtocolProfile $RelyingParty.ProtocolProfile
    Set-ADFSRelyingPartyTrust -TargetName $RelyingParty.Name -RequestSigningCertificate $RelyingParty.RequestSigningCertificate
    Set-ADFSRelyingPartyTrust -TargetName $RelyingParty.Name -EncryptedNameIdRequired $RelyingParty.EncryptedNameIdRequired
    Set-ADFSRelyingPartyTrust -TargetName $RelyingParty.Name -SignedSamlRequestsRequired $RelyingParty.SignedSamlRequestsRequired  

      $newSamlEndPoints = @()
      foreach ($SamlEndpoint in $RelyingParty.SamlEndpoints)
      {
        # Is ResponseLocation defined?
        if ($SamlEndpoint.ResponseLocation)
        {
          # ResponseLocation is not null or empty
          $newSamlEndPoint = New-ADFSSamlEndpoint -Binding $SamlEndpoint.Binding `
            -Protocol $SamlEndpoint.Protocol `
            -Uri $SamlEndpoint.Location -Index $SamlEndpoint.Index `
            -IsDefault $SamlEndpoint.IsDefault
        }
        else
        {
          $newSamlEndPoint = New-ADFSSamlEndpoint -Binding $SamlEndpoint.Binding `
            -Protocol $SamlEndpoint.Protocol `
            -Uri $SamlEndpoint.Location -Index $SamlEndpoint.Index `
            -IsDefault $SamlEndpoint.IsDefault `
            -ResponseUri $SamlEndpoint.ResponseLocation
        }
        $newSamlEndPoints += $newSamlEndPoint
      }
    Set-ADFSRelyingPartyTrust -TargetName $RelyingParty.Name -SamlEndpoint $newSamlEndPoints
    Set-ADFSRelyingPartyTrust -TargetName $RelyingParty.Name -SamlResponseSignature $RelyingParty.SamlResponseSignature
    Set-ADFSRelyingPartyTrust -TargetName $RelyingParty.Name -SignatureAlgorithm $RelyingParty.SignatureAlgorithm
    Set-ADFSRelyingPartyTrust -TargetName $RelyingParty.Name -TokenLifetime $RelyingParty.TokenLifetime
    Set-AdfsRelyingPartyTrust  -TargetName $RelyingParty.Name -AccessControlPolicyName $RelyingParty.AccessControlPolicyName

   }

Catch{

    Write-Host $Error[0]

}


}
}