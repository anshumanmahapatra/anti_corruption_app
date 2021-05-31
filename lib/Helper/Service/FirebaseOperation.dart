
import 'package:anti_corruption_app_final/Helper/Service/AuthServices.dart';
import 'package:anti_corruption_app_final/Helper/Utils/Utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FirebaseOperation with ChangeNotifier {

  UploadTask imageUploadTask;

  Future uploadUserAvatar(BuildContext context) async{
    Reference imageReference = FirebaseStorage.instance.ref().child(
        'userProfileAvatar/${Provider.of<SignUpUtils>(context, listen:false)
            .getUserAvatar.path}/${TimeOfDay.now()}'
    );
    imageUploadTask = imageReference.putFile(Provider.of<SignUpUtils>(context, listen:false).getUserAvatar);
    await imageUploadTask.whenComplete(() {
      imageReference.getDownloadURL().then((url) {
        Provider.of<SignUpUtils>(context).userAvatarUrl = url.toString();
        print( "The user Profile Avatar Url is : ${Provider.of<SignUpUtils>(context, listen: false).userAvatarUrl = url.toString()}");
      });
      print("Image Uploaded");
      notifyListeners();
    } );
  }

  Future createUserCollection(BuildContext context, dynamic data) async {
    return FirebaseFirestore.instance
        .collection("Users")
        .doc(Provider.of<Authentication>(context, listen: false).getUserUid)
        .set(data);
  }
}