import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:todo_timer/app/modules/home/views/add_todo.dart';
import 'package:todo_timer/app/modules/home/views/todo_item.dart';
import 'package:todo_timer/app/routes/app_pages.dart';
import '../../../database/db.dart';
import '../../../utils/widgets.dart';
import '../controllers/home_controller.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  HomeController controller = Get.find();
  int selectedType = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: NeumorphicColors.background,
      appBar: AppBar(
        elevation:0,
        backgroundColor: NeumorphicColors.background,
        title:  Text('Todo',style: Get.textTheme.headline2!.copyWith(color: Get.theme.primaryColor),),
        // actions: [
        //  NeumorphicRadio(
        //    padding: EdgeInsets.symmetric(horizontal: 4.w),
        //    value: 0,
        //    groupValue: selectedType,
        //    onChanged: (val) {
        //    print(val);
        //    setState(() {
        //      selectedType = val!;
        //    });
        //  },
        //      child:Icon(Icons.grid_view),
        //  ),
        //  NeumorphicRadio(
        //    value: 1,
        //    padding: EdgeInsets.symmetric(horizontal: 4.w),
        //    groupValue: selectedType,
        //    onChanged: (val) {
        //    print(val);
        //
        //    setState(() {
        //      selectedType = val!;
        //    });
        //  },
        //      child:Icon(Icons.list),
        //  )
        // ],
        // title:  NeumorphicText('Todo',style: NeumorphicStyle(color: Get.theme.primaryColor,/*border: NeumorphicBorder(color: Colors.white )*/),textStyle: NeumorphicTextStyle(fontSize: 30.sp,),),
      ),
      floatingActionButton: NeumorphicFloatingActionButton(
        onPressed: () {
          Get.bottomSheet(
              AddTodo(),
            backgroundColor: NeumorphicColors.background,
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

                  return  Stack(
                    children: [
                      TodoItem(index: index, status: controller.notesList[index].status!,note: controller.notesList[index],),
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
                      //               controller.deleteNote(controller.notesList[index].id!).then((value) {
                      //                 setState(() {
                      //                   controller.notesList.removeAt(index);
                      //                   // controller.getAllNotes();
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
                      // ),
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
