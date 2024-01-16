import 'package:flutter/material.dart';
import 'http/api_service.dart';
import 'TodoList.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isLoginPage = true;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        title: Text(_isLoginPage ? 'Login' : 'Register'),
        backgroundColor: Colors.grey,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                hintText: 'Enter your email',
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                hintText: 'Enter your password',
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () async {
                // Handle login or register button press
                String email = _emailController.text;
                String password = _passwordController.text;
                if (_isLoginPage) {
                  if (await APIService.Login(email, password)) {
                    // Navigate to TodoList page
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => TodoListPage()),
                    );
                  }
                } 
                else {
                  if (await APIService.Register(email, password)) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => TodoListPage()),
                    );
                  }
                }
              },
              child: Text(_isLoginPage ? 'Login' : 'Register'),
            ),
            SizedBox(height: 16.0),
            TextButton(
              onPressed: () {
                // Toggle between login and register
                setState(() {
                  _isLoginPage = !_isLoginPage;
                });
              },
              child: Text(_isLoginPage
                  ? 'Create an account'
                  : 'Already have an account?'),
            ),
          ],
        ),
      ),
    );
  }
}
