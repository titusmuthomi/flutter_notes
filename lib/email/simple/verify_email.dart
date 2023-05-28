import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../services/constants/global_widgets.dart';
import '../../services/constants/theme.dart';
import 'authenticate.dart';

class VerifyEmail extends StatefulWidget {
  const VerifyEmail({super.key});
  static const name = '/verify_email';

  @override
  State<VerifyEmail> createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmail> {
  bool isEmailVerified = false;
  bool canResendEmail = false;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    // user needs to be created
    isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    // if not send Email
    if (!isEmailVerified) {
      sendVerificationEmail();
    }

    timer = Timer.periodic(
      const Duration(seconds: 5),
      (_) => checkEmailVerified(),
    );
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Themed.primaryColor,
        appBar: AppBar(
          backgroundColor: Themed.primaryColor,
          title: const Text(
            'Verify Email',
            textAlign: TextAlign.center,
          ),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                sizedBox50(),
                const Text(
                  'A Verification email has been sent to your Email \n This is OneTime',
                  style: TextStyle(fontSize: 20, color: Themed.white),
                  textAlign: TextAlign.center,
                ),
                formSizedBox(),
                ElevatedButton.icon(
                  icon: const Icon(
                    Icons.alternate_email,
                    color: Themed.primaryColor,
                  ),
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(300, 55),
                    backgroundColor: Themed.white,
                    textStyle: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w300),
                    shadowColor: Themed.shadow,
                  ),
                  onPressed: () =>
                      canResendEmail ? sendVerificationEmail() : null,
                  label: const Text(
                    'Resend Email',
                    style: TextStyle(
                      color: Themed.primaryColor,
                      fontSize: 30,
                    ),
                  ),
                ),
                formSizedBox(),
                ElevatedButton.icon(
                  icon: const Icon(
                    Icons.logout_outlined,
                    color: Themed.white,
                  ),
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(200, 45),
                    backgroundColor: Themed.primaryColor,
                    textStyle: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w300),
                    shadowColor: Themed.white,
                  ),
                  onPressed: () {
                    FirebaseAuth.instance.signOut();
                  },
                  label: const Text(
                    'Cancel',
                    style: TextStyle(
                      color: Themed.white,
                      fontSize: 30,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      );

  Future sendVerificationEmail() async {
    try {
      final user = FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification();

      setState(() => canResendEmail = false);

      await Future.delayed(const Duration(seconds: 30));
      setState(() => canResendEmail = true);
    } on FirebaseAuthException catch (e) {
      //send error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Themed.accentColor,
          content: Text(
            getMessageFromErrorCode(e.code),
            style: const TextStyle(color: Themed.white),
          ),
        ),
      );
    }
  }

  Future checkEmailVerified() async {
    // call after email verification
    try {
      if (isEmailVerified) timer?.cancel();
      //get status
      await FirebaseAuth.instance.currentUser?.reload();
      isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Themed.accentColor,
          content: Text(
            getMessageFromErrorCode(e.code),
            style: const TextStyle(color: Themed.white),
          ),
        ),
      );
    }
  }

  @override
  void dispose() {
    super.dispose();
  }
}
