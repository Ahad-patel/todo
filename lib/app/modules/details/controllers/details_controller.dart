import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_timer/app/database/db.dart';
import 'package:todo_timer/app/models/notes_model.dart';

class DetailsController extends GetxController {
  //TODO: Implement DetailsController
  final count = 0.obs;
  Color? color;
  var note = Get.arguments as Notes;
  String? status;
  // Duration? countdownDuration;
  // Rx<Duration> duration = Duration().obs;
  // Timer? timer;
  // RxBool countDown =true.obs;
  // Rx<Stopwatch> watch = Stopwatch().obs;
  // Rx<Timer>? timer;
  //
  // Duration get currentDuration => _currentDuration;
  // Duration _currentDuration = Duration.zero;
  //
  // bool get isRunning => timer != null;


  updateStatus(String stats,) {
   status = stats;
    switch(stats) {
      case 'TODO' :
        color = Get.theme.primaryColor;
        break;
      case "IN-PROGRESS" :
        color = Get.theme.colorScheme.secondary;
        break;
      case "DONE" :
        color = Get.theme.colorScheme.tertiary;
        break;
    }
    if(stats == "DONE") {
      DBProvider.db.updateStatus(stats, note.id!);
    }

  }

  // void reset(){
  //   if (countDown.value){
  //     duration.value = countdownDuration!;
  //   } else{
  //     duration.value = Duration();
  //   }
  // }
  //
  // void startTimer(){
  //   timer = Timer.periodic(Duration(seconds: 1),(_) => addTime());
  // }
  //
  // void addTime(){
  //   final addSeconds = countDown.value ? -1 : 1;
  //     final seconds = duration.value.inSeconds + addSeconds;
  //     if (seconds < 0){
  //       timer?.cancel();
  //     } else{
  //       duration.value = Duration(seconds: seconds);
  //     }
  // }
  //
  // void stopTimer({bool resets = true}){
  //   if (resets){
  //     reset();
  //   }
  //    timer?.cancel();
  // }

//   TimerService() {
//     watch.value = Stopwatch();
//   }
//
//   void _onTick(Timer timer) {
//     _currentDuration = watch.value.elapsed;
//
//     // notify all listening widgets
//   }
//
//   void start() {
//     if (timer != null) return;
//
//     timer!.value = Timer.periodic(Duration(seconds: 1), _onTick);
//     watch.value.start();
//
//   }
//
//   void stop() {
//     timer?.value.cancel();
//     timer = null;
//     watch.value.stop();
//     _currentDuration = watch.value.elapsed;
//
//   }
//
//   void reset() {
//     stop();
//     watch.value.reset();
//     _currentDuration = Duration.zero;
//
//   }
// // source: https://stackoverflow.com/questions/53228993/how-to-implement-persistent-stopwatch-in-flutter


  @override
  void onInit() {
    super.onInit();
   //  status = note.status;
   // countdownDuration = Duration(milliseconds: note.time!);
   //  updateStatus(status!);
    // reset();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    // timer.cancel();
  }

  void increment() => count.value++;
}
