import 'package:anti_corruption_app_final/Helper/Service/FirebaseOperation.dart';
import 'package:anti_corruption_app_final/Helper/Utils/Utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HelperWidgets with ChangeNotifier {
  showCircleAvatar(BuildContext context) {
    return CircleAvatar(
      radius: 50,
      backgroundColor: Colors.grey,
      backgroundImage: FileImage(
          Provider.of<SignUpUtils>(context, listen: false).userAvatar),
    );
  }

  showUserAvatar(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            height: MediaQuery.of(context).size.height * .4,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.grey,
                  backgroundImage: FileImage(
                      Provider.of<SignUpUtils>(context, listen: false)
                          .userAvatar),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      child: Text("RESELECT",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold),
                      ),
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        primary: Colors.orange,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                      onPressed: () {
                       Provider.of<SignUpUtils>(context, listen: false).selectAvatarOptionSheet(context);
                      },
                    ),
                    ElevatedButton(
                      child: Text("CONFIRM",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold),
                      ),
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        primary: Colors.orange,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                      onPressed: () {
                        Provider.of<FirebaseOperation>(context, listen: false).uploadUserAvatar(context);
                      },
                    ),
                  ],
                ),
              ],
            ),
          );
        });
  }
}
