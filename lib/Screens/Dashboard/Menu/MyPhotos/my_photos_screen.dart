import 'dart:io';

import 'package:bible_app/Screens/Dashboard/Menu/Language/language_constant.dart';
import 'package:bible_app/Utils/app_colors.dart';
import 'package:bible_app/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../../Controller/bible_controller.dart';
import '../../../../Routes/routes.dart';
import '../../../../Utils/static_list.dart';
import '../../../../Widgets/custom_widget.dart';

class MyPhotosScreen extends StatefulWidget {
  const MyPhotosScreen({super.key});

  @override
  State<MyPhotosScreen> createState() => _MyPhotosScreenState();
}

class _MyPhotosScreenState extends State<MyPhotosScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  BibleController bibleController = Get.put(BibleController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      key: _scaffoldKey,
      appBar: CustomAppbar.appbar(
        scaffoldKey: _scaffoldKey,
        title: LanguageConstant.myPhoto.tr,
        centerTitle: true,
        isBackIcon: true,
      ),
      body:bibleController.savedImages.isNotEmpty ?
      Padding(
        padding: const EdgeInsets.all(15),
        child: GridView.builder(
          itemCount: bibleController.savedImages.length,
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              mainAxisSpacing: 5,
              crossAxisSpacing: 8,
              maxCrossAxisExtent: 120,
              mainAxisExtent: 140),
          itemBuilder: (context, index) {
            return Column(
              children: [
                Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                      color: AppColors.aapbarColor,
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                          color: AppColors.yellowColor.withOpacity(0.4)),
                      image: DecorationImage(
                          image: FileImage(File(bibleController.savedImages[index].path)),
                          fit: BoxFit.fill)),
                ),
                SizedBox(
                  height: 1.h,
                ),
                GestureDetector(
                  onTap: () {
                    Get.toNamed(Routes.DASHBOARD_SCREEN, arguments: 1.obs);
                  },
                  child:  CustomWidgets.text1(bibleController.savedImages[index].verseName,
                      fontSize: 8.sp, color: AppColors.whiteColor, overflow: TextOverflow.ellipsis, maxLine: 1),
                )
              ],
            );
          },
        ),
      ):
      Center(
        child: CustomWidgets.text1("No Image Found", fontWeight: FontWeight.w600, fontSize: 9.sp, color: AppColors.whiteColor),
      ),
    );
  }
}
