import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_timer/app/database/db.dart';
import 'package:todo_timer/app/models/notes_model.dart';

class DetailsController extends GetxController {
  //TODO: Implement DetailsController
  final count = 0.obs;


  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
