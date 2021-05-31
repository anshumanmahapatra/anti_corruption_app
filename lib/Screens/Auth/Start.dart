import 'package:anti_corruption_app_final/Helper/Utils/Utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Start extends StatefulWidget {
  @override
  _StartState createState() => _StartState();
}

class _StartState extends State<Start> {

  navigateToLogin() async {
    Navigator.pushReplacementNamed(context, "Login");
  }

  navigateToRegister() async {
    Navigator.pushReplacementNamed(context, "SignUp");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: <Widget>[
            SizedBox(height: 35.0),
            Container(
              height: 400,
              child: Image(image: AssetImage("images/logo.jpg"),
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(height: 20.0),
            Container(
              margin: EdgeInsets.fromLTRB(35.0, 0.0, 35.0, 0.0),
              child: RichText(
                text: TextSpan(
                  text: 'Welcome to ', style: TextStyle(
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black
                ),
                ),
              ),
            ),
            SizedBox(height: 10.0),
            Text('GABBAR',
              style: TextStyle(
                color:Colors.orange,
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
              ),),
            SizedBox(height: 30.0),
            Row(mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(

                    onPressed: navigateToLogin,
                    child: Text('LOGIN', style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.only(left: 30, right: 30),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        primary: Colors.orange,
                    ),
                ),
                SizedBox(width: 20.0),
                ElevatedButton(
                    onPressed: () {
                      Provider.of<SignUpUtils>(context, listen: false).selectAvatarOptionSheet(context);
                    },
                    child: Text('REGISTER', style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.only(left: 30, right: 30),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    primary: Colors.orange,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10,),
            Text("OR",
              style: TextStyle(
                fontSize: 15,
                color: Colors.grey,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(height: 10,),
            ElevatedButton(
              onPressed: () {},
              child: Text('SIGN IN WITH GOOGLE', style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.only(left: 30, right: 30),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                primary: Colors.orange,
              ),
            ),
          ],
        ),
      ),
    );
  }
}


