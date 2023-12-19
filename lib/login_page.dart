import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:motah/helper/validators.dart';
import 'package:motah/preferences_view.dart';
import 'package:motah/services/auth_service.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:motah/views/home_page.dart';
import 'package:motah/welcome_page.dart';
import 'package:motah/widgets/widgets.dart';

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
    return Scaffold(
        appBar: myAppBar(context, false),
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
              Image.asset(
                'assets/motah_logo.jpeg',
                height: 200,
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
                      },
                      child: Text(
                        AppLocalizations.of(context)!.forgot_password,
                        style:
                            Theme.of(context).textTheme.titleMedium!.copyWith(
                                  color: Color(0xFF44c2c7),
                                ),
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

                              if (userEitherException
                                  is String) {
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
                          
                        },
                      )),
                ),
              ]),
              Row(
                children: <Widget>[
                  Text(AppLocalizations.of(context)!.dont_have_account,
                      style: Theme.of(context).textTheme.titleLarge),
                  TextButton(
                    child: Text(
                      AppLocalizations.of(context)!.create_one,
                      style: TextStyle(
                          fontSize:
                              Theme.of(context).textTheme.titleLarge!.fontSize),
                    ),
                    onPressed: () => Navigator.push(context,
                        MaterialPageRoute(builder: (context) => WelcomePage())),
                  ),
                ],
                mainAxisAlignment: MainAxisAlignment.center,
              ),
            ],
          ),
        ));
  }
}
