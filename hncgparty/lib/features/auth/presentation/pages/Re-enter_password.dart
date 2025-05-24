import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../blocs/auth_bloc.dart';
import 'package:hncgparty/features/auth/presentation/blocs/auth_state.dart';

class Re_enter_Password extends StatefulWidget {
  @override
  _Enter_Password createState() => _Enter_Password();
}

class _Enter_Password extends State<Re_enter_Password> {
  final _passwordController = TextEditingController();
  final _rePasswordController = TextEditingController();

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
              // Navigator.pushReplacementNamed(context, '/home');
            }
          },
          builder: (context, state) {
            if(state is AuthLoading) {
              return Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF8B39A9)),
                ),
              );
            }
            return _buildLoginForm(context);
          },
        )
    );
  }

  Widget _buildLoginForm(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/bg-form-login.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 35),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // HNCG Party Logo at the top
                Image.asset(
                  'assets/images/logo-hncg-party-ver2.png',
                  height: 300,
                  width: 300,
                ),
                SizedBox(height: 10),

                // Login Form Card
                Container(
                  decoration: BoxDecoration(
                    color: Color(0xFFFFC0E2), // Light pink background
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(
                        color: Colors.white,
                        width: 6
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 10,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.topLeft,
                        padding: EdgeInsets.all(8),
                        child: IconButton(
                          icon: Icon(Icons.arrow_back),
                          onPressed: () => Navigator.pop(context,'/'),
                        ),
                      ),

                      // START PARTY text
                      SizedBox(height: 30),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'THAY ĐỔI MẬT KHẨU',
                             style:GoogleFonts.montserrat(
                              fontSize: 24,
                              fontWeight: FontWeight.w900,
                              color: Color(0xFF3D004D), // tím đậm
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'VUI LÒNG NHẬP MẬT KHẨU MỚI',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF3D004D),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      // Username Field
                      Container(
                        width: 300,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(50),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 4,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: TextField(
                          controller: _passwordController,
                          decoration: InputDecoration(
                            hintText: 'New passwork',
                            hintStyle: TextStyle(color: Colors.grey),
                            prefixIcon: Icon(
                              Icons.password,
                              color: Color(0xFF3D165B),
                            ),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(vertical: 15),
                          ),
                        ),
                      ),
                      SizedBox(height:20 ),
                      Container(
                        width: 300,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(50),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 4,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: TextField(
                          controller: _rePasswordController,
                          decoration: InputDecoration(
                            hintText: 'Re-enter password',
                            hintStyle: TextStyle(color: Colors.grey),
                            prefixIcon: Icon(
                              Icons.password,
                              color: Color(0xFF3D165B),
                            ),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(vertical: 15),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      // Login Button
                      Container(
                        width: 300,
                        height: 55,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          gradient: LinearGradient(
                            colors: [
                              Color(0xFF3D165B),
                              Color(0xFF8B39A9),
                            ],
                          ),
                        ),
                        child: ElevatedButton(
                          onPressed: () => _navigator_rePassWord(context),
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                          ),
                          child: Text(
                            'TIẾP TỤC',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.5,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  void _navigator_rePassWord(BuildContext context) {
    final pasword = _passwordController.text;
    final re_pasword = _rePasswordController.text;
     if (re_pasword.isEmpty || pasword.isEmpty){
       ScaffoldMessenger.of(context).showSnackBar(
         SnackBar(
           content: Text('Vui lòng điền đầy đủ thông tin'),
           backgroundColor: Colors.orange,
         ),
       );
       return;
     }
      else if(re_pasword== pasword) {
          Navigator.pushNamed(context ,'/');
          return;
    } else{
       ScaffoldMessenger.of(context).showSnackBar(
         SnackBar(
           content: Text('Nhập sai mật khẩu'),
           backgroundColor: Colors.orange,
         ),
       );
       return;
     }
  }
}

