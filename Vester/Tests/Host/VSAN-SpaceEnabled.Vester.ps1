# Test file for the Vester module - https://github.com/WahlNetwork/Vester
# Called via Invoke-Pester VesterTemplate.Tests.ps1
# vSphere 6.0 Hardening Guide Guideline ID - vSAN Space Enabled

# Test title, e.g. 'DNS Servers'
$Title = 'vSAN Space Enabled'

# Test description: How New-VesterConfig explains this value to the user
$Description = '1 (Enable Space), 0 (Disable Space) ... needs description'

# The config entry stating the desired values
$Desired = $cfg.host.VSANSpaceEnabled

# The test value's data type, to help with conversion: bool/string/int
$Type = 'bool'

# The command(s) to pull the actual value for comparison
# $Object will scope to the folder this test is in (Cluster, Host, etc.)
[ScriptBlock]$Actual = {
    (Get-AdvancedSetting -Entity $Object -Name "VSAN.VSANSpaceEnabled").Value
}

# The command(s) to match the environment to the config
# Use $Object to help filter, and $Desired to set the correct value
[ScriptBlock]$Fix = {
    Get-AdvancedSetting -Entity $Object -Name "VSAN.VSANSpaceEnabled" | Set-AdvancedSetting -Value $Desired -Confirm:$false -ErrorAction Stop
}
