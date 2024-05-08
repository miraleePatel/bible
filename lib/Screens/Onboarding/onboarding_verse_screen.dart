// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_sliding_tutorial/flutter_sliding_tutorial.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../Dashboard/Menu/Language/language_constant.dart';
import '../../Utils/app_colors.dart';
import '../../Widgets/custom_widget.dart';
import '../../generated/assets.dart';

class OnboardingVerseScreen extends StatelessWidget {
  const OnboardingVerseScreen(this.page, this.notifier, {super.key});
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
          Container(
            decoration: BoxDecoration(image: DecorationImage(image: AssetImage(Assets.imagesOnbBg3), fit: BoxFit.fill)),
          ),
          Align(
            alignment: const Alignment(0, -1.20),
            child: FractionallySizedBox(
              widthFactor: 0.9,
              heightFactor: 0.35,
              child: Center(
                child: CustomWidgets.text1(LanguageConstant.verseHightLights.tr,
                    fontWeight: FontWeight.w600, fontSize: 14, textAlign: TextAlign.center, color: AppColors.whiteColor),
              ),
            ),
          ),
          // his interview isn't assign me
          Align(
            alignment: const Alignment(0, 0.15),
            child: FractionallySizedBox(
              widthFactor: 0.15.w,
              heightFactor: 0.50,
              child: SlidingContainer(offset: 300, child: Image.asset(Assets.imagesOnbVerBg,    fit: BoxFit.fill,)),
            ),
          ),
          Align(
            alignment: Alignment(-1.2.w, -0.5),
            child: FractionallySizedBox(
              widthFactor: 0.9,
              heightFactor: 0.60,
              child: Padding(
                padding: const EdgeInsets.only(right: 100),
                child: SlidingContainer(
                    offset: 300,
                    child: Image.asset(
                      Assets.imagesOnbHighlight,
                      scale: 8,
                    )),
              ),
            ),
          ),
          Align(
            alignment: Alignment(-1.3.w, 1.10),
            child: FractionallySizedBox(
              widthFactor: 0.9,
              heightFactor: 0.60,
              child: Padding(
                padding: const EdgeInsets.only(right: 100),
                child: SlidingContainer(
                    offset: 300,
                    child: Image.asset(
                      Assets.imagesOnbBookmark,
                      scale: 6,
                    )),
              ),
            ),
          ),
          Align(
            alignment: Alignment(1.2.w, 0.40),
            child: FractionallySizedBox(
              widthFactor: 0.9,
              heightFactor: 0.60,
              child: Padding(
                padding: const EdgeInsets.only(left: 100),
                child: SlidingContainer(
                    offset: 300,
                    child: Image.asset(
                      Assets.imagesOnbNote,
                      scale: 8,
                    )),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
