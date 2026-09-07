# PowerShell script to normalize WAV files
$sourceDir = "D:\Halloween 2025\songs"
$outputDir = "D:\Halloween 2025\songs\normalized"

# Create output directory
if (!(Test-Path $outputDir)) {
    New-Item -ItemType Directory -Path $outputDir | Out-Null
}

Write-Host "Normalizing WAV files..." -ForegroundColor Green
Write-Host ""

# Get all WAV files
$wavFiles = Get-ChildItem -Path $sourceDir -Filter "*.wav"

foreach ($file in $wavFiles) {
    Write-Host "Processing: $($file.Name)" -ForegroundColor Yellow
    $inputFile = $file.FullName
    $outputFile = Join-Path $outputDir $file.Name
    
    # Run ffmpeg with loudnorm filter
    & ffmpeg -i "$inputFile" -af "loudnorm=I=-16:TP=-1.5:LRA=11" -ar 44100 "$outputFile" -y 2>&1 | Out-Null
    
    if ($LASTEXITCODE -eq 0) {
        Write-Host "  Successfully normalized!" -ForegroundColor Green
    } else {
        Write-Host "  Failed to normalize!" -ForegroundColor Red
    }
    Write-Host ""
}

Write-Host "Normalization complete! Files saved in:" -ForegroundColor Green
Write-Host $outputDir -ForegroundColor Cyan