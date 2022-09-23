Function New-ADFSServerTokenTask{

$Path = Get-Content -Path "$($PSScriptRoot)\Config\RootPath.config"

Try{

    $Trigger= New-ScheduledTaskTrigger -At 2:00am -Daily
    $User= "NT AUTHORITY\SYSTEM"
    $Action= New-ScheduledTaskAction -Execute "PowerShell.exe" -Argument "$($Path)\ScheduledTask.ps1"
    Register-ScheduledTask -TaskName "Start-ADFSServerToken" -Trigger $Trigger -User $User -Action $Action -RunLevel Highest –Force

}

Catch{

    Write-Host $Error[0]

}

}