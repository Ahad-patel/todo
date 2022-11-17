import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../controllers/home_controller.dart';
import 'btn_design.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: NeumorphicColors.background,
      appBar: AppBar(
        elevation:0,
        backgroundColor: Colors.transparent,
        title:  Text('Todo',style: Get.textTheme.headline6!.copyWith(color: Get.theme.primaryColor),),
      ),
      // floatingActionButton: const Design(
      //   height1: 55,
      //   width1: 55,
      //   color: Color(0xFFe6ebf2),
      //   offsetB: Offset(-2, -2),
      //   offsetW: Offset(2, 2),
      //   bLevel: 3.0,
      //   iconData: Icons.add,
      //   iconSize: 30.0,
      // ),
      floatingActionButton: NeumorphicFloatingActionButton(
        // Icons.add_circle,size: 80,
        onPressed: () {},
        // style: NeumorphicStyle(shape: NeumorphicShape.convex),
        child: Icon(Icons.add,size: 30,color: Get.theme.primaryColor,),
      ),
      // floatingActionButton: NeumorphicFloatingActionButton(
      //   onPressed: () {},
      //   style: NeumorphicStyle(shape: NeumorphicShape.convex),
      //   child: Icon(Icons.add,size: 30,color: Get.theme.primaryColor,),
      // ),
      body: Padding(
        padding:  EdgeInsets.symmetric(vertical :3.h, horizontal: 2.w),
        child:  ListView.builder(
            shrinkWrap: true,
            itemCount: 3,
            itemBuilder: (context,index) {

              int val = index;
              Color? color;
              String? status;
              switch(val) {
               case 0 :
                 status = "TODO";
                 color = Get.theme.primaryColor;
                 break;
               case 1 :
                 status = "IN-PROGRESS,";
                 color = Get.theme.colorScheme.secondary;
                 break;
               case 2 :
                 status = "DONE";
                 color = Get.theme.colorScheme.tertiary;
                 break;
              }

              return Stack(
                children: [
                  Padding(
                    padding:  EdgeInsets.symmetric(vertical: 2.h,horizontal: 4.w),
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

                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Title',style: Get.textTheme.bodyText2!.copyWith(fontWeight: FontWeight.bold),),
                                    Text('SubTitle',style: Get.textTheme.bodyText2!,maxLines: 1,overflow: TextOverflow.ellipsis,),
                                  ],
                                ),
                              ),
                              Chip(label: Text('$status',style: Get.textTheme.bodyText2!.copyWith(color: Colors.white),),backgroundColor: color,)


                            ],
                          ),
                        )
                    ),
                  ),
                  Positioned(
                    right: 0,
                    top: 5,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        NeumorphicButton(
                          onPressed: () {},
                          style: NeumorphicStyle(boxShape: NeumorphicBoxShape.circle() ),
                          child: Icon(Icons.close,color: Get.theme.errorColor,size: 15,),

                        ),
                      ],
                    ),
                  )
                ],
              );
            }
        ),
      ),
    );
  }
}
