import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:motah/preferences_view.dart';
import 'package:motah/services/auth_service.dart';
import 'package:motah/views/home_page.dart';
import 'package:motah/widgets/custom_widgets.dart';

import 'login_page.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      // appBar: MotahAppBar(context, "Welcome Page", height * 0.2, false),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Image.asset('assets/motah_logo.jpeg',
          // height: height * 0.2,
          // width: width * 0.2,
          // ),
          SizedBox(height: height * 0.05),
          Center(
              child: Text('Welcome to Motah',
                  style: GoogleFonts.aladin(
                      fontSize: 30, color: Colors.blueGrey))),
          SizedBox(height: height * 0.05),
          Center(
              child: Text('Please sign in to continue',
                  style: GoogleFonts.aladin(
                      fontSize: 20, color: Colors.blueGrey))),
          SizedBox(height: height * 0.05),
          Center(
              child: Container(
                  height: 50,
                  width: 300,
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginPage()));
                      },
                      child: Text('Sign in (Admin)',
                          style: GoogleFonts.aladin(
                              fontSize: 20, color: Colors.white))))),
          SizedBox(height: height * 0.05),
          Center(
              child: Text('or',
                  style: GoogleFonts.aladin(
                      fontSize: 20, color: Colors.blueGrey))),
          SizedBox(height: height * 0.05),
          Center(
              child: Container(
                  height: 50,
                  width: 300,
                  child: ElevatedButton(
                      onPressed: () async {
                        AuthService _authService = AuthService();
                        bool isSignedInSuccessfully =
                            await _authService.signInAsGuest();
                        if (isSignedInSuccessfully) {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MyHomePage()));
                        }
                      },
                      child: Text(
                        'Continue as a (Guest)',
                        style: GoogleFonts.aladin(
                            fontSize: 20, color: Colors.white),
                      )))),
          InkWell(
              onTap: () async {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => PreferencesPage()));
              },
              child: Text(
                'User preferences',
                style: GoogleFonts.aladin(fontSize: 20, color: Colors.blueGrey),
              )),
        ],
      ),
    );
  }
}
