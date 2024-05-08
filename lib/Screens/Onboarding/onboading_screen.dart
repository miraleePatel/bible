import 'package:bible_app/Screens/Onboarding/journey_screen.dart';
import 'package:bible_app/Screens/Onboarding/onboarding_verse_screen.dart';
import 'package:bible_app/Screens/Onboarding/onboarding_welcome_screen.dart';
import 'package:bible_app/Screens/Onboarding/safeguard_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sliding_tutorial/flutter_sliding_tutorial.dart';
import 'package:flutter_svg/svg.dart';

import '../../Utils/app_colors.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final ValueNotifier<double> notifier = ValueNotifier(0);
  final _pageCtrl = PageController();
  int pageCount = 4;
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Center(
          child: Stack(
            children: <Widget>[
              /// [StatefulWidget] with [PageView] and [AnimatedBackgroundColor].
              SlidingTutorial(
                controller: _pageCtrl,
                pageCount: pageCount,
                notifier: notifier,
              ),

              /// Separator.
              Align(
                alignment: const Alignment(0, 0.85),
                child: Container(
                  width: double.infinity,
                  height: 0.5,
                  color: AppColors.yellowColor
                ),
              ),
            /*  Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  icon: const Icon(
                    Icons.arrow_back_ios_rounded,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    _pageCtrl.previousPage(
                      duration: const Duration(milliseconds: 600),
                      curve: Curves.linear,
                    );
                  },
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                  icon: const Icon(
                    Icons.arrow_back_ios_rounded,
                    color: Colors.white,
                    textDirection: TextDirection.rtl,
                  ),
                  onPressed: () {
                    _pageCtrl.nextPage(
                      duration: const Duration(milliseconds: 600),
                      curve: Curves.linear,
                    );
                  },
                ),
              ),*/

              /// [SlidingIndicator] for [PageView] in [SlidingTutorial].
              Align(
                alignment: const Alignment(0, 0.94),
                child: SlidingIndicator(
                  indicatorCount: pageCount,
                  notifier: notifier,
                  activeIndicator: const Icon(
                    Icons.fiber_manual_record,
                    color: AppColors.whiteColor,
                  ),
                  inActiveIndicator: SvgPicture.asset(
                    'assets/hollow_circle.svg',
                  ),
                  inactiveIndicatorSize: 14,
                  activeIndicatorSize: 14,
                ),
              )
            ],
          )),
    );
  }
}



class SlidingTutorial extends StatefulWidget {
  const SlidingTutorial({
    required this.controller,
    required this.notifier,
    required this.pageCount,
    super.key,
  });

  final ValueNotifier<double> notifier;
  final int pageCount;
  final PageController controller;

  @override
  State<StatefulWidget> createState() => _SlidingTutorial();
}

class _SlidingTutorial extends State<SlidingTutorial> {
  late PageController _pageController;

  @override
  void initState() {
    _pageController = widget.controller;

    /// Listen to [PageView] position updates.
    _pageController.addListener(_onScroll);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBackgroundColor(
      pageController: _pageController,
      pageCount: widget.pageCount,
      /// You can use your own color list for page background
      //ignore: avoid_redundant_argument_values
      colors: const [
        Color(0xff58101D),
        Color(0xff440C17),
        Color(0xff58101D),
        Color(0xff440C17),
        Color(0xff58101D),

      ],
      child: Stack(
        children: [
          PageView(
            controller: _pageController,
            children: List<Widget>.generate(
              widget.pageCount,
              _getPageByIndex,
            ),
          ),
        ],
      ),
    );
  }

  /// Create different [SlidingPage] for indexes.
  Widget _getPageByIndex(int index) {
    switch (index % 4) {
      case 0:
        // return WebAnalyticsPage(index, widget.notifier);
        return OnboardingWelcomeScreen(index, widget.notifier);
      case 1:
        // return WebDevelopersPage(index, widget.notifier);
      return JourneyScreen(index,widget.notifier);

      case 2:
        // return ECommercePage(index, widget.notifier);
        return OnboardingVerseScreen(index,widget.notifier);
      case 3:
      // return ECommercePage(index, widget.notifier);
        return SafeguardScreen(index,widget.notifier);
      default:
        throw ArgumentError('Unknown position: $index');
    }
  }

  /// Notify [SlidingPage] about current page changes.
  void _onScroll() {
    widget.notifier.value = _pageController.page ?? 0;
  }
}