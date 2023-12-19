// ignore_for_file: non_constant_identifier_names, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:motah/services/auth_service.dart';
import 'package:motah/views/welcome_page.dart';
import 'package:motah/widgets/clipper.dart';

PreferredSize MotahAppBar(context, String title, double height, bool isHome) {
  return PreferredSize(
    preferredSize: Size.fromHeight(height),
    child: ClipPath(
      clipper: WaveClipper(),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromRGBO(224, 64, 251, 1),
              Color.fromRGBO(90, 70, 178, 1),
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: 20,
                ),
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                isHome
                    ? IconButton(
                        icon: Icon(
                          Icons.logout,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          // TODO: logout
                          AuthService().signOut();
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => WelcomePage()));

                        },
                      )
                    : IconButton(onPressed: (){
                      Navigator.pop(context);
                    }, icon: Icon(Icons.arrow_forward_ios, color: Colors.white)),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
