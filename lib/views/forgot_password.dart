import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:motah/services/auth_service.dart';
import 'package:motah/widgets/custom_widgets.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  AuthService _authService = AuthService();
  // email controller
  TextEditingController emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: MotahAppBar(context, "Forgot Password", height * 0.15, false),
        // login form with logo up
        body: SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // login form with logo up
            SizedBox(height: 20),
            Container(
                // circle avatar
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: Image.asset(
                  'assets/motah_logo.jpeg',
                  height: 200,
                ),
              ),
            SizedBox(height: 20),
            Center(
                child: Text('Enter your email!',
                    style: GoogleFonts.aladin(
                        fontSize: 30, color: Colors.blueGrey))),
            SizedBox(height: 20),
            // text field for email
            Center(
                child: Container(
                    height: 50,
                    width: 300,
                    // validation for email
                    child: TextFormField(
                      controller: emailController,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your email';
                        }
                        // regex for email validation
                        else if (!RegExp(
                                r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(value)) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Email',
                      ),
                    ))),
      
            SizedBox(height: 20),
            Center(
                child: Container(
                    height: 50,
                    width: 300,
                    child: ElevatedButton(
                        onPressed: () async{
                          if (_formKey.currentState!.validate()) {
                            Map resetPasswordResult = await _authService.resetPassword(emailController.text.trim());
                            if (resetPasswordResult.keys.contains(true)) {
                              String message = resetPasswordResult[true] ?? 'Something went wrong';
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(message)));
                            } else {
                              String message = resetPasswordResult[false] ?? 'Something went wrong';
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(message)));
                            }
                          }
                        },
                        child: Text('Reset Password',
                            style: GoogleFonts.aladin(
                                fontSize: 20, color: Colors.white))))),
          ],
        ),
      ),
    ));
  }
}
