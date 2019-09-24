import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:scoped_model/scoped_model.dart';

class UserModel extends Model {
  bool isLoading = false;

  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser firebaseUser;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  Map<String, dynamic> userData = Map();

  void signUp(
      {@required Map<String, dynamic> userData,
      @required String pass,
      @required VoidCallback onSuccess,
      @required VoidCallback onFail}) {
    isLoading = true;
    notifyListeners();

    _auth
        .createUserWithEmailAndPassword(
            email: userData["email"], password: pass)
        .then((user) async {
      firebaseUser = user;
      await _saveUserData(userData);

      onSuccess();
      isLoading = false;
      notifyListeners();
    }).catchError((e) {
      onFail();
      isLoading = false;
      notifyListeners();
    });
  }

  void signInWithGoogle(
      {@required VoidCallback onSuccess, @required VoidCallback onFail}) async {
    isLoading = true;
    notifyListeners();
    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    _auth.signInWithCredential(credential).then((user) {
      firebaseUser = user;
      var loggedUserData = {
        "name": firebaseUser.displayName,
        "email": firebaseUser.email,
        "id": firebaseUser.uid
      };
      _saveUserData(loggedUserData);
      onSuccess();
      isLoading = false;
      notifyListeners();
    }).catchError((e) {
      onFail();
      isLoading = false;
      notifyListeners();
    });
  }

  // Future<Null> signInWithGoogle(
  //     {@required VoidCallback onSuccess, @required VoidCallback onFail}) async {
  //   isLoading = true;
  //   notifyListeners();
  //   GoogleSignInAccount user = googleSignIn.currentUser;
  //   if (user == null) {
  //     user = await googleSignIn.signInSilently();
  //   }
  //   if (user == null) {
  //     user = await googleSignIn.signIn();
  //   }
  //   if (await _auth.currentUser() == null) {
  //     GoogleSignInAuthentication credentials =
  //         await googleSignIn.currentUser.authentication;
  //     _auth
  //         .signInWithCredential(
  //       GoogleAuthProvider.getCredential(
  //         idToken: credentials.idToken,
  //         accessToken: credentials.accessToken,
  //       ),
  //     )
  //         .then((user) {
  //       print("bbbbbbbbbbbb");
  //       firebaseUser = user;
  //       print(user);
  //       isLoading = false;
  //       notifyListeners();
  //     }).catchError((e) {
  //       print("aaaaaaaaaaaaaaaaa");
  //     });
  //   }
  // }

  void signIn() async {
    isLoading = true;
    notifyListeners();
  }

  void signOut() async {
    await _auth.signOut();
    userData = Map();
    firebaseUser = null;
    notifyListeners();
  }

  void recoverPass() {}

  bool isLoggedIn() {
    return firebaseUser != null;
  }

  Future<Null> _saveUserData(Map<String, dynamic> userData) async {
    this.userData = userData;
    await Firestore.instance
        .collection("users")
        .document(firebaseUser.uid)
        .setData(userData);
  }

  getUserName() {
    return firebaseUser.displayName;
  }
}
