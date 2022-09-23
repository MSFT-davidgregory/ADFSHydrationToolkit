# ADFSHydrationToolkit
Azure AD Connect Health hydration toolkist allows you to hydrate ADFS with 16 of the most popular SaaS applications and than generate activity to AD FS servers withou using the browser including a scheduled task.

# H2Prerequisites:
ADFS 2016 or higher
Ensure both /usernamemixed endpoints are enabled.
Connect Health for ADFS has to be installed

Steps to Install and Configure:

Extract contents of .zip file to anywhere on your ADFS server
Open Powershell or PowerShell ISE as AdminIn PowerShell, navigate to where you extracted the package. 
Then run the following to import the module:       
Import-Module .\Install-ADFSActivity.psm1

It will prompt you for a valid credentials (ones used to authenticate against the SaaS apps), and your base ADFS URL (sts.domain.com) so be sure to type those in correctly. It will save these to individual files in /config folder for future use including an encrypted version of the password. 

Than run this to hydrate the ADFS server with the top 16 SaaS applications complete with issuance transform rules and access policies:       

Import-ADFSApplications 

If you want to create a scheduled task to run every night at 2 AM to simulate authentication traffic against your ADFS server, run the following:      
New-ADFSServerTokenTask 

Or you want to run this manually right now, run:       
Start-ADFSServerToken 

Regardless of whether you install the scheduled task or run it manually, the script will do a random number of authentication attempts (<500) against each app and even include a wrong password here or there to simulate real world activity. 

If you need to ever run this manually in the future, just be sure to run this to import the module:       
Import-module .\ADFSActivity.psm1      
Start-ADFSServerToken  

After 24 hours, you should see the applications show up in the ADFS Activity Report in the Azure portal with the login activity.
