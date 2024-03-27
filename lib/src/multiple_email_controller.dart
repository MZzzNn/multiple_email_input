import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MultipleEmailController extends GetxController {
  static String updateEmailId = 'updateEmailId';
  late TextEditingController emailController;
  String lastValue = '';
  List<String> emails = [];
  FocusNode focus = FocusNode();

  @override
  void onInit() {
    emailController = TextEditingController();
    focus.addListener(() {
      if (!focus.hasFocus) {
        updateEmails();
      }
    });
    super.onInit();
  }

  updateEmails() {
    if (validateEmail(emailController.text)) {
      if (!emails.contains(emailController.text)) {
        emails.add(emailController.text.trim());
      }
      emailController.clear();
    } else if (!validateEmail(emailController.text)) {
      emailController.clear();
    }
    update([updateEmailId]);
  }

  void onChanged(String? val) {
    if (val != lastValue) {
      lastValue = val!;
      if (val.endsWith(' ') && validateEmail(val.trim())) {
        if (!emails.contains(val.trim())) {
          emails.add(val.trim());
        }
        emailController.clear();
      } else if (val.endsWith(' ') && !validateEmail(val.trim())) {
        emailController.clear();
      }
    }
    update([updateEmailId]);
  }

  bool validateEmail(String value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern);
    return regex.hasMatch(value);
  }



  removeEmail(String email) {
    emails.remove(email);
    updateEmails();
    update([updateEmailId]);
  }

}
