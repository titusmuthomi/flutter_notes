// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import 'package:tito_login/services/constants/global_text.dart';
import 'package:tito_login/services/constants/theme.dart';

import '../../services/constants/global_methods.dart';
import '../../services/constants/global_widgets.dart';
import 'authenticate.dart';

class Signup extends StatefulWidget {
  final VoidCallback onClickedSignIn;

  const Signup({
    Key? key,
    required this.onClickedSignIn,
  }) : super(key: key);
  static const name = '/signup';

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final _signUpFormKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _roleController =
      TextEditingController(text: 'Select Role');
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _oscureText = true;
  final FocusNode _passFocusNode = FocusNode();
  bool _isloading = false;

  bool loading = false;
  bool agree = false;
  File? imageFile;
  String? imageUrl;
  void _doSomething() {
    _submitFormOnSignup();
  }

  void _showImageDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Please Choose an Action'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              InkWell(
                onTap: () {
                  _getFromCamera();
                  //create
                },
                child: Row(
                  children: const [
                    Padding(
                      padding: EdgeInsets.all(4),
                      child: Icon(Icons.camera),
                    ),
                    Text('Camera'),
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  _getFromGallery();
                },
                child: Row(
                  children: const [
                    Padding(
                      padding: EdgeInsets.all(4),
                      child: Icon(Icons.photo),
                    ),
                    Text('Gallery'),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _getFromCamera() async {
    XFile? pickedFile =
        await ImagePicker().pickImage(source: ImageSource.camera);
    _cropImage(pickedFile!.path);
    Navigator.pop(context);
  }

  void _getFromGallery() async {
    XFile? pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    _cropImage(pickedFile?.path);
    Navigator.pop(context);
  }

  void _cropImage(filePath) async {
    CroppedFile? croppedImage = await ImageCropper()
        .cropImage(sourcePath: filePath, maxHeight: 1080, maxWidth: 1080);

    if (croppedImage != null) {
      setState(() {
        imageFile = File(croppedImage.path);
      });
    }
  }

  void _submitFormOnSignup() async {
    final isValid = _signUpFormKey.currentState!.validate();
    if (isValid) {
      if (imageFile == null) {
        GlobalMethod.showErrorDialog(
          ctx: context,
          error: ' Please Pick an Image ',
        );
        return;
      }
      setState(() {
        _isloading = true;
      });
      try {
        await _auth.createUserWithEmailAndPassword(
            email: _emailController.text.trim().toLowerCase(),
            password: _passController.text.trim());

        final User? user = _auth.currentUser;
        //create uid and assighn specific
        final uid = user!.uid;
        // set ref assign firebase instance
        final ref = FirebaseStorage.instance
            .ref()
            .child('Admins') //create folder
            .child('${uid}_.jpg'); //er
        await ref.putFile(imageFile!); // pull file
        imageUrl = await ref.getDownloadURL();

        FirebaseFirestore.instance.collection('Administrators').doc(uid).set({
          'id': uid,
          'fName': _firstNameController.text,
          'lName': _lastNameController.text,
          'email': _emailController.text,
          'userImage': imageUrl,
          'phoneNumber': _phoneController.text,
          'role': _roleController.text,
          'createdAt': Timestamp.now(),
        });
        //TODO: Navigate to home
        // Navigator.pushReplacement(
        //     context, MaterialPageRoute(builder: (_) => const Admins()));
      } on FirebaseAuthException catch (e) {
        setState(() {
          _isloading = false;
        });
        GlobalMethod.showErrorDialog(
          ctx: context,
          error: e.code.toString(),
        );
      }
    }
  }

  void showRoles({required Size size}) {
    showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            //surfaceTintColor: Colors.teal.withOpacity(0.5),
            backgroundColor: Colors.white.withOpacity(0.95),
            title: const Text('Select Role'),
            titleTextStyle: const TextStyle(fontSize: 20, color: Colors.black),
            content: SizedBox(
              width: size.width * 0.9,
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: ListConst.adminRoleList.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        setState(() {
                          _roleController.text = ListConst.adminRoleList[index];
                        });
                        Navigator.canPop(context)
                            ? Navigator.pop(context)
                            : null;
                      },
                      child: Column(
                        children: [
                          Row(children: [
                            const Icon(Icons.arrow_right_alt_outlined),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                ListConst.adminRoleList[index],
                                style: const TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                            )
                          ]),
                          const Divider(
                            thickness: 2,
                          ),
                        ],
                      ),
                    );
                  }),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.canPop(context) ? Navigator.pop(context) : null;
                  },
                  child: const Text(
                    "Close",
                    style: TextStyle(color: Colors.red),
                  )),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.all(30),
          child: ListView(
            children: <Widget>[
              sizedBox50(),
              Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  child: TextConst.appName),
              Container(
                padding: const EdgeInsets.all(10),
                child: Form(
                  key: _signUpFormKey,
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          _showImageDialog();
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                              width: size.width * 0.24,
                              height: size.width * 0.24,
                              decoration: BoxDecoration(
                                border: Border.all(
                                    width: 1, color: Themed.primaryColor),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: imageFile ==
                                        null // if image is null show icon
                                    ? const Icon(
                                        //else show image
                                        Icons.add_a_photo,
                                        color: Themed.primaryColor,
                                        size: 30,
                                      )
                                    : Image.file(imageFile!, fit: BoxFit.fill),
                              )),
                        ),
                      ),
                      Row(
                        children: [
                          TextFormField(
                            controller: _firstNameController,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.name,
                            decoration: FormStyle.authLight.copyWith(
                              hintText: 'First Name ',
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please Enter First Name';
                              } else {
                                return null;
                              }
                            },
                          ),
                          TextFormField(
                            controller: _lastNameController,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.name,
                            decoration: FormStyle.authLight.copyWith(
                              hintText: 'Last Name ',
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please Enter Last Name';
                              } else {
                                return null;
                              }
                            },
                          ),
                        ],
                      ),
                      formSizedBox(),
                      TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        decoration: FormStyle.authLight.copyWith(
                          prefixIcon: const Icon(Icons.email),
                          label: const Text('Email'),
                        ),
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              EmailValidator.validate(value) == false) {
                            return 'Enter Valid email';
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
                        controller: _passController,
                        //focusNode: _passwordFocus,
                        textInputAction: TextInputAction.next,

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
                            return 'Must be memorable; more than 6 characters';
                          }
                          return null;
                        },
                      ),
                      formSizedBox(),
                      TextFormField(
                        controller: _phoneController,
                        maxLength: 10,
                        textInputAction: TextInputAction.done,
                        decoration: FormStyle.authLight.copyWith(
                          label: const Text('Phone Number'),
                        ),
                        validator: (value) {
                          if (value == null ||
                              value.contains(RegExp(r'[A-Z]' '[a-z]')) ||
                              value.isEmpty ||
                              value.length < 10) {
                            return 'Enter Valid Phone Number';
                          }
                          return null;
                        },
                      ),
                      sizedBox10(),
                      TextFormField(
                        controller: _roleController,
                        readOnly: true,
                        onTap: () {
                          showRoles(size: size);
                        },
                        textInputAction: TextInputAction.done,
                        decoration: FormStyle.authLight.copyWith(
                          label: const Text('Select Role'),
                        ),
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              value == 'Select Role') {
                            return 'Please Select Role';
                          }
                          return null;
                        },
                      ),
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Checkbox(
                                value: agree,
                                onChanged: ((value) {
                                  setState(() {
                                    agree = value ?? false;
                                  });
                                }),
                              ),
                              const Text(
                                'I accept CRA Policies',
                                overflow: TextOverflow.fade,
                              ),
                            ],
                          ),
                        ],
                      ),
                      sizedBox10(),
                      _isloading
                          ? const Center(
                              child: SizedBox(
                                width: 70,
                                height: 70,
                                child: CircularProgressIndicator(),
                              ),
                            )
                          : ElevatedButton.icon(
                              icon: const Icon(Icons.check),
                              style: ElevatedButton.styleFrom(
                                  minimumSize: const Size(300, 55),
                                  backgroundColor: Themed.primaryColor,
                                  textStyle: const TextStyle(fontSize: 24),
                                  shadowColor: Themed.shadow),
                              onPressed: agree ? _doSomething : null,
                              label: const Text('Sign Up'),
                            )
                    ],
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  formSizedBox(),
                  RichText(
                    text: TextSpan(
                        style: const TextStyle(color: Themed.black),
                        text: 'Have an Account?',
                        children: [
                          const TextSpan(
                            text: ' ',
                          ),
                          TextSpan(
                            recognizer: TapGestureRecognizer()
                              ..onTap = widget.onClickedSignIn,
                            text: 'Sign In',
                            style: AuthStyle.switchPage,
                          ),
                        ]),
                  ),
                ],
              ),
            ],
          )),
    );
  }

  Future signUpUser() async {
    final isValid = _signUpFormKey.currentState!.validate();
    if (!isValid) return;

    setState(
      () => loading = true,
    );

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passController.text.trim());
    } on FirebaseAuthException catch (e) {
      setState(
        () => loading = false,
      );
      if (e.code == 'user-not-found') {
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
        widget.onClickedSignIn;
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
    }
  }
}
