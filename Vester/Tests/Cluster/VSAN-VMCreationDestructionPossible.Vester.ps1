# Test file for the Vester module - https://github.com/WahlNetwork/Vester
# Called via Invoke-Pester VesterTemplate.Tests.ps1

# Test title, e.g. 'DNS Servers'
$Title = 'VSAN VM Creation/Destruction Verification'

# Test description: How New-VesterConfig explains this value to the user
$Description = 'Verifies VM creation and destruction are possible in the VSAN cluster to verify CRUD health'

# The config entry stating the desired values
$Desired = $cfg.cluster.vsancreationdestructionpossible

# The test value's data type, to help with conversion: bool/string/int
$Type = 'bool'

# The command(s) to pull the actual value for comparison
# $Object will scope to the folder this test is in (Cluster, Host, etc.)
[ScriptBlock]$Actual = {
    $randomGUID  = [guid]::NewGuid().ToString();
    $testVMName  = "vesterVM-" + $randomGUID;
    $resoucePool = $Object | Get-ResourcePool;
    $testVM      = New-VM -ResourcePool $resoucePool -Name $testVMName -ErrorAction SilentlyContinue;

    if ( $testVM )
    {
        Remove-VM -DeletePermanently -VM $testVM -ErrorAction SilentlyContinue -Confirm:$False;
        $true;
    }
    else
    {
        $false;
    }
}

# The command(s) to match the environment to the config
# Use $Object to help filter, and $Desired to set the correct value
[ScriptBlock]$Fix = {
    Write-Warning "VSAN Cluster is in a bad state preventing VM C.R.U.D. lifecycle from operating. Ensure sufficient # hosts are participating in VSAN and are in a healthy state."
}
