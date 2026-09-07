@echo off
setlocal enabledelayedexpansion

echo Converting MP4 files to WAV format...
echo.

cd /d "D:\Halloween 2025\songs"

for %%f in (*.mp4 *.3gp) do (
    echo Converting: %%f
    ffmpeg -i "%%f" -vn -acodec pcm_s16le -ar 44100 -ac 2 "%%~nf.wav"
    if !errorlevel! equ 0 (
        echo Successfully converted: %%~nf.wav
    ) else (
        echo Failed to convert: %%f
    )
    echo.
)

echo Conversion complete!
pause