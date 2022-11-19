import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:todo_timer/app/modules/home/views/add_todo.dart';
import 'package:todo_timer/app/routes/app_pages.dart';
import '../../../utils/widgets.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: NeumorphicColors.background,
      appBar: AppBar(
        elevation:0,
        backgroundColor: Colors.transparent,
        title:  Text('Todo',style: Get.textTheme.headline2!.copyWith(color: Get.theme.primaryColor),),
        // title:  NeumorphicText('Todo',style: NeumorphicStyle(color: Get.theme.primaryColor,/*border: NeumorphicBorder(color: Colors.white )*/),textStyle: NeumorphicTextStyle(fontSize: 30.sp,),),
      ),
      floatingActionButton: NeumorphicFloatingActionButton(
        onPressed: () {
          Get.bottomSheet(
              AddTodo(),
            backgroundColor: NeumorphicColors.background,
              // backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(15))),
            isScrollControlled: true
          );
        },
        child: Icon(Icons.add,size: 30,color: Get.theme.primaryColor,),
      ),
      body: Padding(
        padding:  EdgeInsets.symmetric(vertical :3.h, horizontal: 2.w),
        child:  Obx(
                () {
            return ListView.builder(
                shrinkWrap: true,
                itemCount: controller.notesList.length,
                itemBuilder: (context,index) {
                  Duration duration = Duration(milliseconds: controller.notesList[index].time!);
                  String status = controller.notesList[index].status!;
                  // int val = index;
                  Color? color;
                  // String? status;


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

                  return Stack(
                    children: [
                      Padding(
                        padding:  EdgeInsets.symmetric(vertical: 2.h,horizontal: 4.w),
                        child: GestureDetector(
                          onTap: () {

                            Get.toNamed(Routes.DETAILS);
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
                                          depth: NeumorphicTheme.embossDepth(context),
                                          boxShape:  NeumorphicBoxShape.roundRect(BorderRadius.circular(10)),
                                        ),
                                        child: Text(Duration(milliseconds: controller.notesList[index].time!).toString().substring(2,6),style: Get.textTheme.subtitle2!.copyWith(color: color),)),

                                    Gap(5.w),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text('${controller.notesList[index].title}',style: Get.textTheme.bodyText2!.copyWith(fontWeight: FontWeight.bold),),
                                          Text('${controller.notesList[index].subtitle}',style: Get.textTheme.bodyText2!,maxLines: 1,overflow: TextOverflow.ellipsis,),
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
                      Positioned(
                        right: 0,
                        top: 5,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            NeumorphicButton(
                              onPressed: () {
                                deleteDialog().then((value) {
                                  if(value!= null && value) {
                                    controller.deleteNote(controller.notesList[index].id!).then((value) {
                                       controller.getAllNotes();                                    });
                                  }
                                });
                              },
                              style: NeumorphicStyle(boxShape: NeumorphicBoxShape.circle() ),
                              child: Icon(Icons.close,color: Get.theme.errorColor,size: 15,),

                            ),
                          ],
                        ),
                      )
                    ],
                  );
                }
            );
          }
        ),
      ),
    );
  }
}
//
// enum Status {
//   TODO,
//   INPROGRESS,
//   DONE
// }
