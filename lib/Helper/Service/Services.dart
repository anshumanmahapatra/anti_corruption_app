import 'package:anti_corruption_app_final/Helper/Model/UserModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {

  final String uid;
  Map data;
  DatabaseService({ this.uid });

  Future<void> addQuizData(Map quizData, String quizId) async {
    await FirebaseFirestore.instance
        .collection("Quiz")
        .doc(quizId)
        .set(quizData)
        .catchError((e) {
      print(e.toString());
    });
  }

  Future<void> addComplaintData(Map formData, String formId) async {
    await FirebaseFirestore.instance
        .collection("Complaint")
        .doc(formId)
        .set(formData)
        .catchError((e) {
      print(e.toString());
    });
  }

  Future<void> addQuestionData(Map questionData, String quizId) async {
    await FirebaseFirestore.instance
    .collection("Quiz")
    .doc(quizId)
    .collection("QNA")
    .add(questionData)
    .catchError((e){
      print(e.toString());
    });
  } 

  Future<void> addForumData (blogData) async {
    await FirebaseFirestore.instance
        .collection("Forum")
        .add(blogData)
        .catchError( (e) {
          print(e.toString());
    });
  }

  Future updateUserData( String email, String name) async {
    return await FirebaseFirestore.instance
        .collection("Users")
        .doc(uid)
        .set(
      {
        'Email Id' : email,
        'User Name' : name,
        'UID' : uid,
      }
    );
  }

  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
        uid: uid,
        name: snapshot.data()["name"],
        email: snapshot.data()['email'],
    );
  }

  Stream<UserData> get userData {
    return FirebaseFirestore.instance
        .collection("Users")
        .doc(uid)
        .snapshots()
        .map(_userDataFromSnapshot);
  }

  getUserData() async {
    return await FirebaseFirestore.instance
        .collection("Users")
        .snapshots();
  }

  getQuizData() async {
    return await FirebaseFirestore.instance
        .collection("Quiz")
        .snapshots();
}
  getInsideQuizData(String quizId) async {
    return await FirebaseFirestore.instance
        .collection("Quiz")
        .doc(quizId)
        .collection("QNA")
        .snapshots();
  }

  getForumData() async{
    return await FirebaseFirestore.instance
        .collection("Forum")
        .snapshots();
  }
}


