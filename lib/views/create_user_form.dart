import 'package:flutter/material.dart';
import 'package:motah/services/firebase_auth_admin.dart';
import 'package:motah/widgets/custom_widgets.dart';

class CreateUserForm extends StatefulWidget {
  const CreateUserForm({super.key});

  @override
  State<CreateUserForm> createState() => _CreateUserFormState();
}

class _CreateUserFormState extends State<CreateUserForm> {
  // email controller
  TextEditingController emailController = TextEditingController();
  // password controller
  TextEditingController passwordController = TextEditingController();
  // display name controller
  TextEditingController displayNameController = TextEditingController();

  // form key
  final _formKey = GlobalKey<FormState>();

  // firebase auth admin service
  FirebaseAuthAdminService firebaseAuthAdminService =
      FirebaseAuthAdminService();
  @override
  Widget build(BuildContext context) {
    // height
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: MotahAppBar(context, "Add User", height * 0.15, false),

        body: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: emailController,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: passwordController,
                autovalidateMode: AutovalidateMode.onUserInteraction,

                decoration: InputDecoration(labelText: 'Password'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: displayNameController,
                autovalidateMode: AutovalidateMode.onUserInteraction,

                decoration: InputDecoration(labelText: 'Display Name'),
                validator: ((value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                }),
              ),
              ElevatedButton(
                onPressed: () async{
                  if (_formKey.currentState!.validate()) {
                    // print all feilds
                    print("Email: ${emailController.text}");
                    print("Password: ${passwordController.text}");
                    print("Display Name: ${displayNameController.text}");
                    bool isCreated = await firebaseAuthAdminService.createUser(emailController.text, passwordController.text, displayNameController.text);
                    if (isCreated) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('User Created')));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('User Creation Failed')));
                    }
                  }
                },
                child: Text('Create User'),
              )
            ],
          ),
        )
    );
  }
}