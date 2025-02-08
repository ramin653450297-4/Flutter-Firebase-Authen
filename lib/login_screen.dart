import 'package:flutter/material.dart';
import 'package:flutter_firebase_authen/create_account_screen.dart';
import 'package:flutter_firebase_authen/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_firebase_authen/reset_password_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

void _login() async {
  final email = _emailController.text.trim();
  final password = _passwordController.text.trim();

  try {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      return HomeScreen();
    }));
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Login failed: ${e.toString()}")),
    );
  }
}

   @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _login,
              child: const Text('Login'),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return ResetPasswordScreen();
                }));
              },

                  child: const Text('Forgot password?',
                      style: TextStyle(
                        color: Color(0xFF2196F3),
                        decoration: TextDecoration.underline,
                      )),
                ),
                const Text(
                  ' or ',
                ),
                GestureDetector(
                  onTap: () {
                    // Navigate to the create account screen
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return CreateAccountScreen();
                    }));
                  },
                  child: const Text(
                    'create account',
                    style: TextStyle(
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}