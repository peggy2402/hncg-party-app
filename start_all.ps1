# Khởi động Docker
docker-compose up --build -d backend ngrok

Write-Host "Dang doi ngrok khoi dong..."
Start-Sleep -Seconds 15

# Cập nhật URL
.\update_flutter_url.ps1

# Chạy Flutter
cd hncgparty
flutter run