// ignore_for_file: prefer_const_constructors

import 'package:bible_app/Routes/routes.dart';
import 'package:bible_app/Screens/Dashboard/Menu/Language/language_constant.dart';
import 'package:bible_app/Utils/app_colors.dart';
import 'package:bible_app/widgets/custom_appbar.dart';
import 'package:bible_app/widgets/custom_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../../widgets/custom_button.dart';

class TopicScreen extends StatefulWidget {
  const TopicScreen({super.key});

  @override
  State<TopicScreen> createState() => _TopicScreenState();
}

class _TopicScreenState extends State<TopicScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.bgColor,
        key: _scaffoldKey,
        appBar: CustomAppbar.appbar(
          scaffoldKey: _scaffoldKey,
          title: LanguageConstant.topicalBible.tr,
          centerTitle: true,
          isBackIcon: true,
        ),
        body: ListView.builder(
          itemCount: 10,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(top: 15, left: 10, right: 10),
              child:
              CustomLinearButton(
                height: 7.5.h,
                width: 93.w,
                onTap: (){

                   Get.toNamed(Routes.TOPIC_DETAIL_SCREEN);
                },
                gradient: LinearGradient(
                  colors: [
                    AppColors.yellowColor.withOpacity(0.55),
                    AppColors.yellowColor.withOpacity(0.0),
                  ],
                  begin: Alignment.topLeft,
                  // end: Alignment.bottomLeft,
                ),
                color:AppColors.aapbarColor ,
                child: Padding(
                  padding: const EdgeInsets.only(left: 12),
                  child: Row(
                    children: [
                      CircleAvatar(
                          backgroundColor: AppColors.texfeildColor,
                          child: CustomWidgets.text1("Hope".characters.first,
              
                              fontWeight: FontWeight.w700,
                              color: AppColors.blackColor,
                              fontSize: 12.sp)),
                      SizedBox(
                        width: 2.w,
                      ),
                      CustomWidgets.text1("Hope",
              
                          color: AppColors.whiteColor, fontSize: 12.sp)
                    ],
                  ),
                ),
              )
              /* Container(
                width: 80.w,
                height: 8.h,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                  gradient:
                      LinearGradient(
                        colors: [
                          AppColors.yellowColor.withOpacity(0.50),
                          AppColors.yellowColor.withOpacity(0.1),
                        ],
                      ),

                ),
                alignment: Alignment.center,
                child: InkWell(
                  onTap: (){
                    Get.toNamed(Routes.TOPIC_DETAIL_SCREEN);
                  },
                  child: Container(
                    height: 7.5.h,
                    width: 94.w,
                    decoration: BoxDecoration(
                      color: AppColors.aapbarColor,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 12),
                      child: Row(
                        children: [
                          CircleAvatar(
                              backgroundColor: AppColors.texfeildColor,
                              child: CustomWidgets.text1("Hope".characters.first,

                                      fontWeight: FontWeight.w600,
                                      color: AppColors.bgColor,
                                      fontSize: 12.sp)),
                          SizedBox(
                            width: 2.w,
                          ),
                          CustomWidgets.text1("Hope",

                                  color: AppColors.whiteColor, fontSize: 12.sp)
                        ],
                      ),
                    ),
                  ),
                ),
              ),*/
            );
          },
        ));
  }
}
