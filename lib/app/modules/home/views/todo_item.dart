import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:todo_timer/app/models/notes_model.dart';

import '../../../database/db.dart';
import '../../../routes/app_pages.dart';
import '../../../utils/widgets.dart';
import '../controllers/home_controller.dart';

class TodoItem extends StatefulWidget {
  final int index;
  final String status;
  final Notes? note;
  const TodoItem({Key? key, required this.index, required this.status, this.note}) : super(key: key);

  @override
  State<TodoItem> createState() => _TodoItemState();
}

class _TodoItemState extends State<TodoItem> {
  HomeController controller = Get.find();

  // Duration duration = Duration(milliseconds: controller.notesList[index].time!);
  String? status;
  // int val = index;
  Color? color;
  Duration? countdownDuration /*= Duration(milliseconds: widget.time!)*/;
  Duration duration = Duration();
  Timer? timer;

  bool countDown =true;
  // String? status;



  updateStatus(status) {
    switch(status) {
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
    this.status = status;
    if(status == "DONE") {
      DBProvider.db.updateStatus(status, widget.note!.id!);
    }


  }




  void reset(){
    if (countDown){

      duration = countdownDuration!;
    } else{
      setState(() =>
      duration = Duration());
    }
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

  void startTimer(){
    timer = Timer.periodic(Duration(seconds: 1),(_) => addTime());
  }


  void stopTimer({bool resets = true}){
    if (resets){
      reset();
    }
    setState(() => timer?.cancel());
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState((){
      countdownDuration = Duration(milliseconds: widget.note!.time!);
      status = widget.status;
    });
    updateStatus(status);
    reset();

  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding:  EdgeInsets.symmetric(vertical: 2.h,horizontal: 4.w),
          child: GestureDetector(
            onTap: () {
              Get.toNamed(Routes.DETAILS,arguments:
              {
                'note' : widget.note,
                'status' : status,
                'timeLeft' : duration,
              }



              )!.then((value) {
                print(value);

                if(value['status'] ==  "IN-PROGRESS")
                {
                  setState((){
                    duration = value['timeLeft'];
                    startTimer();
                  });

                }
                updateStatus(value['status']);

                // // controller.updateStatus(controller.status!);
                controller.getAllNotes();
              });
              stopTimer();

            },
            child: Neumorphic(
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 3.h, horizontal: 3.w  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15)
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [


                      Neumorphic(
                          padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 3.h),
                          style: NeumorphicStyle(
                            depth: status== "DONE" ? null : NeumorphicTheme.embossDepth(context),
                            boxShape:  NeumorphicBoxShape.roundRect(BorderRadius.circular(10)),
                          ),
                          // child: Text(Duration(milliseconds: controller.notesList[widget.index].time!).toString().substring(2,7),style: Get.textTheme.subtitle2!.copyWith(color: color),)),
                          child: Text(duration.toString().substring(2,7),style: Get.textTheme.subtitle2!.copyWith(color: color),)),

                      Gap(5.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('${widget.note!.title}',style: Get.textTheme.bodyText2!.copyWith(fontWeight: FontWeight.bold),),
                            Text('${widget.note!.subtitle}',style: Get.textTheme.bodyText2!,maxLines: 1,overflow: TextOverflow.ellipsis,),
                          ],
                        ),
                      ),
                      Chip(label: Text('$status',style: Get.textTheme.bodyText2!.copyWith(color: Colors.white),),backgroundColor: color,)


                    ],
                  ),
                )
            ),
          ),
        ),
        // Positioned(
        //   right: 0,
        //   top: 5,
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.end,
        //     children: [
        //       NeumorphicButton(
        //         onPressed: () {
        //           deleteDialog().then((value) {
        //             if(value!= null && value) {
        //               controller.deleteNote(widget.note!.id!).then((value) {
        //                 setState(() {
        //                   controller.getAllNotes();
        //                 });
        //               });
        //             }
        //           });
        //         },
        //         style: NeumorphicStyle(
        //           boxShape: NeumorphicBoxShape.circle(),
        //
        //         ),
        //         child: Icon(Icons.close,color: Get.theme.errorColor,size: 15,),
        //
        //       ),
        //     ],
        //   ),
        // )
      ],
    );
  }
}
