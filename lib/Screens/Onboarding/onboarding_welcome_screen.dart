import 'package:bible_app/Screens/Dashboard/Menu/Language/language_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sliding_tutorial/flutter_sliding_tutorial.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../Utils/app_colors.dart';
import '../../generated/assets.dart';
import '../../widgets/custom_widget.dart';

class OnboardingWelcomeScreen extends StatelessWidget {
  const OnboardingWelcomeScreen(
    this.page,
    this.notifier, {
    super.key,
  });

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
            decoration: BoxDecoration(image: DecorationImage(image: AssetImage(Assets.imagesOnbBg1), fit: BoxFit.fill)),
          ),
          Align(
            alignment: const Alignment(0, 0.29),
            child: FractionallySizedBox(
              widthFactor: 0.9,
              heightFactor: 0.36,
              child: SlidingContainer(
                  offset: 300,
                  child: Column(
                    children: [
                      CustomWidgets.text1(LanguageConstant.startYourSpiritual.tr,
                          color: AppColors.whiteColor, fontSize: 16.sp, fontWeight: FontWeight.w600, textAlign: TextAlign.center),
                      Padding(
                        padding: EdgeInsets.only(left: 10, right: 10, top: 20, bottom: 20),
                        child: Image.asset(Assets.imagesDivider),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 20, right: 20),
                        child: CustomWidgets.text1(LanguageConstant.welcomeToBible.tr,
                            color: AppColors.whiteColor, fontSize: 12.sp, fontWeight: FontWeight.w400, textAlign: TextAlign.center),
                      ),
                    ],
                  )),
            ),
          ),

          Align(
            alignment: const Alignment(0, -0.34),
            child: FractionallySizedBox(
              widthFactor: 0.45,
              heightFactor: 0.15,
              child: SlidingContainer(
                  offset: 140,
                  child: Image.asset(
                    Assets.imagesOnboadingVerse,
                    scale: 5,
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
