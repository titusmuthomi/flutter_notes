// ignore_for_file: use_build_context_synchronously

import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../services/constants/global_styles.dart';
import '../../services/constants/global_widgets.dart';
import '../../services/constants/theme.dart';
import 'authenticate.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});
  static const name = '/reset_password';

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();

    super.dispose();
  }

  bool loading = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
          title: const Text('Reset Password'),
          centerTitle: true,
          backgroundColor: Theme.of(context).primaryColor),
      backgroundColor: Theme.of(context).primaryColor,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    width: size.width * 0.5,
                    height: size.width * 0.5,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Icon(Icons.lock)
                        //Image.asset('assets/images/cralogo.png')
                        )),
              ),
              sizedBox50(),
              const Text(
                'Receive an email to reset your password',
                style: TextStyle(color: Themed.white, fontSize: 20),
              ),
              formSizedBox(),
              Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextFormField(
                        controller: emailController,
                        style: const TextStyle(color: Themed.white),
                        enableSuggestions: true,
                        cursorColor: Themed.white,
                        cursorHeight: 22.0,
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        decoration: FormStyle.authDark.copyWith(
                          label: const Text(
                            'Email',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 22.0,
                            ),
                          ),
                        ),
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              EmailValidator.validate(value) == false) {
                            return 'Enter valid email';
                          }
                          return null;
                        },
                      ),
                    ),
                    formSizedBox(),
                    loading
                        ? const Center(
                            child: SizedBox(
                              width: 70,
                              height: 70,
                              child: CircularProgressIndicator(
                                color: Themed.primaryColor,
                              ),
                            ),
                          )
                        : ElevatedButton.icon(
                            icon: const Icon(
                              Icons.mark_email_unread_outlined,
                              color: Themed.primaryColor,
                            ),
                            style: ElevatedButton.styleFrom(
                              minimumSize: const Size(300, 55),
                              backgroundColor: Themed.white,
                              textStyle: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w300),
                              shadowColor: Themed.shadow,
                            ),
                            onPressed: () {
                              resetUserEmail();
                            },
                            label: const Text(
                              'Reset Password',
                              style: TextStyle(
                                color: Themed.primaryColor,
                                fontSize: 30,
                              ),
                            ),
                          )
                  ],
                ),
              ),
            ]),
      ),
    );
  }

  Future resetUserEmail() async {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) return;
    setState(
      () => loading = true,
    );
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailController.text.trim());
      setState(
        () => loading = false,
      );
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Themed.accentColor,
          content: Text(
            'Email Sent \n Use New Password to Signin',
            style: TextStyle(color: Themed.white),
          ),
        ),
      );
      Navigator.of(context).pop();

      ///Navigator.of(context).popUntil(ModalRoute.withName("/authenticate"));
      //Navigator.of(context).push(
      // MaterialPageRoute(
      //   settings: const RouteSettings(name: "/authenticate"),
      //   builder: (context) => const Authenticate(),
      // ),
      //);
    } on FirebaseAuthException catch (e) {
      setState(
        () => loading = false,
      );
      //print(e);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Themed.primaryColor,
          content: Text(
            getMessageFromErrorCode(e.code),
            style: const TextStyle(
                color: Themed.white, fontWeight: FontWeight.bold),
          ),
        ),
      );
    }
  }
}
