import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hncgparty/features/auth/presentation/pages/login_page.dart';
import '../blocs/auth_bloc.dart';
import 'package:hncgparty/features/auth/presentation/blocs/auth_state.dart';

class SiginPage extends StatelessWidget {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _repasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            // Phản ứng với các thay đổi trạng thái (không liên quan đến UI hiển thị)
          },
          builder: (context, state) {
            if (state is AuthLoading) {
              return Center(child: CircularProgressIndicator());
            }
            return _buildSiginForm(context);
          },
        )
    );
  }
  Widget _buildSiginForm(BuildContext context){
      return SingleChildScrollView(
        padding: EdgeInsets.only( // khi nhấp vào bàn phím sẽ tự động di chuyển lên
          left: 16.0,
          right: 16.0,
          top: 32.0,
          bottom: MediaQuery.of(context).viewInsets.bottom + 16.0,
        ),
        child: Column(
          children: [
            SizedBox(height: 5,),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: ElevatedButton(
                  onPressed: (){
                    Navigator.push(context,
                                   MaterialPageRoute(builder: (context)=>LoginPage()),// quay ve trang dang nhap
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.all(10),
                    foregroundColor: Colors.white,
                    backgroundColor: Color(0xFF487A74),
                  ),
                  child: Icon(Icons.arrow_back, size: 24,),
                ),
              ),
            ),
            SizedBox(height: 10,),
            Center(
              child: Image.asset(
                'assets/images/bg-group-fb-removebg-preview.png',
                width: 200,
                height: 100,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 10,),
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'
                  ,border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
                  prefixIcon: Icon(Icons.email)
              ),
            ),
            SizedBox(height: 30),
            TextFormField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(labelText: 'Password',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
                  prefixIcon: Icon(Icons.password)
              ),
            ),
            SizedBox(height: 30),
            TextFormField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(labelText: 'Repassword',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
                  prefixIcon: Icon(Icons.password)
              ),
            ),
            SizedBox(height: 40),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // hành động khi nhấn
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Color(0xFF487A74),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
                    ),
                    child: Text('Sigin'),
                  )
                ]
            ),
            SizedBox(height: 40,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Container(
                    height: 2.0,
                    color: Color(0xFF212121),
                  ),
                ),
                SizedBox(width: 10),
                Text(
                  'Sin in another way',
                  style: TextStyle(
                    color: Color(0xFF212121),
                    fontSize: 12.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Time new roman',
                    letterSpacing: 1.2,
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Container(
                    height: 2.0,
                    color: Color(0xFF212121),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Xử lý đăng nhập ở đây
                  },
                  style: ElevatedButton.styleFrom(
                    shape: CircleBorder(),
                    padding: EdgeInsets.all(0.1),
                    backgroundColor: Colors.white,
                  ),
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.black87,
                        width: 1,
                      ),
                    ),
                    child: Image.asset(
                      'assets/logo/google_logo.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Xử lý đăng nhập ở đây
                  },
                  style: ElevatedButton.styleFrom(
                    shape: CircleBorder(),
                    padding: EdgeInsets.all(0.1),
                    backgroundColor: Colors.white,
                  ),
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.black87,
                        width: 1,
                      ),
                    ),
                    child: Image.asset(
                      'assets/logo/facebook_logo.webp',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Xử lý đăng nhập ở đây
                  },
                  style: ElevatedButton.styleFrom(
                    shape: CircleBorder(),
                    padding: EdgeInsets.all(0.1),
                    backgroundColor: Colors.white,
                  ),
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.black87,
                        width: 1,
                      ),
                    ),
                    child: Image.asset(
                      'assets/logo/tiktok_logo.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      );
  }
}
