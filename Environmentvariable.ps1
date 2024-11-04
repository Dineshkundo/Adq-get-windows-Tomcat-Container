# EnvironmentalVariable.ps1
[System.Environment]::SetEnvironmentVariable("JAVA_HOME", "C:\Program Files\Java\jdk1.8.0_202", [System.EnvironmentVariableTarget]::Machine)
[System.Environment]::SetEnvironmentVariable("JRE_HOME", "C:\Program Files\Java\jre1.8.0_202", [System.EnvironmentVariableTarget]::Machine)
[System.Environment]::SetEnvironmentVariable("PATH", "$env:JAVA_HOME\bin;$env:JRE_HOME\bin;$env:PATH", [System.EnvironmentVariableTarget]::Machine)

# EnvironmentalVariable.ps1

# Set PYTHON_HOME based on the Python installation path
[System.Environment]::SetEnvironmentVariable("PYTHON_HOME", "C:\Program Files\Python39", [System.EnvironmentVariableTarget]::Machine)

# Update the PATH environment variable to include Python binaries
$pythonPath = "$env:PYTHON_HOME\Scripts;$env:PYTHON_HOME\Lib"
[System.Environment]::SetEnvironmentVariable("PYTHON_PATH", $pythonPath, [System.EnvironmentVariableTarget]::Machine)

# Get the existing PATH and add Python directories
$existingPath = [System.Environment]::GetEnvironmentVariable("PATH", [System.EnvironmentVariableTarget]::Machine)
$newPath = "$env:PYTHON_HOME;$env:PYTHON_HOME\Scripts;$existingPath"
[System.Environment]::SetEnvironmentVariable("PATH", $newPath, [System.EnvironmentVariableTarget]::Machine)
