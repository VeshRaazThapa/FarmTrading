import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatefulWidget {
  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

 @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text("Forgot Password"),
    ),
    body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Align(
        alignment: Alignment.topCenter,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 100.0), // Add padding here
              child: Image.asset(
                "assets/logo_app.png",
                height: 100,
                width: 100,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(color: Colors.grey),
              ),
              child: TextField(
                controller: _newPasswordController,
                obscureText: true,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 10.0),
                  labelText: "New Password",
                  border: InputBorder.none,
                ),
              ),
            ),
            SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(color: Colors.grey),
              ),
              child: TextField(
                controller: _confirmPasswordController,
                obscureText: true,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 10.0),
                  labelText: "Confirm Password",
                  border: InputBorder.none,
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed:(){},
              child: Text("Save New Password"),
            ),
          ],
        ),
      ),
    ),
  );
}
}