import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:todo_timer/app/database/db.dart';
import 'package:todo_timer/app/models/notes_model.dart';
import 'package:todo_timer/app/modules/home/controllers/home_controller.dart';
import 'package:todo_timer/app/utils/widgets.dart';

import '../../../utils/apptheme.dart';

class AddTodo extends StatefulWidget {
  const AddTodo({Key? key}) : super(key: key);

  @override
  State<AddTodo> createState() => _AddTodoState();
}

class _AddTodoState extends State<AddTodo> {
  HomeController homeController = Get.find();
  RxString title = ''.obs;
  RxString subtitle = ''.obs;
  Rx<Duration> selectedTime = 10.minutes.obs;
  var min = TextEditingController();
  var sec = TextEditingController();


  @override
  void initState() {
    super.initState();
   min.text = '10';
   sec.text = '00';

  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(vertical: 2.h,horizontal: 3.w),
      child: SingleChildScrollView(
        child: Column(
                children: [
                  Text('Add TODO',style: Get.textTheme.headline5!.copyWith(color: Get.theme.primaryColor),),
                  Gap(3.h),

                  NeumorphicTextField(label: 'Title',required: true, hint: 'title',onChanged: (val) => title.value = val.trim(),),
                  Gap(2.h),
                  NeumorphicTextField(label: 'Description',minLines: 3, maxLines: 3 ,hint: 'description',onChanged: (val)  => subtitle.value = val.trim(),),
                  Gap(2.h),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(child: NeumorphicTextField(label: 'Minutes',required: true,enabled: false,hint: 'Minutes',controller: min,onChanged: (val) {},)),
                      Expanded(child: NeumorphicTextField(label: 'Seconds',required: true,enabled: false,hint: 'Seconds',controller: sec,onChanged: (val) {},)),
                      NeumorphicButton(
                        onPressed: () {
                         // Duration selectedTime = 10.minutes;
                          Get.bottomSheet(
                              SizedBox(
                                height: 45.h,
                                child: Column(
                                  children: [
                                    CupertinoTimerPicker(
                                    initialTimerDuration: selectedTime.value,
                                    onTimerDurationChanged: (selected) {
                                        print(selected);
                                       selectedTime.value = selected;
                                      },
                                      mode: CupertinoTimerPickerMode.ms,
                                    ),

                                    ///select timer button
                                    NeumorphicButton(
                                      onPressed: () {
                                        print("minute ${selectedTime.value.inMinutes.remainder(60)}");
                                        print("seconds ${selectedTime.value.inSeconds.remainder(60)}");

                                        if(selectedTime.value.inSeconds <= 600 && selectedTime.value.inSeconds > 0)
                                        {
                                          setState(() {
                                            min.text = selectedTime.value.inMinutes.remainder(60).toString();
                                            sec.text = selectedTime.value.inSeconds.remainder(60).toString();
                                          });
                                          Get.back();
                                        }
                                        else {
                                          toast("Please select <= 10 minutes or > 1 second");
                                        }
                                      },
                                      padding: EdgeInsets.symmetric(vertical: 2.h,horizontal: 10.w),
                                      // style: NeumorphicStyle(border: NeumorphicBorder(color: Get.theme.colorScheme.tertiary.withOpacity(0.5),)),
                                      child: Text('Select',style: Get.textTheme.button!.copyWith(color: Get.theme.colorScheme.secondary),),
                                    ),

                                  ],
                                ),
                              ),
                              backgroundColor: NeumorphicColors.background,
                              // backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(15))),
                              // isScrollControlled: true
                          );


                        },
                        child: Icon(Icons.timer,color: Get.theme.colorScheme.secondary,),
                        padding: EdgeInsets.symmetric(vertical: 2.h,horizontal: 6.w),
                        margin: EdgeInsets.symmetric(horizontal: 4.w,vertical: 1.h),
                      )
                    ],
                  ),





                  Gap(5.h),
                  ///add button
                  NeumorphicButton(
                    onPressed: () async {
                      if(title.value.isEmpty)
                        {
                           toast('Please enter title', backgroundColor: Get.theme.errorColor );
                           return;
                        }
                      var note = Notes(
                          title: title.value,
                          subtitle: subtitle.value,
                          status: 'TODO',
                          // time: selectedTime.value
                          time: selectedTime.value.inMilliseconds
                      );
                      print(note);
                     await DBProvider.db.addDataIntoNotes(note);
                      homeController.getAllNotes();
                     Get.back();
                    },
                    padding: EdgeInsets.symmetric(vertical: 2.h,horizontal: 10.w),
                    // style: NeumorphicStyle(border: NeumorphicBorder(color: Get.theme.colorScheme.tertiary.withOpacity(0.5),)),
                    child: Text('ADD',style: Get.textTheme.button!.copyWith(color: Get.theme.colorScheme.tertiary),),
                  ),

                  Gap(2.h),

                ],
        ),
      ),
    );
  }
}
