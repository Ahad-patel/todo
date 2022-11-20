

import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'apptheme.dart';

class NeumorphicTextField extends StatefulWidget {
  final String? label;
  final String hint;
  final int? minLines;
  final int? maxLines;
  final TextEditingController? controller;
  final bool? enabled;
  final bool? required;

  final ValueChanged<String>? onChanged;

 const NeumorphicTextField({super.key, this.label, required this.hint, this.onChanged, this.maxLines = 1, this.minLines = 1, this.controller, this.enabled = true, this.required = false});

  @override
  State<NeumorphicTextField> createState() => _NeumorphicTextFieldState();
}

class _NeumorphicTextFieldState extends State<NeumorphicTextField> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    // _controller = TextEditingController(text: widget.hint);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
       if(widget.label != null)
        Padding(
          padding:  EdgeInsets.symmetric(horizontal: 4.w , vertical: 1.h),
          child: Row(
            children: [
              Text(
                widget.label!,
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: Get.theme.primaryColor,
                ),
              ),
              if(widget.required!)
              Text(
                "*",
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: Get.theme.errorColor,
                ),
              ),
            ],
          ),
        ),
        Neumorphic(
          margin:  EdgeInsets.only(left: 2.w, right: 2.w, top: 0.25.h, bottom: 0.5.h),
          style: NeumorphicStyle(
            depth: NeumorphicTheme.embossDepth(context),
            boxShape:  NeumorphicBoxShape.roundRect(BorderRadius.circular(10)),
          ),
          padding:  EdgeInsets.symmetric(vertical: 2.h, horizontal: 5.w),
          child: TextField(
            enabled: widget.enabled,
            onChanged: widget.onChanged,
            controller: widget.controller ?? _controller,
            maxLines: widget.maxLines,
            minLines: widget.minLines,
            decoration: InputDecoration.collapsed(hintText: widget.hint,hintStyle: Get.textTheme.bodyText2!.copyWith(color: Get.theme.disabledColor)),
          ),
        ),
      ],
    );
  }
}


toast(String msg,{Color? backgroundColor}) {
 return Fluttertoast.showToast(
      msg: msg,
      backgroundColor: backgroundColor,
      gravity: ToastGravity.BOTTOM
 );
}

Future<bool?> deleteDialog() {
  return Get.dialog(
      AlertDialog(
        backgroundColor: NeumorphicColors.background,
        title: Text("Are you sure to delete?"),
        actionsAlignment: MainAxisAlignment.spaceBetween,
        actions: [
          NeumorphicButton(
            onPressed: () => Get.back(result: false),
            // padding: EdgeInsets.symmetric(vertical: 2.h,horizontal: 10.w),
            child: Text('Cancel',style: Get.textTheme.button!.copyWith(color: Get.theme.colorScheme.tertiary),),
          ),
          NeumorphicButton(
            onPressed: () => Get.back(result: true),
            // padding: EdgeInsets.symmetric(vertical: 2.h,horizontal: 10.w),
            child: Text('Delete',style: Get.textTheme.button!.copyWith(color: Get.theme.colorScheme.error),),
          ),
        ],
      )
  ).then((value) => value);

}

String twoDigits(int n) => n.toString().padLeft(2,'0');

neumorphicDepthContainer(context,int? time,{TextStyle? style}) {
  return Neumorphic(
    padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 3.h),
    style: NeumorphicStyle(
      depth: NeumorphicTheme.embossDepth(context),
      boxShape:  NeumorphicBoxShape.roundRect(BorderRadius.circular(10)),
    ),
    child: Text(Duration(milliseconds: time!).toString().substring(2,7),style: style ?? Get.textTheme.subtitle2!.copyWith(color: Get.theme.primaryColor),),
  );
}