# ADFS Hydration Toolkit
Azure AD Connect Health hydration toolkit allows you to hydrate ADFS with 16 of the most popular SaaS applications and than generates authentication activity to those 16 applications to ensure they show up in the ADFS Activity Report in the Azure AD portal.

## Prerequisites:
 - ADFS 2016 or higher
 - Ensure both /13/usernamemixed and /2005/usernamemixed endpoints are enabled.
 - Connect Health for ADFS has to be installed on all ADFS servers.

## Steps to Install and Run

 - Extract contents of .zip file to anywhere on your ADFS server
 - Open Powershell or PowerShell ISE as AdminIn PowerShell, navigate to where you extracted the package. 

Then run the following to import the module:

`Import-Module .\Install-ADFSActivity.psm1`

It will prompt you for a valid credentials (ones used to authenticate against the SaaS apps), and your base ADFS URL (sts.domain.com) so be sure to type those in correctly. It will save these to individual files in /config folder for future use including an encrypted version of the password. 

Than run this to hydrate the ADFS server with the top 16 SaaS applications complete with issuance transform rules and access policies:       

  `Import-ADFSApplications`

If you want to create a scheduled task to run every night at 2 AM to simulate authentication traffic against your ADFS server, run the following:

`New-ADFSServerTokenTask`

Or you want to run this manually right now, run:

 `Start-ADFSServerToken`

Regardless of whether you install the scheduled task or run it manually, the script will do a random number of authentication attempts (<500) against each app and even include a wrong password 50% of the time to simulate real world activity. 

## Steps to Run Manually

If you need to ever run this manually in the future, just be sure to run this to import the module:

`Import-module .\ADFSActivity.psm1`

And then run this function to invoke the application activity:

`Start-ADFSServerToken`

After 24 hours, you should see the applications show up in the ADFS Activity Report in the Azure portal with the login activity like so:

![ADFS Activity Report](https://github.com/MSFT-davidgregory/ADFSHydrationToolkit/blob/main/images/ActivityReport.png)

From there, you can click on the apps that show as **"Additional Steps Required"** to see what configuration is blocking them from being migrated to Azure AD:

![ADFS Activity Report](https://github.com/MSFT-davidgregory/ADFSHydrationToolkit/blob/main/images/AdditionalSteps.png)
