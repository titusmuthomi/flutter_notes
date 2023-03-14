import 'package:flutter/material.dart';

import 'login.dart';
import 'signup.dart';

class Authenticate extends StatefulWidget {
  const Authenticate({super.key});
  static const name = '/authenticate';

  @override
  State<Authenticate> createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool isLogin = false;

  void toggle() => setState(() => isLogin = !isLogin);
  @override
  Widget build(BuildContext context) => isLogin
      ? Login(
          onClickedSignUp: toggle,
        )
      : Signup(onClickedSignIn: toggle);
}

// SignUp

// SignIn

// errors
String getMessageFromErrorCode(String errorCode) {
  switch (errorCode) {
    case "ERROR_EMAIL_ALREADY_IN_USE":
    case "account-exists-with-different-credential":
    case "email-already-in-use":
      return "Email already used. Click Sign In.";
    case "ERROR_WRONG_PASSWORD":
    case "wrong-password":
      return "Wrong email/password combination.";
    case "ERROR_USER_NOT_FOUND":
    case "user-not-found":
      return "No user found with this email. Click SignUP";

    case "ERROR_USER_DISABLED":
    case "user-disabled":
      return "User disabled. Due to a Violation. Contact support";

    case "ERROR_TOO_MANY_REQUESTS":
      return "Too many requests to log into this account.";

    case "ERROR_OPERATION_NOT_ALLOWED":
    case "operation-not-allowed":
      return "Server error, please try again later.";

    case "ERROR_INVALID_EMAIL":
    case "invalid-email":
      return "Email address is invalid.";

    case "ABORTED":
    case "aborted":
      return "The operation was aborted. Retry.";
    case "ALREADY_EXISTS":
    case "already-exists":
      return "Some document that we attempted to create already exists.";

    case "CANCELLED":
    case "cancelled":
      return "The operation was cancelled .";

    case "DATA_LOSS":
    case "data-loss":
      return "Unrecoverable data loss or corruption.";

    case "DEADLINE_EXCEEDED":
    case "deadline-exceeded":
      return "Deadline expired before operation could complete. ";

    case "FAILED_PRECONDITION":
    case "failed-precondition":
      return "system is not in a state required for the operation's execution.";

    case "INTERNAL":
    case "internal":
      return "Internal errors.";

    case "INVALID_ARGUMENT":
    case "invalid-argument":
      return "specified an invalid argument.";

    case "NOT_FOUND":
    case "not-found":
      return "Some requested document was not found..";
    case "OK":
    case "ok":
      return "The operation completed successfully.";

    case "OUT_OF_RANGE":
    case "out-of-range":
      return "Operation was attempted past the valid range..";

    case "PERMISSION_DENIED":
    case "permission-denied":
      return "No permission to execute the specified operation.";

    case "RESOURCE_EXHAUSTED":
    case "resource-exhausted":
      return "Some resource has been exhausted,.";

    case "UNAUTHENTICATED":
    case "unauthenticated":
      return "No valid authentication credentials for the operation.";

    case "UNAVAILABLE":
    case "unavailable":
      return "The service is currently unavailable.";

    case "UNIMPLEMENTED":
    case "unimplemented":
      return "Operation is not implemented or not supported/enabled..";

    case "UNKNOWN":
    case "unknown":
      return "Unknown error or an error from a different error domain";

    default:
      return "Oops! Error. Please check your Connection and try again.";
  }
}
