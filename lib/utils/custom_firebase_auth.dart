import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:scan_app/model/user_model.dart';
import 'package:firestore_search/firestore_search.dart';

class CustomFirebaseAuth {
  static final _auth = FirebaseAuth.instance;
  static const _storage = FlutterSecureStorage();

  static Future<void> signUp(String email, String passcode, String name) async {
    await _auth
        .createUserWithEmailAndPassword(email: email, password: passcode)
        .then((value) async => await postDetailsToFirestore(name))
        .catchError((e) {
      Fluttertoast.showToast(msg: e!.message);
    });
  }

  static Future<String?> checkLoginStatus() async {
    String? value = await _storage.read(key: "uid");
    if (value == null) {
      return " ";
    } else {
      Future<String?> name = _storage.read(key: "name");
      return name;
    }
  }

  static Future<void> login(String email, String password) async {
    UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
    await _storage.write(key: "uid", value: userCredential.user?.uid);
    await _auth
        .signInWithEmailAndPassword(email: email, password: password)
        .then((uid) => {Fluttertoast.showToast(msg: "Login Successful")})
        .catchError((e) {
      Fluttertoast.showToast(msg: e.message);
    });
  }

  static Future<void> postDetailsToFirestore(String name) async {
    /*Calling Firestore 
    Calling user Model
    Sending Values */
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;
    UserModel userModel = UserModel();
    // Writing all the values
    userModel.uid = user!.uid;
    userModel.name = name;
    userModel.email = user.email;
    await firebaseFirestore
        .collection("users")
        .doc(user.uid)
        .set(userModel.toMap());
    Fluttertoast.showToast(msg: "Account Created Successfully");
  }
}
