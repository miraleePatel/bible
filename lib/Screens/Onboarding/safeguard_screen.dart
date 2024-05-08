import 'package:bible_app/Screens/Dashboard/Menu/Language/language_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sliding_tutorial/flutter_sliding_tutorial.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sizer/sizer.dart';

import '../../Routes/routes.dart';
import '../../Utils/app_colors.dart';
import '../../Utils/string_constant.dart';
import '../../generated/assets.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_widget.dart';

class SafeguardScreen extends StatelessWidget {
  const SafeguardScreen(this.page, this.notifier, {super.key});
  final int page;
  final ValueNotifier<double> notifier;

  @override
  Widget build(BuildContext context) {
    return SlidingPage(
      page: page,
      notifier: notifier,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Image.asset(Assets.imagesOnbBg1,),
          Container(
            decoration: BoxDecoration(image: DecorationImage(image: AssetImage(Assets.imagesOnbBg4), fit: BoxFit.fill)),
          ),
          Align(
            alignment: const Alignment(0, 0.10),
            child: FractionallySizedBox(
              widthFactor: 0.9,
              heightFactor: 0.50,
              child: SlidingContainer(
                  offset: 300,
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 20, right: 20, top: 20),
                        child: CustomWidgets.text1(LanguageConstant.safeguardYourNotes.tr,
                            color: AppColors.whiteColor, fontSize: 17.sp, fontWeight: FontWeight.w600, textAlign: TextAlign.center),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 10, right: 10, top: 20, bottom: 20),
                        child: Image.asset(Assets.imagesDivider),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 25, right: 25),
                        child: CustomWidgets.text1(
                            LanguageConstant.signUpForAFree.tr,
                            color: AppColors.whiteColor,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                            textAlign: TextAlign.center),
                      ),
                    ],
                  )),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: FractionallySizedBox(
              widthFactor: 0.9,
              heightFactor: 0.40,
              child: SlidingContainer(
                  offset: 300,
                  child: Padding(
                    padding: EdgeInsets.only(left: 20, right: 20, bottom: 80),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        CustomGoldButton(
                          onTap: () {
                            GetStorage().write(onboarding, true);
                            Get.toNamed(Routes.LOGIN_SCREEN);
                          },
                          text: LanguageConstant.signIn.tr,
                        ),
                        /*  SizedBox(
                          height: 2.h,
                        ),
                        CustomLinearButton(
                          onTap: () {
                            Get.offAllNamed(Routes.DASHBOARD_SCREEN);
                          },
                          text: "SKIP",
                        ), */
                      ],
                    ),
                  )),
            ),
          ),

          Align(
            alignment: const Alignment(0, -0.60),
            child: FractionallySizedBox(
              widthFactor: 0.45,
              heightFactor: 0.15,
              child: SlidingContainer(
                  offset: 140,
                  child: Image.asset(
                    Assets.imagesOnbSafeguard,
                    scale: 8,
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
