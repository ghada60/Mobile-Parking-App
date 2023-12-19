import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
   List<ListItem> _dropdownItems = [  
    ListItem(1, "GeeksforGeeks"),  
    ListItem(2, "Javatpoint"),  
    ListItem(3, "tutorialandexample"),  
    ListItem(4, "guru99")  
  ];  
  
  List<DropdownMenuItem<ListItem>>? _dropdownMenuItems;  
  ListItem? _itemSelected;  
  
  void initState() {  
    super.initState();  
    _dropdownMenuItems = buildDropDownMenuItems(_dropdownItems);  
    _itemSelected = _dropdownMenuItems![1].value;  
  }  
  
  List<DropdownMenuItem<ListItem>> buildDropDownMenuItems(List listItems) {  
    List<DropdownMenuItem<ListItem>> items = [];  
    for (ListItem listItem in listItems) {  
      items.add(  
        DropdownMenuItem(  
          child: Text(listItem.name),  
          value: listItem,  
        ),  
      );  
    }  
    return items;  
  }  
  @override
  Widget build(BuildContext context) {
    return Scaffold(

    // login form with logo up
  body: SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
      // login form with logo up
      Center(child: Image.asset('assets/motah_logo.jpeg',
      width: 150,
      height: 300,
      ), heightFactor: 1),
      SizedBox(height: 20),
      Center(child: Text('Enter your email!', style: GoogleFonts.aladin(fontSize: 30, color: Colors.blueGrey))),
      SizedBox(height: 20),
      // text field for email
      Center(child: Container(
        height: 50,
        width: 300,
        child: TextField(
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'someone@example.com',
          ),
        ))),
  
      SizedBox(height: 20),
      Center(child: Container(
        height: 50,
        width: 300,
        child: ElevatedButton(onPressed: () {}, child: Text('Sign in', style: GoogleFonts.aladin(fontSize: 20, color: Colors.white))))),
  DropdownButtonHideUnderline(  
    child: DropdownButton(  
        value: _itemSelected,  
        items: _dropdownMenuItems,  
        onChanged: (value) {  
          setState(() {  
            _itemSelected = value;  
          });  
        }),  
  ),  
  Text("We have selected ${_itemSelected!.name}"),  
      ],),
  )
    );
  }
}

class ListItem {  
  int value;  
  String name;  
  
  ListItem(this.value, this.name);  
}  