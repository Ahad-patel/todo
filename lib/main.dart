import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'app/routes/app_pages.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
    builder: (context, orientation, screenType) {
        return GetMaterialApp(
          title: "Application",
          initialRoute: AppPages.INITIAL,
          getPages: AppPages.routes,
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            scaffoldBackgroundColor:Colors.white,
            useMaterial3: true,
            primaryColor:const Color(0xFF50577A),
           colorScheme: ColorScheme.fromSeed(
                seedColor: const Color(0xFF50577A),
                primary: const Color(0xFF50577A),
               secondary: const Color(0xFFFF5F00),
               tertiary: const Color(0xFF3E7C17),
            ),
          ),

        );
      }
    );
  }
}

