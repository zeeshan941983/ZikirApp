import 'package:al_zikr/utils/Navigation.dart';
import 'package:al_zikr/Backend/auth/Services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                dynamic user = await context.read<AuthService>().login(
                      _emailController.text.trim(),
                      _passwordController.text.trim(),
                    );
                if (user != null) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => NavigationScreen()),
                  );
                } else {
                  // Show error message
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Login failed'),
                    ),
                  );
                }
              },
              child: Text('Login'),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignupPage()),
                );
              },
              child: Text('Create an account'),
            ),
          ],
        ),
      ),
    );
  }
}

class SignupPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                labelText: 'Username',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                dynamic user = await context.read<AuthService>().signUp(
                      _emailController.text.trim(),
                      _passwordController.text.trim(),
                      _usernameController.text.trim(),
                    );
                if (user != null) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => NavigationScreen()),
                  );
                } else {
                  // Show error message
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Sign up failed'),
                    ),
                  );
                }
              },
              child: Text('Sign Up'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Back to Login'),
            ),
          ],
        ),
      ),
    );
  }
}
