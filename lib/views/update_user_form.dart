import 'package:flutter/material.dart';
import 'package:motah/models/local_user.dart';
import 'package:motah/services/firebase_auth_admin.dart';
import 'package:motah/widgets/custom_widgets.dart';

class UpdateUserForm extends StatefulWidget {
  UpdateUserForm({super.key, required this.user});
  LocalUser? user;
  @override
  State<UpdateUserForm> createState() => _UpdateUserFormState();
}

class _UpdateUserFormState extends State<UpdateUserForm> {
  final TextEditingController _emailController =
        TextEditingController();
    final TextEditingController _displayNameController =
        TextEditingController();
  FirebaseAuthAdminService _authService = FirebaseAuthAdminService();
  // form key
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    // height
    double height = MediaQuery.of(context).size.height;
    // text editing controller
    _emailController.text = widget.user!.email.toString();
    _displayNameController.text = widget.user!.displayName.toString();
    return Scaffold(
        appBar: MotahAppBar(context, "Update User", height * 0.15, false),
        body: Form(
          key: _formKey,
          child: Column(
            children: [
              // email with show initial value
              TextFormField(
                controller: _emailController,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Email',
                ),
              ),
              TextFormField(
                controller: _displayNameController,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Display Name',
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    // update user
                    bool isUpdated = await _authService.updateUser(
                        uid: widget.user!.uid.toString(),
                        email: _emailController.text,
                        displayName: _displayNameController.text);
                    if (isUpdated) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('User updated')));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('User not updated')));
                    }
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Please fill the form')));
                  }
                },
                child: Text('Update'),
              )
            ],
          ),
        ));
  }
}
