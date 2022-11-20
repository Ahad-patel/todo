import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:gap/gap.dart';

import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../utils/widgets.dart';
import '../controllers/details_controller.dart';

class DetailsView extends StatefulWidget {
  const DetailsView({Key? key}) : super(key: key);

  @override
  State<DetailsView> createState() => _DetailsViewState();
}

class _DetailsViewState extends State<DetailsView> {
  DetailsController controller = Get.find();
  Duration? countdownDuration;
  Duration duration = Duration();
  Timer? timer;

  bool countDown =true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.status = controller.note.status;
    countdownDuration = Duration(milliseconds: controller.note.time!);
    controller.updateStatus(controller.status!);
    reset();
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
        controller.updateStatus('DONE');
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
            depth: NeumorphicTheme.embossDepth(Get.context!),
            boxShape:  NeumorphicBoxShape.roundRect(BorderRadius.circular(10)),
          ),
          child: Text(time!,style: Get.textTheme.headline1!.copyWith(color: controller.color),),
        ),
        Gap(2.h),
        NeumorphicText(title!,style: NeumorphicStyle(color: controller.color),textStyle: NeumorphicTextStyle(fontSize: 20.sp),),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    var isRunning = timer == null? false: timer!.isActive;
    var isCompleted = duration.inSeconds == 0;
    return Scaffold(
      backgroundColor: NeumorphicColors.background,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: NeumorphicColors.background,
        toolbarHeight: 15.h,
        // titleSpacing: 20.h,
        leadingWidth: 16.h,
        leading: NeumorphicButton(
          onPressed: () => Get.back(),
          margin: EdgeInsets.symmetric(horizontal: 6.w,),
          style: NeumorphicStyle(boxShape: NeumorphicBoxShape.circle() ),
          child: Icon(Icons.arrow_back,color: Get.theme.colorScheme.tertiary,),
        ),
        // title: Text(
        //   '${controller.note.title}',
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
                '${controller.note.title}',
                // 'very looooooo oooooo oooooo oooooo oooooo oooooo oooooo oooooo oooooo oooooo oooooo oooooo oooooo oooooo oooooo oooooo oooooo oooooo oooooo oooooo oooooo oooooo oooooo oooo ng Text',
                style: Get.textTheme.headline3!.copyWith(color: Get.theme.primaryColor),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              Gap(1.h),
              Text(
                // 'very looooooo oooooo oooooo oooooo oooooo oooooo oooooo oooooo oooooo oooooo oooooo oooooo oooooo oooooo oooooo oooooo oooooo oooooo oooooo oooooo oooooo oooooo oooooo oooo ng Text',
                '${controller.note.subtitle}',
                style: Get.textTheme.headline5!.copyWith(color: Get.theme.primaryColor),
                // textAlign: TextAlign.center,
                maxLines: 5,
                overflow: TextOverflow.ellipsis,
              ),
              Gap(3.h),
              Chip(label: Text('${controller.status}',style: Get.textTheme.bodyText2!.copyWith(color: Colors.white),),backgroundColor: controller.color,),


              Gap(5.h),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [

                  neumorphicTimeContainer(
                    // time: Duration(milliseconds: controller.note.time!).toString().substring(2,4),
                      time: twoDigits(duration.inMinutes.remainder(60)),
                      title: 'Minutes'
                  ),

                  // Padding(
                  //   padding:  EdgeInsets.symmetric(horizontal: 5.w,vertical: 10.h),
                  //   child: NeumorphicText(':',style: NeumorphicStyle(color: color),textStyle: NeumorphicTextStyle(fontSize: 30.sp),),
                  // ),

                  neumorphicTimeContainer(
                      time: twoDigits(duration.inSeconds.remainder(60)),
                      // time: Duration(milliseconds: controller.note.time!).toString().substring(5,7),
                      title: 'Seconds'
                  ),
                ],
              ),
              Spacer(),

              if(isRunning /*|| isCompleted*/)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    NeumorphicButton(
                      onPressed:() => stopTimer(),
                      padding: EdgeInsets.symmetric(vertical: 2.h,horizontal: 10.w),
                      style: NeumorphicStyle(boxShape: NeumorphicBoxShape.circle() ),
                      child: Icon(Icons.stop,color: Get.theme.colorScheme.secondary,),
                    ),
                    NeumorphicButton(
                      onPressed: () {
                        if (isRunning){
                          stopTimer(resets: false);
                        }
                        // else {
                        //   controller.updateStatus('DONE');
                        //
                        //   // controller.startTimer();
                        // }
                        // play.toggle();
                      },
                      padding: EdgeInsets.symmetric(vertical: 2.h,horizontal: 10.w),
                      style: NeumorphicStyle(
                        boxShape: NeumorphicBoxShape.circle(),
                        depth: isRunning ?  NeumorphicTheme.embossDepth(context) : null ,

                      ),
                      child: Icon(isRunning ? Icons.pause : Icons.play_arrow,color: Get.theme.primaryColor,),
                    ),
                  ],
                )
              else
                NeumorphicButton(
                  onPressed: () {
                    startTimer();
                    controller.updateStatus('IN-PROGRESS');
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
    );
  }
}



