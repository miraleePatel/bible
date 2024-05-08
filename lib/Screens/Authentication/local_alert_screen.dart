import 'package:flutter/material.dart';
import 'package:flutter_sliding_tutorial/flutter_sliding_tutorial.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../Controller/bible_controller.dart';
import '../../Utils/app_colors.dart';
import '../../Utils/string_constant.dart';
import '../../Widgets/custom_widget.dart';
import '../../generated/assets.dart';
import '../Dashboard/Menu/Language/language_constant.dart';

class LocalAlertScreen extends StatefulWidget {
  const LocalAlertScreen({super.key});

  @override
  State<LocalAlertScreen> createState() => _LocalAlertScreenState();
}

class _LocalAlertScreenState extends State<LocalAlertScreen> {
  BibleController bibleController = Get.put(BibleController());
  @override
  void initState() {
    super.initState();
     callMethodOnInit();
  }

  callMethodOnInit() async {
    await bibleController.storeEngBible(isLoaderShow: false);
    await bibleController.storeFrenchBible(isLoaderShow: false);

  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: AppColors.bgColor,

      body: Obx(() => isInternetAvailable.value == true
          ?Stack(
        clipBehavior: Clip.none,
        children: [
          // Image.asset(Assets.imagesOnbBg1,),
          Container(
            decoration: BoxDecoration(image: DecorationImage(image: AssetImage(Assets.imagesLocalStoreImage), fit: BoxFit.fill)),
          ),

          Padding(
            padding: const EdgeInsets.only(right: 10,top: 26),

            child: Align(
                child: Image.asset(Assets.imagesLoader,scale: 15)),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20,right: 20,bottom: 20),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [

                  CustomWidgets.text1("Offline data storage in progress...",
                      color: AppColors.whiteColor, fontSize: 12.sp, fontWeight: FontWeight.w600, textAlign: TextAlign.center),
                  CustomWidgets.text1("Please wait while this process completes. ",
                      color: AppColors.whiteColor, fontSize: 8.sp, fontWeight: FontWeight.w600, textAlign: TextAlign.center),
                ],
              ),
            ),
          ),

        ],
      ) :Image.asset(
        Assets.imagesNoIntenet,
        fit: BoxFit.cover,
      )),
    );
  }
}
