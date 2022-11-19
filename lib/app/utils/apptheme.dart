import 'package:flutter/material.dart';
import 'package:get/get.dart';

class  AppTheme {
  AppTheme._();

  // static const Color border = Color(0xffdbdbdb);
  // static const Color priorityHigh = Color(0xFFD71149);
  // static const Color priorityMedium = Color(0xFFFBAF18);
  // static const Color priorityLow = Color(0xff00880D);
  // static const Color colorBlack = Colors.black;

  static InputDecoration textFieldInputDecoration({String? hintText}) {
    return InputDecoration(
      hoverColor: Get.theme.primaryColor,
      focusColor: Get.theme.primaryColor,
      border: InputBorder.none,
      counterText: "",
      hintText: hintText,
      hintStyle: Get.textTheme.bodyText2!.copyWith(color: Get.theme.disabledColor),
      // errorText: '',
      errorStyle: TextStyle(height: 0.01),
      // errorMaxLines: 1,
      focusedBorder: InputBorder.none,
      enabledBorder: InputBorder.none,
      errorBorder: InputBorder.none,
      focusedErrorBorder: InputBorder.none,
      // enabledBorder: OutlineInputBorder(
      //     borderSide: BorderSide(color: Get.theme.dividerColor),
      //     borderRadius: BorderRadius.circular(8)
      // ),
    );
  }

}