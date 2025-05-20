import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'home_page.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  bool isLoading = false;

  // Helper to show alert dialogs for messages
  void showMessage(String message) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text("Message"),
        content: Text(message),
        actions: [
          TextButton(
            child: Text("OK"),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  // User login logic with Parse Server
  Future<void> login() async {
    setState(() => isLoading = true);

    final user = ParseUser(usernameController.text.trim(), passwordController.text.trim(), null);
    final response = await user.login();

    setState(() => isLoading = false);

    if (response.success) {
      // Navigate to HomePage after successful login
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => HomePage()));
    } else {
      showMessage(response.error?.message ?? "Unknown error during login.");
    }
  }

  // User sign-up logic with Parse Server
  Future<void> signUp() async {
    setState(() => isLoading = true);

    final user = ParseUser(
      usernameController.text.trim(),
      passwordController.text.trim(),
      '${usernameController.text.trim()}@app.com',
    );

    final response = await user.signUp();

    setState(() => isLoading = false);

    if (response.success) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => HomePage()));
    } else {
      showMessage(response.error?.message ?? "Unknown error during sign up.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("School Admin Login")),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Icon(Icons.book, size: 100, color: Colors.blue),
                SizedBox(height: 20),

                // Username input
                TextField(
                  controller: usernameController,
                  decoration: InputDecoration(labelText: "Username"),
                ),

                // Password input
                TextField(
                  controller: passwordController,
                  decoration: InputDecoration(labelText: "Password"),
                  obscureText: true,
                ),

                SizedBox(height: 20),

                // Show loading spinner or login/signup buttons
                isLoading
                    ? CircularProgressIndicator()
                    : Column(
                        children: [
                          ElevatedButton(onPressed: login, child: Text("Login")),
                          TextButton(onPressed: signUp, child: Text("Sign Up")),
                        ],
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
