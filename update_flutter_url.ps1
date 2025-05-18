# Lấy URL từ API ngrok
$response = Invoke-RestMethod -Uri "http://localhost:4040/api/tunnels"
$ngrokUrl = $response.tunnels[0].public_url

# Thay thế URL trong file Dart
(Get-Content -Path "hncgparty\lib\core\config\env_deployment.dart") -replace "static const String baseUrl = '.*';", "static const String baseUrl = '$ngrokUrl';" | Set-Content -Path "hncgparty\lib\core\config\env_deployment.dart"

Write-Host "Da cap nhat URL thanh: $ngrokUrl"