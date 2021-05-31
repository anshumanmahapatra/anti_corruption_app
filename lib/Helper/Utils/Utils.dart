import 'dart:io';
import 'package:anti_corruption_app_final/Helper/Widgets/HelperWidgets.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class SignUpUtils with ChangeNotifier {
  final picker = ImagePicker();
  File userAvatar;
  File  get getUserAvatar => userAvatar;
  String userAvatarUrl;
  String get getUserAvatarUrl => userAvatarUrl;

  Future pickUserAvatar (BuildContext context, ImageSource imageSource) async {
    final pickedUserAvatar = await picker.getImage(source: imageSource);
    pickedUserAvatar == null ? print("Select Image") : userAvatar = File(pickedUserAvatar.path);
    print(userAvatar.path);

    userAvatar != null ? Provider.of<HelperWidgets>(context, listen: false).showUserAvatar(context) : print("Image Upload Error");
    notifyListeners();

  }

  Future selectAvatarOptionSheet(BuildContext context) async {
    return showModalBottomSheet(context: context, builder: (context) {
      return Container(
        height: MediaQuery.of(context).size.height *.2,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
       child: Column(
         mainAxisAlignment: MainAxisAlignment.center,
         children: [
           Text("Select an Image",
             style: TextStyle(
               fontSize: 20,
               fontWeight: FontWeight.w700,
             ),
           ),
           SizedBox(height: 10,),
           Row(
             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
             crossAxisAlignment: CrossAxisAlignment.center,
             children: [
               ElevatedButton(
                 child: Text("CAMERA",
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
                   pickUserAvatar(context, ImageSource.camera).whenComplete(() {
                    Navigator.pop(context);
                    Provider.of<HelperWidgets>(context, listen: false).showUserAvatar(context);
                   } );
                 },
               ),
               ElevatedButton(
                 child: Text("GALLERY",
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
                   pickUserAvatar(context, ImageSource.gallery).whenComplete(() {
                     Navigator.pop(context);
                     Provider.of<HelperWidgets>(context, listen: false).showUserAvatar(context);
                   } );
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