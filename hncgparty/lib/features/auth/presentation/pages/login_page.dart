import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/auth_bloc.dart';
import 'package:hncgparty/features/auth/presentation/blocs/auth_state.dart';
import 'package:hncgparty/features/auth/presentation/pages/sigin_page.dart';

class LoginPage extends StatelessWidget {
  final _identifierController = TextEditingController(); // Đổi tên controller
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          }
          if (state is AuthAuthenticated) {
            Navigator.pushReplacementNamed(context, '/home');
          }
        },
        builder: (context, state) {
          if (state is AuthLoading) {
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF487A74)),
              ),
            );
          }
          return _buildLoginForm(context);
        },
      ),
    );
  }

  Widget _buildLoginForm(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.only(
        left: 16.0,
        right: 16.0,
        top: 32.0,
        bottom: MediaQuery.of(context).viewInsets.bottom + 16.0,
      ),
      child: Column(
        children: [
          SizedBox(height: 50),
          Center(
            child: Image.asset(
              'assets/images/bg-group-fb-removebg-preview.png',
              width: 200,
              height: 200,
              fit: BoxFit.contain,
            ),
          ),
          SizedBox(height: 40),
          TextFormField(
            controller: _identifierController,
            decoration: InputDecoration(
              labelText: 'Username hoặc Email',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(color: Color(0xFF487A74)),
              ),
              prefixIcon: Icon(Icons.person, color: Color(0xFF487A74)),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(color: Color(0xFF487A74), width: 2),
              ),
            ),
            keyboardType: TextInputType.emailAddress,
          ),
          SizedBox(height: 30),
          TextFormField(
            controller: _passwordController,
            obscureText: true,
            decoration: InputDecoration(
              labelText: 'Mật khẩu',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(color: Color(0xFF487A74)),
              ),
              prefixIcon: Icon(Icons.lock, color: Color(0xFF487A74)),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(color: Color(0xFF487A74), width: 2),
              ),
            ),
          ),
          SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildAuthButton(
                text: 'Đăng nhập',
                onPressed: () => _handleLogin(context),
              ),
              _buildAuthButton(
                text: 'Đăng ký',
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SiginPage()),
                ),
              ),
            ],
          ),
          SizedBox(height: 40),
          _buildSocialLoginSection(),
        ],
      ),
    );
  }

  Widget _buildAuthButton({required String text, required VoidCallback onPressed}) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: Color(0xFF487A74),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
        elevation: 5,
      ),
      child: Text(
        text,
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      ),
    );
  }

  Widget _buildSocialLoginSection() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Divider(
                color: Color(0xFF212121),
                thickness: 2,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                'Hoặc đăng nhập bằng',
                style: TextStyle(
                  color: Color(0xFF212121),
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              child: Divider(
                color: Color(0xFF212121),
                thickness: 2,
              ),
            ),
          ],
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildSocialButton(iconPath: 'assets/logo/google_logo.png'),
            _buildSocialButton(iconPath: 'assets/logo/facebook_logo.webp'),
            _buildSocialButton(iconPath: 'assets/logo/tiktok_logo.png'),
          ],
        ),
      ],
    );
  }

  Widget _buildSocialButton({required String iconPath}) {
    return GestureDetector(
      onTap: () {
        // Xử lý đăng nhập bằng mạng xã hội
      },
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.grey.shade400, width: 1),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(iconPath),
        ),
      ),
    );
  }

  void _handleLogin(BuildContext context) {
    final identifier = _identifierController.text.trim();
    final password = _passwordController.text.trim();

    if (identifier.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Vui lòng điền đầy đủ thông tin'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    context.read<AuthBloc>().add(
      LoginRequested(identifier, password), // Gửi identifier thay vì email
    );
  }
}