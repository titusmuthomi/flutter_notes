// ignore_for_file: use_build_context_synchronously

import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:tito_login/services/constants/theme.dart';

import '../../services/constants/global_styles.dart';
import '../../services/constants/global_text.dart';
import '../../services/constants/global_widgets.dart';
import 'authenticate.dart';
import 'reset_pass.dart';

class Login extends StatefulWidget {
  final VoidCallback onClickedSignUp;

  const Login({
    Key? key,
    required this.onClickedSignUp,
  }) : super(key: key);
  static const name = '/login';

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final FocusNode _passwordFocus = FocusNode();
  bool loading = false;
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    _LoginState().dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.all(30),
          child: ListView(
            children: <Widget>[
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
                        child: Image.asset('assets/images/cralogo.png'))),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  child: TextConst.appName),
              Container(
                padding: const EdgeInsets.all(10),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        decoration: FormStyle.authLight
                          ..copyWith(
                            label: const Text('Email'),
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
                      formSizedBox(),
                      TextFormField(
                        controller: passwordController,
                        focusNode: _passwordFocus,
                        textInputAction: TextInputAction.done,
                        onFieldSubmitted: (value) {
                          _passwordFocus.unfocus();
                          signInUser();
                        },
                        obscureText: true,
                        decoration: FormStyle.authLight.copyWith(
                          label: const Text('Password'),
                        ),
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              value.length < 6) {
                            return 'Enter Valid Password';
                          }
                          return null;
                        },
                      ),
                      formSizedBox(),
                      loading
                          ? const Center(
                              child: SizedBox(
                                width: 70,
                                height: 70,
                                child: CircularProgressIndicator(),
                              ),
                            )
                          : ElevatedButton.icon(
                              icon: const Icon(Icons.arrow_right_alt),
                              style: ElevatedButton.styleFrom(
                                minimumSize: const Size(300, 55),
                                backgroundColor: Themed.primaryColor,
                                textStyle: const TextStyle(fontSize: 24),
                                shadowColor: Themed.shadow,
                              ),
                              onPressed: () async {
                                signInUser();
                              },
                              label: const Text('Sign In'),
                            )
                    ],
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  GestureDetector(
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) => const ResetPassword()),
                    )
                    //forgot password screen
                    ,
                    child: const Text(
                      'Forgot Password?',
                      style: AuthStyle.forgotPass,
                    ),
                  ),
                  formSizedBox(),
                  RichText(
                    text: TextSpan(
                        style: const TextStyle(color: Themed.black),
                        text: 'No Account?',
                        children: [
                          const TextSpan(
                            text: ' ',
                          ),
                          TextSpan(
                            recognizer: TapGestureRecognizer()
                              ..onTap = widget.onClickedSignUp,
                            text: 'Signup',
                            style: AuthStyle.switchPage,
                          )
                        ]),
                  ),
                  sizedBox10(),
                ],
              ),
            ],
          )),
    );
  }

  Future signInUser() async {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) return;

    setState(
      () => loading = true,
    );

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim());

      //
      //  Navigator.pushReplacement(
      //     context, MaterialPageRoute(builder: (_) => const Admins()));
    } on FirebaseAuthException catch (e) {
      setState(
        () => loading = false,
      );

      if (e.code == 'email-already-in-use' //||

          ) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            behavior: SnackBarBehavior.floating,
            elevation: 4,
            duration: const Duration(seconds: 10),
            backgroundColor: Themed.primaryColor,
            content: Text(
              getMessageFromErrorCode(e.code),
              style: const TextStyle(color: Themed.white),
            ),
          ),
        );
        widget.onClickedSignUp;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            behavior: SnackBarBehavior.floating,
            elevation: 10,
            duration: const Duration(seconds: 10),
            backgroundColor: Themed.accentColor,
            content: Text(
              getMessageFromErrorCode(e.code),
              style: const TextStyle(color: Themed.white),
            ),
          ),
        );
      }
      //print(e);
    }
    setState(
      () => loading = false,
    );

    //Navigator.pushNamed(context, '/path', arguments: {          });
  }

  // call a server or save the information in a database.
}
