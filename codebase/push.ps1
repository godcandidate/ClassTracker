$directory = "C:\path\to\directory"

# Change to the desired directory
Set-Location -Path $directory

# Get a list of all files in the directory
$files = Get-ChildItem -File

# Iterate over each file
foreach ($file in $files) {
    # Git add the file
    Write-Host "Adding file: $($file.Name)"
    git add $file.Name

    # Git commit the file
    Write-Host "Create $($file.Name)"
    git commit -m "create $($file.Name)"

    # Git push the file
    Write-Host "Pushing file: $($file.Name)"
    git push
}
