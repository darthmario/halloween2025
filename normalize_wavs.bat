@echo off
setlocal enabledelayedexpansion

echo Normalizing volume for all WAV files...
echo.

cd /d "D:\Halloween 2025\songs"

if not exist "normalized" mkdir normalized

for %%f in (*.wav) do (
    echo Processing: %%f
    ffmpeg -i "%%f" -af loudnorm=I=-16:TP=-1.5:LRA=11:print_format=summary -ar 44100 "normalized\%%f" -y
    if !errorlevel! equ 0 (
        echo Successfully normalized: %%f
    ) else (
        echo Failed to normalize: %%f
    )
    echo.
)

echo.
echo Normalization complete! Files saved in 'normalized' folder.
pause