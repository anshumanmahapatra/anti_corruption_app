import 'package:anti_corruption_app_final/Helper/Service/AuthServices.dart';
import 'package:anti_corruption_app_final/Helper/Utils/Utils.dart';
import 'package:anti_corruption_app_final/Helper/Widgets/HelperWidgets.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'Helper/Service/FirebaseOperation.dart';
import 'Screens/Home/HomeScreen.dart';
import 'Screens/Auth/Login.dart';
import 'Screens/Auth/SignUp.dart';
import 'Screens/Auth/Start.dart';
import 'package:flutter/material.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      child: MaterialApp(
        theme: ThemeData(
            primaryColor: Colors.orange
        ),
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
        routes: <String,WidgetBuilder> {
          "Login" : (BuildContext context) => Login(),
          "SignUp" : (BuildContext context) => SignUp(),
          "start" :  (BuildContext context) => Start(),
        },
      ),
      providers: [
        ChangeNotifierProvider(create: (_) => Authentication()),
        ChangeNotifierProvider(create: (_) => FirebaseOperation()),
        ChangeNotifierProvider(create: (_) => SignUpUtils()),
        ChangeNotifierProvider(create: (_) => HelperWidgets()),
      ],
    );
  }
}
