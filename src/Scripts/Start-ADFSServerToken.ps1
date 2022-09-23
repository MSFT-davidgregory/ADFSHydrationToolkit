Function Start-ADFSServerToken {

    $federationServer = Get-Content -path "$($PSScriptRoot)/config/STS.config"
    $Username = Get-Content -path "$($PSScriptRoot)/config/Username.config"
    $SecPassword = Get-Content -path "$($PSScriptRoot)/config/Password.config" | ConvertTo-SecureString

    $creds = New-Object System.Management.Automation.PSCredential ($Username, $SecPassword)
    $CorrectPassword = $creds.GetNetworkCredential().Password
    $User = $creds.UserName



    $Apps = Get-AdfsRelyingPartyTrust

Foreach($App in $Apps)
{

    $random = Get-Random -Maximum 500

    for($b = 0; $b -lt $random; $b++){

	    $identifier = $app.Identifier | Select-Object -First 1
        $Passwordlist=’Password246810’,$CorrectPassword
        $password = Get-Random -InputObject $Passwordlist
        $pass = ConvertTo-SecureString $password -AsPlainText -Force
        $creds = New-Object PSCredential ($User, $pass)
        Get-AdfsServerToken -FederationServer $federationServer -AppliesTo $identifier -Credential $creds

    }

}

}