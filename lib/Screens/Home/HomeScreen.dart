import 'dart:async';

import 'package:anti_corruption_app_final/Helper/Constants/youtubeConstants.dart';
import 'package:anti_corruption_app_final/Helper/Widgets/SlideIndicator.dart';
import 'package:anti_corruption_app_final/Screens/testData.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../Helper/Constants/carouselConstansts.dart';
import '../../Helper/widgets/YoutubeVideoTile.dart';
import '../../Screens/Forum/ForumHomePage.dart';
import '../../Screens/Home/ProfilePage.dart';
import '../../Screens/MachineLearning/MachineLearning.dart';
import '../Article/ArticlesPage.dart';
import '../Complaint/ComplaintHome.dart';
import '../Quiz/QuizHome.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User user;
  bool isloggedin = false;
  var imgList = carouselConstants;
  PageController pageController = new PageController();
  List<Map<String, String>> youtubeData = youtubeVideoData;

  checkAuthentification() async {
    _auth.authStateChanges().listen((user) {
      if (user == null) {
        Navigator.pushReplacementNamed(context, "start");
      }
    });
  }

  getUser() async {
    User firebaseUser = _auth.currentUser;
    await firebaseUser?.reload();
    firebaseUser = _auth.currentUser;

    if (firebaseUser != null) {
      setState(() {
        this.user = firebaseUser;
        this.isloggedin = true;
      });
    }
    return firebaseUser;
  }

  signOut() async {
    _auth.signOut();
  }

  @override
  void initState() {
    super.initState();
    this.checkAuthentification();
    this.getUser();
    Timer.periodic( Duration(seconds: 3), (timer) {
        double nextPage = pageController.page + 1;
        if(pageController.page == imgList.length - 1) {
          pageController.animateToPage(
              0,
              duration: Duration(seconds: 1), curve: Curves.fastOutSlowIn);
        }
        else {
          pageController.animateToPage(
              nextPage.toInt(),
              duration: Duration(seconds: 1), curve: Curves.fastOutSlowIn);
        }
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      key: scaffoldKey,
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                  margin: EdgeInsets.zero,
                  padding: EdgeInsets.zero,
                  decoration: BoxDecoration(
                    color: Colors.orange,
                  ),
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ProfileView(
                                            userName: user.displayName,
                                            emailId: user.email,
                                          )));
                            },
                            child: CircleAvatar(
                              backgroundColor: Colors.blue,
                              radius: 25,
                              child: Container(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(25),
                                  child: Image.asset(
                                    "images/johnny.jpg",
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Spacer(),
                          Text("GABBAR",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 23,
                                  fontWeight: FontWeight.w800)),
                        ]),
                  )),
              ListTile(
                title: Row(
                  children: <Widget>[
                    Icon(
                      Icons.emoji_objects,
                      size: 31,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: Text(
                        'Take a Quiz',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    )
                  ],
                ),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => QuizzHome()));
                },
              ),
              Divider(
                thickness: 1,
                color: Colors.grey,
              ),
              ListTile(
                title: Row(
                  children: <Widget>[
                    Icon(
                      Icons.forum,
                      size: 31,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: Text(
                        'Forum',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    )
                  ],
                ),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ForumHomePage()));
                },
              ),
              Divider(
                thickness: 1,
                color: Colors.grey,
              ),
              ListTile(
                title: Row(
                  children: <Widget>[
                    Icon(
                      Icons.analytics,
                      size: 31,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: Container(
                        width: 220,
                        child: Text(
                          'Analytics and Machine Learning',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MachineLearning()));
                },
              ),
              Divider(
                thickness: 1,
                color: Colors.grey,
              ),
              ListTile(
                title: Row(
                  children: <Widget>[
                    Icon(
                      Icons.report_problem,
                      size: 31,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: Text(
                        'Lodge Complaint',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    )
                  ],
                ),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => FormScreen()));
                },
              ),
              Divider(
                thickness: 1,
                color: Colors.grey,
              ),
              ListTile(
                title: Row(
                  children: <Widget>[
                    Icon(
                      Icons.article,
                      size: 31,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: Text(
                        'Articles Page',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    )
                  ],
                ),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => BlogPost()));
                },
              ),
              Divider(
                thickness: 1,
                color: Colors.grey,
              ),
              ListTile(
                title: Row(
                  children: <Widget>[
                    Icon(
                      Icons.article,
                      size: 31,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: Text(
                        'Test Page',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    )
                  ],
                ),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => TestData()));
                },
              ),
              Divider(
                thickness: 1,
                color: Colors.grey,
              ),
              ListTile(
                title: Row(
                  children: <Widget>[
                    Icon(
                      Icons.settings,
                      size: 31,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: Text(
                        'Settings',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    )
                  ],
                ),
                onTap: () {},
              ),
              Divider(
                thickness: 1,
                color: Colors.grey,
              ),
              ListTile(
                title: Text(
                  "Privacy Policy",
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              ListTile(
                title: Text(
                  "Terms of Use",
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              toolbarHeight: 55,
              title: Text("Home",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
              ),
              backgroundColor: Colors.orange,
              brightness: Brightness.dark,
              elevation: 0,
              leading: GestureDetector(
                child: Icon(
                  Icons.menu,
                  color: Colors.white,
                ),
                onTap: () {
                  scaffoldKey.currentState.openDrawer();
                },
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(height: 20,),
            ),
            SliverToBoxAdapter(
              child: Row(
                children: [
                  SizedBox(width: 15,),
                  Text("Trending",
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontWeight: FontWeight.w600,
                      fontSize: 25,
                    ),
                  ),
                ],
              ),),
            SliverToBoxAdapter(
              child: SizedBox(height: 15,),
            ),
            SliverToBoxAdapter(
              child: LimitedBox(
                maxWidth: MediaQuery.of(context).size.width *.90,
                maxHeight: 200,
                child: PageView.builder(
                      controller: pageController,
                        itemCount: imgList.length,
                        itemBuilder: (BuildContext context, index) {
                          return Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: ClipRRect(
                              borderRadius: BorderRadius.all(Radius.circular(30)),
                              child: Container(
                                child: Image.asset(
                                  imgList[index],
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                          );
                        }),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(height:20,),
            ),
            SliverToBoxAdapter(
              child: SlideIndicator(
                pageController: pageController,
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(height: 20,),
            ),
            SliverToBoxAdapter(
              child: Row(
                children: [
                  SizedBox(width: 15,),
                  Text("Videos",
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontWeight: FontWeight.w600,
                      fontSize: 25,
                    ),
                  ),
                ],
              ),),
            SliverToBoxAdapter(
              child: SizedBox(height: 10,),
            ),
            SliverList(
                delegate: SliverChildBuilderDelegate(
                      (context, index) {
                    return YoutubeVideoTile(
                        img: youtubeData[index]["img"],
                        title: youtubeData[index]["title"],
                        postUrl: youtubeData[index]["postUrl"],
                        channelName: youtubeData[index]["channelName"],
                        logo: youtubeData[index]["logo"]);
                  },
                  childCount: youtubeData.length,
                )),
            SliverToBoxAdapter(
              child: SizedBox(height: 20,),
            ),
          ],
         ),
        );
  }
}
