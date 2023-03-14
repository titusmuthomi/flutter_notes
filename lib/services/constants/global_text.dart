import 'package:flutter/material.dart';

import 'theme.dart';

class TextConst {
  static const Text appName = Text(
    'AppName',
    textAlign: TextAlign.center,
    style: TextStyle(fontSize: 30, color: Themed.primaryColor),
  );
  static const Text appHash = Text(
    'Join ',
    textAlign: TextAlign.center,
    style: TextStyle(fontSize: 25, color: Themed.primaryColor),
  );

  //Authentication

  static const String register = 'Register';
  static const String signUp = 'Sign Up';
  static const String signIn = 'Sign In';
  static const String firstName = 'First Name';
  static const String lastName = 'Last Name';
  static const String phoneNumber = 'Phone Number';
  static const String department = 'Department';
  static const String email = 'E-Mail';
  static const String password = 'Password';

  static const String alreadysn = 'Already Registered?';
  static const String alreadysn2 = 'Log in here';

  static const String role0 = 'Select Department';
  static const String role1 = 'Department 1';
  static const String role2 = 'Department 2';
  static const String role3 = 'Department 3';
  // Account
}

class ListConst {
  static List<String> adminRoleList = [
    TextConst.role1,
    TextConst.role2,
    TextConst.role3,
  ];
}
