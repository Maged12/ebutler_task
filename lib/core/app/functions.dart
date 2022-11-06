import 'package:ebutler_task/core/utils/app_strings.dart';
import 'package:flutter/foundation.dart';

void appPrint(message) {
  if (kDebugMode) {
    print(message);
  }
}

String? emailValidation(String? email) {
  if (email == null || email.isEmpty) {
    return "Email can't be empty";
  } else if (!RegExp(AppStrings.emailRegx).hasMatch(email)) {
    return "Invaled email formate";
  }
  return null;
}

String? passwordValidation(String? password) {
  if (password == null || password.length < 6) {
    return "Password can't be less than 6 char";
  }
  return null;
}
