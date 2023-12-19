import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:motah/views/forgot_password.dart';
import 'package:motah/helper/validators.dart';
import 'package:motah/views/home_page.dart';
import 'package:motah/views/preferences_view.dart';
import 'package:motah/services/auth_service.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:motah/widgets/custom_widgets.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  AuthService _authService = AuthService();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isLoading = false;
  // form key for validating the form
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
double height = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: MotahAppBar(context, "Login Page", height *0.15, false),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Row(
                children: [
                  // user preference button
                  IconButton(
                    icon: Icon(Icons.settings),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PreferencesPage(),
                        ),
                      );
                    },
                  ),
                ],
              ),
              // logo of the app
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
              Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: TextFormField(
                        controller: emailController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: AppLocalizations.of(context)!.email,
                        ),
                        validator: (value) =>
                            Validators.emailValidation(context, value),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                      child: TextFormField(
                        obscureText: true,
                        controller: passwordController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: AppLocalizations.of(context)!.password,
                        ),
                        validator: (value) =>
                            Validators.passwordValidation(context, value),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        //forgot password screen
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ForgotPasswordPage(),
                          ),
                        );
                      },
                      child: Text(
                        AppLocalizations.of(context)!.forgot_password,
                        
                      ),
                    ),
                  ],
                ),
              ),

              Row(children: [
                Expanded(
                  child: Container(
                      height: 50,
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: ElevatedButton(
                        child: isLoading
                            ? CircularProgressIndicator()
                            : Text(AppLocalizations.of(context)!.sign_in,
                                style: Theme.of(context).textTheme.button),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            setState(() {
                              isLoading = true;
                            });
                            try {
                              var userEitherException =
                                  await _authService.signInWithEmailAndPassword(
                                emailController.text.trim(),
                                passwordController.text.trim(),
                              );
                              // if user is subtype of user, or firebaseauthexception is thrown, then show error message
                              if (userEitherException is User) {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => MyHomePage()));
                              }

                              if (userEitherException is String) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: Text(userEitherException.toString()),
                                  duration: Duration(seconds: 2),
                                ));
                              }
                              setState(() {
                                isLoading = false;
                              });
                            } catch (e) {
                              // show snackbar with error message
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text(e.toString()),
                                duration: Duration(seconds: 2),
                              ));
                              setState(() {
                                isLoading = false;
                              });
                            }
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(AppLocalizations.of(context)!
                                  .complete_all_fields),
                              duration: Duration(seconds: 2),
                            ));
                            setState(() {
                              isLoading = false;
                            });
                          }
                        },
                      )),
                ),
              ]),
            ],
          ),
        ));
  }
}
