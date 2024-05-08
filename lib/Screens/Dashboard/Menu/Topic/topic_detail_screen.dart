// ignore_for_file: prefer_const_constructors

import 'package:bible_app/Screens/Dashboard/Menu/Language/language_constant.dart';
import 'package:bible_app/Utils/app_colors.dart';
import 'package:bible_app/Utils/myicon_icons.dart';
import 'package:bible_app/generated/assets.dart';
import 'package:bible_app/widgets/custom_appbar.dart';
import 'package:bible_app/widgets/custom_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../../Routes/routes.dart';

class TopicDetailScreen extends StatefulWidget {
  const TopicDetailScreen({super.key});

  @override
  State<TopicDetailScreen> createState() => _TopicDetailScreenState();
}

class _TopicDetailScreenState extends State<TopicDetailScreen> {
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
        itemCount: 5,
        itemBuilder: (context, index) {
          return Column(
            children: [
              CustomWidgets.container(
                  child: Padding(
                padding: const EdgeInsets.only(
                    left: 15, right: 15, top: 20, bottom: 10),
                child: Column(
                  children: [
                    CustomWidgets.text1(
                        "\"But those who hope in the Lord will renew their strength. They will soar on wings like eagles; they will run and not grow weary, they will walk and not be faint.\"",
                        fontSize: 8.sp,
                        color: AppColors.blackColor,
                        height: 1.2,
                        fontWeight: FontWeight.w600),
                    Align(
                      alignment: Alignment.centerRight,
                      child: CustomWidgets.text1("- Isaiah 40:31",
                          fontSize: 8.sp,
                          color: AppColors.blackColor,
                          height: 1.2,
                          letterSpacing: 0.8,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 2.h,
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
                        GestureDetector(
                            onTap: () {
                              Get.toNamed(Routes.SHARE_IMAGE_SCREEN);
                            },
                            child: CustomWidgets.customIcon(
                                icon: Myicon.imageshare,
                                height: 3.3.h,
                                width: 3.3.h,
                                size: 16)),
                      ],
                    ),
                  ],
                ),
              )),
              5 - 1 == index
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
