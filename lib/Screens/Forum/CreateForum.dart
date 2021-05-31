
import 'package:firebase_auth/firebase_auth.dart';
import '../../Helper/Widgets/RequiredWidgets.dart';
import '../../Helper/Service/Services.dart';
import 'package:flutter/material.dart';


class CreateForum extends StatefulWidget {
  @override
  _CreateForumState createState() => _CreateForumState();
}

FirebaseAuth _auth = FirebaseAuth.instance;
User user = _auth.currentUser;
final   uid = user.uid;


class _CreateForumState extends State<CreateForum> {

  final GlobalKey<FormState> _newFormKey = GlobalKey<FormState>();
  String name, title, desc;
  bool _isLoading = false;
  TextEditingController controller;
  DatabaseService databaseService = new DatabaseService(uid: uid);
  Stream userStream;

  uploadBlog () async {
    if (_newFormKey.currentState.validate()) {
      setState(() {
        _isLoading = true;
      });


      Map <String, String> forumMap = {
        "title": title,
        "desc": desc,
        "name": name,
      };

      await databaseService.addForumData(forumMap).then((result) {
        setState(() {
          _isLoading = false;
          Navigator.of(context).pop();
        });
      });
    }
  }

  @override
  void initState() {
    databaseService.getUserData().then((val) {
      setState(() {
        userStream = val;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: appBar(context, "Create Post"),
          backgroundColor: Colors.orange,
          actions: <Widget>[
            GestureDetector(
              onTap: () {
                uploadBlog();
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Icon(Icons.file_upload,),
              ),
            )
          ],
        ),
        body: StreamBuilder(
          stream: userStream,
          builder: (context, snapshot) {
              return  Form(
                key: _newFormKey,
                child: _isLoading ? Container(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
                    : Container(
                  margin: EdgeInsets.only(top: 20),
                  width: MediaQuery.of(context).size.width-24,
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          children: <Widget>[
                            TextFormField(
                              controller: controller,
                              initialValue: snapshot.data.documents[0].data()["User Name"],
                              onSaved: (val) {
                                val = controller.text;
                                print(val);
                                name = val;
                              },
                            ),
                            TextFormField(
                              validator: (val) =>
                              val.isEmpty ? "Enter Title" : null,
                              decoration: InputDecoration(
                                hintText: "Title",
                              ),
                              onChanged: (val) {
                                title = val;
                              },
                            ),
                            TextFormField(
                              validator: (val) =>
                              val.isEmpty ? "Enter Description" : null,
                              decoration: InputDecoration(
                                hintText: "Description",
                              ),
                              onChanged: (val) {
                                desc = val;
                              },
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
          }
        )
    );
  }
}
