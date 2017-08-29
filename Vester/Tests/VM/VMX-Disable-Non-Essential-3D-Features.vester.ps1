# Test file for the Vester module - https://github.com/WahlNetwork/Vester
# Called via Invoke-Pester VesterTemplate.Tests.ps1
# vSphere 6.5 Hardening Guide Guideline ID - VM.disable-non-essential-3D-features
# It is suggested that 3D be disabled on virtual machines that do not require 3D functionality

# Test title, e.g. 'DNS Servers'
$Title = 'Disable Non Essential 3D Features'

# Test description: How New-VesterConfig explains this value to the user
$Description = 'It is suggested that 3D be disabled on virtual machines that do not require 3D functionality'

# The config entry stating the desired values
$Desired = $cfg.vm.vmxMKSEnable3D

# The test value's data type, to help with conversion: bool/string/int
$Type = 'bool'

# The command(s) to pull the actual value for comparison
# $Object will scope to the folder this test is in (Cluster, Host, etc.)
[ScriptBlock]$Actual = {
    (Get-VM | Get-AdvancedSetting -Entity $object -Name 'MKS.Enable3D').Value
}

# The command(s) to match the environment to the config
# Use $Object to help filter, and $Desired to set the correct value
[ScriptBlock]$Fix = {
    if ((Get-AdvancedSetting -Entity $Object -Name 'MKS.Enable3D') -eq $null) {
        New-AdvancedSetting -Entity $Object -Name 'MKS.Enable3D' -Value $Desired -Confirm:$false -ErrorAction Stop
    } else {
        Get-AdvancedSetting -Entity $Object -Name 'MKS.Enable3D' | Set-AdvancedSetting -value $Desired -Confirm:$false -ErrorAction Stop
    }
}