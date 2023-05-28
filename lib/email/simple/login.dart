// ignore_for_file: use_build_context_synchronously

import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:tito_login/services/constants/theme.dart';

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
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;
  bool _oscureText = true;
  final FocusNode _passFocusNode = FocusNode();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _passFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 20),
        child: Column(
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
                    child: Icon(Icons.face_unlock_outlined),
                    //Image.asset('assets/images/logo.png')
                  )),
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
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      decoration: FormStyle.authLight.copyWith(
                        label: const Text('Email'),
                        suffixIcon: Icon(Icons.email),
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
                      obscureText: !_oscureText, // changing dynamnically
                      onEditingComplete: () =>
                          FocusScope.of(context).requestFocus(_passFocusNode),
                      keyboardType: TextInputType.visiblePassword,
                      controller: _passwordController,
                      textInputAction: TextInputAction.done,

                      decoration: FormStyle.authLight.copyWith(
                          label: const Text('Password'),
                          suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                _oscureText = !_oscureText;
                              });
                            },
                            child: Icon(
                              _oscureText
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: Themed.primaryColor,
                            ),
                          )),

                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            value.length < 6) {
                          return 'Must be memorable and more than 6 characters';
                        }
                        return null;
                      },
                    ),
                    sizedBox10(),
                    Container(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => const ResetPassword()),
                        )
                        //forgot password screen
                        ,
                        child: const Text(
                          'Forgot Password?',
                          textAlign: TextAlign.right,
                          style: AuthStyle.forgotPass,
                        ),
                      ),
                    ),
                    sizedBox10(),
                    _isLoading
                        ? Center(
                            child: SizedBox(
                              width: 300,
                              height: 50,
                              child: Stack(
                                children: [
                                  const LinearProgressIndicator(
                                    backgroundColor: Themed.accentColor,
                                    color: Themed.primaryColor,
                                  ),
                                  sizedBox10(),
                                  const Align(
                                      alignment: Alignment.bottomCenter,
                                      child: Text(
                                        'Loading',
                                        style: TextStyle(
                                            color: Themed.primaryColor),
                                      ))
                                ],
                              ),
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
            formSizedBox(),
            Container(
              child: RichText(
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
            ),
          ],
        ),
      ),
    );
  }

  Future signInUser() async {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) return;

    setState(
      () => _isLoading = true,
    );

    await signInEmailPass();
    setState(
      () => _isLoading = false,
    );
  }

  Future<void> signInEmailPass() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim());

      //
      //  Navigator.pushReplacement(
      //     context, MaterialPageRoute(builder: (_) => const Admins()));
    } on FirebaseAuthException catch (e) {
      setState(
        () => _isLoading = false,
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
  }

  // call a server or save the information in a database.
}
