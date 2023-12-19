import 'package:flutter/material.dart';
import 'package:motah/views/reports_view.dart';
import 'package:motah/views/user_manage_view.dart';


class HomeNavBar extends StatefulWidget {
  const HomeNavBar({super.key});

  @override
  State<HomeNavBar> createState() => _HomeNavBarState();
}

class _HomeNavBarState extends State<HomeNavBar> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // customized outlined button with icon and text for traffic report
        OutlinedButton.icon(
          onPressed: () {
            // index 2
            Navigator.push(context, MaterialPageRoute(builder: (context) => ReportsView()));
          },
          icon: Icon(Icons.insert_chart_outlined_sharp),
          label: Text('Traffic Report'),
        ),
        
        // user management button
        OutlinedButton.icon(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => UserManageView()));
          },
          icon: Icon(Icons.person),
          label: Text('User Management'),
        ),
      ],
    );
  }
}