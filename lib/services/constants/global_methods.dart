// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
User? user = FirebaseAuth.instance.currentUser;
String? name = '';
String? fanId = '';
String? userImage = '';
String? myschool = '';
String? myrole = '';

///messgae
///
String? messageSub = '';
String? messageContent = '';

String loginUrlImage =
    'https://firebasestorage.googleapis.com/v0/b/team-cra.appspot.com/o/userImages%2Fwex.jpg?alt=media&token=873cb15a-056f-4c2e-a4da-b648a5175217';
String loginImage = 'assets/images/login.png';
String signUpImage = 'assets/images/signup.png';
String wallpaperImage = 'assets/images/cralogo.png';

class GlobalMethod {
  static void showErrorDialog(
      {required String error, required BuildContext ctx}) {
    showDialog(
        context: ctx,
        builder: (context) {
          return AlertDialog(
            icon: const Icon(Icons.notification_important),
            title: const Text('OOps!'),
            content: Text(error),
          );
        });
  }

  static void showLogoutDialog({required BuildContext ctx}) {
    showDialog(
        context: ctx,
        builder: (context) {
          return AlertDialog(
            icon: const Icon(Icons.bed),
            backgroundColor: Colors.white,
            title: Row(
              children: const [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.logout_outlined,
                    size: 30,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('Sign Out'),
                ),
              ],
            ),
            content: const Text('Are You about to Log Out?'),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.canPop(context) ? Navigator.pop(context) : null;
                  },
                  child: const Text("NO")),
              TextButton(
                  onPressed: () {
                    _auth.signOut();
                    Navigator.canPop(context) ? Navigator.pop(context) : null;
                  },
                  child: const Text("Yes")),
            ],
          );
        });
  }

  static void showReplyDialog({
    required BuildContext ctx,
    required String token,
  }) {}
}
