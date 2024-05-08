import 'package:bible_app/Screens/Dashboard/Menu/Language/language_constant.dart';
import 'package:bible_app/Utils/app_colors.dart';
import 'package:bible_app/widgets/custom_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sliding_tutorial/flutter_sliding_tutorial.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../generated/assets.dart';

class JourneyScreen extends StatelessWidget {
  const JourneyScreen(
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
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(Assets.imagesOnbBg2), fit: BoxFit.fill)),
          ),
          Align(
            alignment: const Alignment(0, -1.20),
            child: FractionallySizedBox(
              widthFactor: 0.9,
              heightFactor: 0.35,
              child: Center(
                child: CustomWidgets.text1(
                    LanguageConstant.exploreYourSpiritual.tr,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    textAlign: TextAlign.center,
                    color: AppColors.whiteColor),
              ),
            ),
          ),
          Align(
            alignment: const Alignment(0, 0.2),
            child: FractionallySizedBox(
              widthFactor: 0.23.w,
              // heightFactor: 8.h,
              child: SlidingContainer(
                  offset: 300,
                  child: Image.asset(
                    Assets.imagesJourneyBg,
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
