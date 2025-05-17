import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hncgparty/features/auth/presentation/pages/login_page.dart';
import '../blocs/auth_bloc.dart';
import 'package:hncgparty/features/auth/presentation/blocs/auth_state.dart';

class SiginPage extends StatelessWidget {
  // Thêm controller cho username
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _repasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          if (state is AuthLoading) {
            return Center(child: CircularProgressIndicator());
          }
          return _buildSiginForm(context);
        },
      ),
    );
  }

  Widget _buildSiginForm(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.only(
        left: 16.0,
        right: 16.0,
        top: 32.0,
        bottom: MediaQuery.of(context).viewInsets.bottom + 16.0,
      ),
      child: Column(
        children: [
          SizedBox(height: 5),
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.all(10),
                  foregroundColor: Colors.white,
                  backgroundColor: Color(0xFF487A74),
                ),
                child: Icon(Icons.arrow_back, size: 24),
              ),
            ),
          ),
          SizedBox(height: 10),
          Center(
            child: Image.asset(
              'assets/images/bg-group-fb-removebg-preview.png',
              width: 200,
              height: 100,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 10),
          // Thêm trường username
          TextFormField(
            controller: _usernameController,
            decoration: InputDecoration(
              labelText: 'Username',
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
              prefixIcon: Icon(Icons.person),
            ),
          ),
          SizedBox(height: 30),
          TextFormField(
            controller: _emailController,
            decoration: InputDecoration(
              labelText: 'Email',
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
              prefixIcon: Icon(Icons.email),
            ),
          ),
          SizedBox(height: 30),
          TextFormField(
            controller: _passwordController,
            obscureText: true,
            decoration: InputDecoration(
              labelText: 'Password',
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
              prefixIcon: Icon(Icons.password),
            ),
          ),
          SizedBox(height: 30),
          TextFormField(
            controller: _repasswordController,
            obscureText: true,
            decoration: InputDecoration(
              labelText: 'Confirm Password',
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
              prefixIcon: Icon(Icons.password),
            ),
          ),
          SizedBox(height: 40),
          ElevatedButton(
            onPressed: () => _handleSignup(context),
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Color(0xFF487A74),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
            ),
            child: Text('Sign Up'),
          ),
          // ... Phần còn lại giữ nguyên
        ],
      ),
    );
  }

  void _handleSignup(BuildContext context) {
    if (_passwordController.text != _repasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Passwords do not match!')),
      );
      return;
    }

    context.read<AuthBloc>().add(
      SignupRequested(
        _usernameController.text.trim(),
        _emailController.text.trim(),
        _passwordController.text.trim(),
      ),
    );
  }
}