// ignore_for_file: prefer_const_constructors

import 'package:bible_app/Controller/dashboard_controller.dart';
import 'package:bible_app/Screens/Dashboard/Menu/Language/language_constant.dart';
import 'package:bible_app/Utils/app_colors.dart';
import 'package:bible_app/generated/assets.dart';
import 'package:bible_app/widgets/custom_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';


class VerseDayScreen extends StatefulWidget {
  const VerseDayScreen({super.key});

  @override
  State<VerseDayScreen> createState() => _VerseDayScreenState();
}

class _VerseDayScreenState extends State<VerseDayScreen> {
  DashboardController dashboardController = Get.put(DashboardController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(
        backgroundColor: AppColors.aapbarColor,
        elevation: 3,
        centerTitle: true,
        title: CustomWidgets.text1(
          LanguageConstant.verseDay.tr,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: AppColors.whiteColor,
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: 6,
        itemBuilder: (context, index) {
          return Column(
            children: [
              CustomWidgets.container(ontap: (){
                 Get.back();
                 dashboardController.selectedIndex.value = 1;
              },
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                          Assets.iconVerofdaybox,
                          scale: 6,
                        ),
                        SizedBox(
                          width: 3.w,
                        ),
                        Flexible(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomWidgets.text1("Genesis 1:3",
                                  letterSpacing: 0.5,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700),
                              SizedBox(
                                height: 5,
                              ),
                              CustomWidgets.text1(
                                "For God so loved the world, that he gave his only Son, that whoever believes in him should",
                                textAlign: TextAlign.start,
                                fontWeight: FontWeight.w500,
                                fontSize: 8.sp,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Image.asset(
                          Assets.iconShare,
                          scale: 2,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                      /*   GestureDetector(
                          onTap: () {
                            Get.toNamed(Routes.SHARE_IMAGE_SCREEN);
                          },
                          child: Image.asset(
                            Assets.iconImageShare,
                            scale: 6,
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ), */
                        GestureDetector(
                          onTap: () {},
                          child: Image.asset(
                            Assets.iconCopyGreyicon,
                            scale: 6,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              6 - 1 == index
                  ? SizedBox(
                      height: 2.h,
                    )
                  : const SizedBox(),
            ],
          );
        },
      ),
    );
  }
}
