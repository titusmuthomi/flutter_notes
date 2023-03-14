import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'global_styles.dart';
import 'theme.dart';

Widget sizedBox50() {
  return const SizedBox(
    height: 50,
  );
}

Widget sizedBox10() {
  return const SizedBox(
    height: 10,
  );
}

Widget sizedBox150() {
  return const SizedBox(
    height: 150,
  );
}

Widget feedbackformSizedBox() {
  return const SizedBox(
    height: 100,
  );
}

Widget formSizedBox() {
  return const SizedBox(
    height: 30,
  );
}

const SpinKitWave wave = SpinKitWave(
  color: Colors.white,
  type: SpinKitWaveType.center,
  duration: Duration(milliseconds: 100),
);

Widget snacks(String smeg) {
  return SnackBar(
    content: Text(smeg),
    backgroundColor: Themed.accentColor,
    duration: const Duration(seconds: 1),
    dismissDirection: DismissDirection.down,
    showCloseIcon: true,
    closeIconColor: Themed.accentColor,
  );
}

ScaffoldFeatureController<SnackBar, SnackBarClosedReason> alertPop(
  context,
  String message,
) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: Themed.accentColor,
      content: Text(
        message,
        style: const TextStyle(color: Themed.accentColor),
      ),
    ),
  );
}
