import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:gap/gap.dart';

import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../database/db.dart';
import '../../../models/notes_model.dart';
import '../../../utils/widgets.dart';

class DetailsView extends StatefulWidget {
  const DetailsView({Key? key}) : super(key: key);

  @override
  State<DetailsView> createState() => _DetailsViewState();
}

class _DetailsViewState extends State<DetailsView> {

  Color? color;
  var note = Get.arguments['note'] as Notes;
  String? status;
  Duration? countdownDuration;
  Duration duration = Duration();
  Timer? timer;

  bool countDown =true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    status = note.status;
    countdownDuration = Duration(milliseconds: note.time!);
    updateStatus(status!);
    reset();
    if(Get.arguments['status'] ==  "IN-PROGRESS")
    {
      setState((){
        duration = Get.arguments['timeLeft'];
        startTimer();
      });
      updateStatus("IN-PROGRESS");

    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    timer!.cancel();
  }

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


  void reset(){
    if (countDown){
      setState(() =>
      duration = countdownDuration!);
    } else{
      setState(() =>
      duration = Duration());
    }
  }

  void startTimer(){
    timer = Timer.periodic(Duration(seconds: 1),(_) => addTime());
  }

  void addTime(){
    final addSeconds = countDown ? -1 : 1;
    setState(() {
      final seconds = duration.inSeconds + addSeconds;
      if (seconds < 0){
        timer?.cancel();
        updateStatus('DONE');
        reset();
      } else{
        duration = Duration(seconds: seconds);

      }
    });
  }

  void stopTimer({bool resets = true}){
    if (resets){
      reset();
    }
    setState(() => timer?.cancel());
  }

  neumorphicTimeContainer({String? title, String? time,}) {
    return Column(
      children: [
        Neumorphic(
          padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 3.h),
          style: NeumorphicStyle(
            depth:status == 'DONE' ? null : NeumorphicTheme.embossDepth(Get.context!),
            boxShape:  NeumorphicBoxShape.roundRect(BorderRadius.circular(10)),
          ),
          child: Text(time!,style: Get.textTheme.headline1!.copyWith(color: color),),
        ),
        Gap(2.h),
        NeumorphicText(title!,style: NeumorphicStyle(color: color),textStyle: NeumorphicTextStyle(fontSize: 20.sp),),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    var isRunning = timer == null? false: timer!.isActive;
    var isCompleted = duration.inSeconds == 0;
    return WillPopScope(
      onWillPop: () async{
        return false;
      },
      child: Scaffold(
        backgroundColor: NeumorphicColors.background,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: NeumorphicColors.background,
          toolbarHeight: 15.h,
          // titleSpacing: 20.h,
          leadingWidth: 16.h,
          leading: NeumorphicButton(
            onPressed: () => Get.back(result: {
              'status' : status,
              'timeLeft' : duration,
            }),
            margin: EdgeInsets.symmetric(horizontal: 6.w,),
            style: NeumorphicStyle(boxShape: NeumorphicBoxShape.circle() ),
            child: Icon(Icons.arrow_back,color: Get.theme.colorScheme.tertiary,),
          ),
          // title: Text(
          //   '${note.title}',
          //   // 'very looooooo oooooo oooooo oooooo oooooo oooooo oooooo oooooo oooooo oooooo oooooo oooooo oooooo oooooo oooooo oooooo oooooo oooooo oooooo oooooo oooooo oooooo oooooo oooo ng Text',
          //   style: Get.textTheme.headline3!.copyWith(color: Get.theme.primaryColor),
          //   textAlign: TextAlign.center,
          //   maxLines: 2,
          //   overflow: TextOverflow.ellipsis,
          // )
        ),
        body: SafeArea(
          child: Padding(
            padding:  EdgeInsets.symmetric(horizontal:5.w),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Gap(5.h),
                Text(
                  '${note.title}',
                  // 'very looooooo oooooo oooooo oooooo oooooo oooooo oooooo oooooo oooooo oooooo oooooo oooooo oooooo oooooo oooooo oooooo oooooo oooooo oooooo oooooo oooooo oooooo oooooo oooo ng Text',
                  style: Get.textTheme.headline3!.copyWith(color: Get.theme.primaryColor),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                Gap(1.h),
                Text(
                  // 'very looooooo oooooo oooooo oooooo oooooo oooooo oooooo oooooo oooooo oooooo oooooo oooooo oooooo oooooo oooooo oooooo oooooo oooooo oooooo oooooo oooooo oooooo oooooo oooo ng Text',
                  '${note.subtitle}',
                  style: Get.textTheme.headline5!.copyWith(color: Get.theme.primaryColor),
                  // textAlign: TextAlign.center,
                  maxLines: 5,
                  overflow: TextOverflow.ellipsis,
                ),
                Gap(3.h),
                Chip(label: Text('${status}',style: Get.textTheme.bodyText2!.copyWith(color: Colors.white),),backgroundColor: color,),


                Gap(5.h),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: [

                    neumorphicTimeContainer(
                      // time: Duration(milliseconds: note.time!).toString().substring(2,4),
                        time: twoDigits(duration.inMinutes.remainder(60)),
                        title: 'Minutes'
                    ),

                    // Padding(
                    //   padding:  EdgeInsets.symmetric(horizontal: 5.w,vertical: 10.h),
                    //   child: NeumorphicText(':',style: NeumorphicStyle(color: color),textStyle: NeumorphicTextStyle(fontSize: 30.sp),),
                    // ),

                    neumorphicTimeContainer(
                        time: twoDigits(duration.inSeconds.remainder(60)),
                        // time: Duration(milliseconds: note.time!).toString().substring(5,7),
                        title: 'Seconds'
                    ),
                  ],
                ),
                Spacer(),

                if(isRunning || isCompleted)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      if(isRunning)
                        NeumorphicButton(
                        onPressed:() => stopTimer(),
                        padding: EdgeInsets.symmetric(vertical: 2.h,horizontal: 10.w),
                        style: NeumorphicStyle(boxShape: NeumorphicBoxShape.circle() ),
                        child: Icon(Icons.stop,color: Get.theme.colorScheme.secondary,),
                      ),
                      NeumorphicButton(
                        onPressed: () {
                          if (isRunning){
                            print('running');
                            stopTimer(resets: false);
                          }
                          else {
                            print('paused');
                            startTimer();
                          }
                          // else {
                          //   updateStatus('DONE');
                          //
                          //   // controller.startTimer();
                          // }
                          // play.toggle();
                        },
                        padding: EdgeInsets.symmetric(vertical: 2.h,horizontal: 10.w),
                        style: NeumorphicStyle(
                          boxShape: NeumorphicBoxShape.circle(),
                          depth: !isCompleted ?  NeumorphicTheme.embossDepth(context) : null ,

                        ),
                        child: Icon(!isCompleted ? Icons.pause : Icons.play_arrow,color: Get.theme.primaryColor,),
                      ),
                    ],
                  )
                else
                  NeumorphicButton(
                    onPressed: () {
                      startTimer();
                      updateStatus('IN-PROGRESS');
                      // show.toggle();
                    },
                    padding: EdgeInsets.symmetric(vertical: 2.h,horizontal: 10.w),
                    style: NeumorphicStyle(boxShape: NeumorphicBoxShape.circle() ),
                    child: Icon(Icons.play_arrow,color: Get.theme.colorScheme.tertiary,),
                  ),


                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //   children: [
                //     NeumorphicButton(
                //       onPressed: () {
                //
                //         show.toggle();
                //       },
                //       padding: EdgeInsets.symmetric(vertical: 2.h,horizontal: 10.w),
                //       style: NeumorphicStyle(boxShape: NeumorphicBoxShape.circle() ),
                //       child: Icon(Icons.stop,color: Get.theme.colorScheme.secondary,),
                //     ),
                //     NeumorphicButton(
                //       onPressed: () {
                //
                //         play.toggle();
                //       },
                //       padding: EdgeInsets.symmetric(vertical: 2.h,horizontal: 10.w),
                //       style: NeumorphicStyle(
                //           boxShape: NeumorphicBoxShape.circle(),
                //          depth: play.value ?  NeumorphicTheme.embossDepth(context) : null ,
                //
                //       ),
                //       child: Icon(play.value ? Icons.pause : Icons.play_arrow,color: Get.theme.primaryColor,),
                //     ),
                //   ],
                // ),
                Gap(5.h),

              ],
            ),
          ),
        ),
      ),
    );
  }
}



