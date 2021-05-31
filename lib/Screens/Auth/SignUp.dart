import 'package:anti_corruption_app_final/Helper/Service/AuthServices.dart';
import 'package:anti_corruption_app_final/Helper/Service/FirebaseOperation.dart';
import 'package:anti_corruption_app_final/Helper/Utils/Utils.dart';
import 'package:anti_corruption_app_final/Helper/Widgets/HelperWidgets.dart';
import 'package:anti_corruption_app_final/Screens/Auth/Login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool showPassword;
  String name, email, password;

  checkAuthentication() async {
    _auth.authStateChanges().listen((user) async {
      if (user != null) {
        Navigator.pushReplacementNamed(context, "/"); //correction
      }
    });
  }

  @override
  void initState() {
    super.initState();
    this.checkAuthentication();
    showPassword = true;
  }


  showError(String errorMessage) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('ERROR'),
            content: Text(errorMessage),
            actions: <Widget>[
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'))
            ],
          );
        });
  }

  navigateToLogin() async {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Login()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: <Widget>[
                Container(
                  height: 400,
                  child: Image(
                    image: AssetImage("images/login.jpg"),
                    fit: BoxFit.contain,
                  ),
                ),
                Container(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        GestureDetector(
                          child: Provider.of<HelperWidgets>(context, listen: false).showCircleAvatar(context),
                          onTap: () {
                            Provider.of<SignUpUtils>(context, listen: false).selectAvatarOptionSheet(context);
                          },
                        ),
                        Container(
                          child: TextFormField(
                              validator: (val) => val.isEmpty ? "Enter Name" : null,
                              decoration: InputDecoration(
                                labelText: 'Name (Enter a funny or fictious name)',
                                prefixIcon: Icon(Icons.person),
                              ),
                            onSaved: (input) {
                              name = input;
                            },
                          ),
                        ),
                        Container(
                          child: TextFormField(
                              validator: (val) => val.isEmpty ? "Enter Email" : null,
                              decoration: InputDecoration(
                                  labelText: 'Email',
                                  prefixIcon: Icon(Icons.email)),
                            onSaved: (input) {
                              email = input;
                            },
                              ),
                        ),
                        Container(
                          child: TextFormField(
                              validator: (val) => val.isEmpty ? "Enter Password" : null,
                              decoration: InputDecoration(
                                labelText: 'Password',
                                prefixIcon: Icon(Icons.lock),
                                suffix: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      showPassword = !showPassword;
                                    });
                                  },
                                  child: showPassword ? Icon(Icons.visibility) : Icon(Icons.visibility_off),
                                ),
                              ),
                              obscureText: showPassword,
                            onSaved: (input) {
                              password = input;
                            },
                              ),
                        ),
                        SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () {
                            if(_formKey.currentState.validate()) {
                              _formKey.currentState.save();
                              try{
                                Provider.of<Authentication>(context, listen: false)
                                    .createAccount(email, name, password)
                                    .whenComplete(() {
                                  Provider.of<FirebaseOperation>(context, listen: false)
                                      .createUserCollection(context,
                                      {
                                        "uid" :  Provider.of<Authentication>(context, listen: false).getUserUid,
                                        "email" : email,
                                        "name" : name,
                                        "img" : Provider.of<SignUpUtils>(context, listen: false).getUserAvatarUrl,
                                      }
                                  ).whenComplete(() => Navigator.pushReplacementNamed(context, "/"));
                                }
                                );

                              } catch (e) {
                                showError(e.message);
                              }
                            }
                          },
                          child: Text('SignUp',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold)),
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.fromLTRB(70, 10, 70, 10),
                            primary: Colors.orange,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                          ),
                        ),
                        SizedBox(height: 7,),
                        GestureDetector(
                          child: Text('Already have an Account? Click here'),
                          onTap: navigateToLogin,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}

