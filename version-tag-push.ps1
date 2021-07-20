# Please ensure that you have installed the following to use this in powershell:
#   Install-Module -Name powershell-yaml
#   Import-Module powershell-yaml

# Pass arguements to the script
  param (
      [Parameter(Position=1)]
      $Version
  )

#   Install and import the `powershell-yaml` module
Install-Module -Name powershell-yaml -Force -Verbose -Scope CurrentUser
Import-Module powershell-yaml

# LoadYml function that will read the YAML file and deserialize it
function LoadYml {
    param ($FileName = build-info.yml)

    # Load file content to a string array containing all YML file lines
    [string[]]$FileContent = @(Get-Content $FileName)
    $content = ''
    # Convert a string array into a single string
    foreach ($line in $FileContent) {
        $content + "`n" + $line
    }
    # Deserialize the YAML string into a PS object
    $buildInfo = ConvertFrom-Yaml $content
    # Return the PS object
    Write-Output $buildInfo
}

# WriteYml function that writes the YML content to a file
function WriteYml {
    param (
        $FileName,
        $Content
    )
    # Serialize the PS object into a YAML string
    $result = ConvertTo-Yaml $Content
    # Save the serialized string to a file
    Set-Content -Path $FileName -Value $result
}

# Loading yml, setting new value and saving yml
$buildInfo = LoadYml "build-info.yml"
$buildInfo.data.version = $Version
WriteYml "build-info.yml" $buildInfo