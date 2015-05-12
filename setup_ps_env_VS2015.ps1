function Get-Batchfile ($file) {
    $cmd = "@echo off & `"$file`" & set"
    cmd /c $cmd | Foreach-Object {
        $p, $v = $_.split('=')
        Set-Item -path env:$p -value $v
    }
}

function VsVars32()
{
    $vs140comntools = (Get-ChildItem env:VS140COMNTOOLS).Value
    $batchFile = [System.IO.Path]::Combine($vs140comntools, "vsvars32.bat")
    Get-Batchfile $BatchFile
}

"Initializing C++ REST SDK Powershell VS2015 Environment"

# Add MSBuild to the path.
if (Test-Path "Env:ProgramFiles(x86)")
{
    $msbuildLocation = (Get-ChildItem "Env:ProgramFiles(x86)").Value
}
else
{
    $msbuildLocation = (Get-ChildItem "Env:ProgramFiles").Value
}

$msbuildLocation = [System.IO.Path]::Combine($msbuildLocation, "MSBuild", "14.0", "Bin")
$Env:Path += ";" + $msbuildLocation

$Env:VisualStudioVersion = "14.0"
$Env:DevToolsVersion = "140"