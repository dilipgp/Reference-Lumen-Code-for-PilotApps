#Reference: https://learn.microsoft.com/en-us/azure/virtual-desktop/app-attach-powershell
 
# This powershell script is for adding/removing an MSIX package to/from a hostpool.
# Variable $packageaction is utilized to decide adding or removing
# if packageaction = "ADDMSIX"  (case ignored), then add MSIX package
# if packageaction = "REMOVEMSIX"  (case ignored), then remove MSIX package
 
# The required input variables are
# SubscriptionName, HostPoolName, ResourceGroupName, ImageUNCPath and Package DisplayName
 
#install avdi powershell module
Install-Module -Name Az.DesktopVirtualization
 
#import the msix module
#Import-Module -Name "<path>\Az.DesktopVirtualization.psm1" -Verbose
 
# check if the msix module is installed
Get-Command -Module Az.DesktopVirtualization | Where-Object { $_.Name -match "MSIX" }
 
#Variables set up
Param(
    [Parameter(Mandatory=$true)] [string]$packageaction,
    [Parameter(Mandatory=$true)] [string]$SubscriptionName,
    [Parameter(Mandatory=$true)] [string]$HostPoolName,
    [Parameter(Mandatory=$true)] [string]$ResourceGroupName,
    [Parameter(Mandatory=$true)] [string]$ImageUNCPath,
    [Parameter(Mandatory=$true)] [string]$PackageDisplayName
    )
$subContext = Set-AzContext -Subscription $SubscriptionName
$subId = $subContext.Subscription.Id
$hp = $HostPoolName
$rg = $ResourceGroupName
 
$obj = Expand-AzWvdMsixImage -HostPoolName $hp -ResourceGroupName $rg -SubscriptionId $subID -Uri $ImageUNCPath
 
if ( $packageaction -eq "ADDMSIX")
{
    #Add an MSIX package to a host pool
    New-AzWvdMsixPackage -HostPoolName $hp -ResourceGroupName $rg -SubscriptionId $subId -PackageAlias $obj.PackageAlias -DisplayName $PackageDisplayName -ImagePath $ImageUNCPath -IsActive:$true
 
    Get-AzWvdMsixPackage -HostPoolName $hp -ResourceGroupName $rg -SubscriptionId $subId | Where-Object {$_.PackageFamilyName -eq $obj.PackageFamilyName}
 
}elseif ( $packageaction -eq "REMOVEMSIX"){
    # Remove
    Remove-AzWvdMsixPackage -FullName $obj.PackageFullName -HostPoolName $hp -ResourceGroupName $rg
}
 
 
 