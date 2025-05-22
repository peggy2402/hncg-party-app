
# HNCG - Party, Live & Chat 🎉🎤💬

Chào mừng bạn đến với **HNCG** — nơi mọi khoảnh khắc kết nối đều trở nên sống động!  
Ứng dụng **HNCG - Party, Live & Chat** giúp bạn tham gia các bữa tiệc trực tuyến, livestream, và trò chuyện với bạn bè mới từ khắp nơi trên thế giới.

## 🌟 Tính năng nổi bật

- **Phòng Party Ảo**: Tạo hoặc tham gia các bữa tiệc ảo, trò chuyện và chia sẻ cảm xúc trong thời gian thực.
- **Livestream**: Phát trực tiếp những khoảnh khắc của bạn hoặc xem livestream từ những người dùng khác.
- **Chat Trực Tuyến**: Gửi tin nhắn văn bản, emoji, hình ảnh và cả voice chat cực nhanh.
- **Tặng quà ảo**: Gửi và nhận các món quà dễ thương trong phòng chat hoặc khi livestream.
- **Kết bạn toàn cầu**: Khám phá những người bạn mới theo sở thích, khu vực hoặc chủ đề yêu thích.
- **Hệ thống cấp bậc & nhiệm vụ**: Hoàn thành nhiệm vụ hàng ngày và nhận phần thưởng hấp dẫn.
- **Bảo mật & riêng tư**: Bảo vệ thông tin cá nhân và trải nghiệm an toàn cho mọi người dùng.

## 🚀 Công nghệ sử dụng

- **Flutter** (iOS & Android Cross-platform)
- **Firebase** (Authentication, Firestore, Storage, Realtime Database)
- **Socket.IO** (Giao tiếp real-time)
- **Cloudinary** (Quản lý hình ảnh)
- **OneSignal** (Thông báo đẩy)
- **VNPAY/Stripe** (Thanh toán online cho dịch vụ nâng cao)

## 🛠️ Cài đặt

1. Clone dự án:

   ```bash
   git clone https://github.com/peggy2402/hncg-party-app.git
   cd hncg-party-app
   ```

2. Cài đặt dependencies:

   ```bash
   flutter pub get
   ```

3. Thiết lập .ENV:
   - Gõ lệnh copy file
   ```bash
   cp .env.example .env
   ```
   - Thiết lập file .env và docker_compose.yml
   ```bash
    DB_HOST=localhost
    DB_PORT=5432
    DB_NAME=socialapp
    DB_USER=postgres
    DB_PASSWORD=your_password
    PORT=3000
    NODE_ENV=development
   ```

4. Chạy ứng dụng:

   ```bash
   .\start_all.ps1
   ```

## 📱 Giao diện mẫu

<p align="center">
  <img src="https://github.com/user-attachments/assets/c8fe40c1-68ba-44c1-9a5e-e84620e13e83" width="200" alt="Giao diện loading" />
  <img src="https://github.com/user-attachments/assets/df8c5e3e-bfa5-4ddb-bc8b-4818914a9c49" width="200" alt="Giao diện login" />
  <img src="https://github.com/user-attachments/assets/f85e9a00-0dba-4197-a4f0-6d21e3f5eb38" width="200" alt="Giao diện sign in" />
  <img src="https://github.com/user-attachments/assets/9627dae2-12aa-4832-9ed2-81bbaa47cc0b" width="200" alt="Giao diện otp verify" />
  <img src="https://github.com/user-attachments/assets/df0b0fdd-14c6-4ce2-84e2-d576f53098bd" width="200" alt="Giao diện forgot password" />
  <img src="https://github.com/user-attachments/assets/1674be99-f033-4f80-8230-d8d674d33830" width="200" alt="Giao diện confirm new password" />
</p>

## 🔥 Tầm nhìn

Chúng tôi tin rằng **kết nối không nên bị giới hạn bởi khoảng cách**.  
Với **HNCG**, mọi người có thể **vui vẻ, thể hiện bản thân và kết nối thật lòng** dù ở bất cứ nơi đâu.

## 🤝 Đóng góp

Bạn có ý tưởng mới? Phát hiện bug? Đừng ngần ngại:

- Mở một issue
- Gửi pull request
- Liên hệ trực tiếp với chúng tôi

## 📩 Liên hệ

- Email: support@hncg.site
- Website: [hncg.site](https://hncg.site)
