import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fitness_mastery_mission/presentation/onboarding/widgets/next_button.dart';
import 'package:fitness_mastery_mission/presentation/wishes/screens/wishes_screen.dart';
import 'package:fitness_mastery_mission/presentation/wishes/widgets/wish_card.dart';

class OnboardingScreens extends StatefulWidget {
  const OnboardingScreens({super.key});

  @override
  State<OnboardingScreens> createState() => _OnboardingScreensState();
}

class _OnboardingScreensState extends State<OnboardingScreens> {
  final PageController _pageController = PageController();

  void _onNextPressed(int currentIndex) {
    if (currentIndex < 2) {
      _pageController.animateToPage(
        currentIndex + 1,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);

    return Scaffold(
      backgroundColor: const Color(0xff2d2d2d),
      body: PageView(
        controller: _pageController,
        children: [
          OnboardingFirstScreen(onNextPressed: () => _onNextPressed(0)),
          OnboardingSecondScreen(onNextPressed: () => _onNextPressed(1)),
          const OnboardingThirdScreen(),
        ],
      ),
    );
  }
}

class OnboardingFirstScreen extends StatelessWidget {
  final void Function()? onNextPressed;
  const OnboardingFirstScreen({super.key, this.onNextPressed});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SafeArea(
        child: Column(
          children: [
            Stack(
              children: [
                ShaderMask(
                  shaderCallback: (rect) {
                    return LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        const Color(0xff2d2d2d),
                        const Color(0xff2d2d2d).withOpacity(0.0),
                        const Color(0xff2d2d2d).withOpacity(0.0),
                        const Color(0xff2d2d2d),
                      ],
                      stops: const [0.0, 0.2, 0.8, 1.0],
                    ).createShader(rect);
                  },
                  blendMode: BlendMode.dstOut,
                  child: Image.asset(
                    'assets/images/pngs/photo_2024-07-03_11-18-33 1.png',
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                ),
                Positioned(
                  bottom: 12.w,
                  right: 12.w,
                  child: Row(
                    children: [
                      SvgPicture.asset("assets/images/svgs/coins.40.svg"),
                      SizedBox(width: 8.w),
                      Text(
                        "+5 coins",
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 24.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 16.w,
              ),
              child: Column(
                children: [
                  Text(
                    "Keep your finances\nin check",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 28.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  Text(
                    "by taking on fitness challenge",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    height: 40.h,
                  ),
                  NextButton(onPressed: onNextPressed)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class OnboardingSecondScreen extends StatelessWidget {
  final void Function()? onNextPressed;
  const OnboardingSecondScreen({super.key, this.onNextPressed});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SafeArea(
        child: Column(
          children: [
            Stack(
              children: [
                ShaderMask(
                  shaderCallback: (rect) {
                    return LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        const Color(0xff2d2d2d),
                        const Color(0xff2d2d2d).withOpacity(0.0),
                        const Color(0xff2d2d2d).withOpacity(0.0),
                        const Color(0xff2d2d2d),
                      ],
                      stops: const [0.0, 0.2, 0.8, 1.0],
                    ).createShader(rect);
                  },
                  blendMode: BlendMode.dstOut,
                  child: Image.asset(
                    'assets/images/pngs/photo_2024-07-03_11-18-33 1 (1).png',
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                ),
                Positioned(
                  bottom: 12.w,
                  right: 12.w,
                  child: Row(
                    children: [
                      SvgPicture.asset("assets/images/svgs/coins.40.svg"),
                      SizedBox(width: 8.w),
                      Text(
                        "+7 coins",
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 24.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 16.w,
              ),
              child: Column(
                children: [
                  Text(
                    "Challenge your\nboundaries",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 28.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  Text(
                    "with fitness and financial goals",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    height: 40.h,
                  ),
                  NextButton(onPressed: onNextPressed),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class OnboardingThirdScreen extends StatelessWidget {
  const OnboardingThirdScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SafeArea(
        child: Column(
          children: [
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                ShaderMask(
                  shaderCallback: (rect) {
                    return LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        const Color(0xff2d2d2d),
                        const Color(0xff2d2d2d).withOpacity(0.0),
                        const Color(0xff2d2d2d).withOpacity(0.0),
                        const Color(0xff2d2d2d),
                      ],
                      stops: const [0.0, 0.2, 0.8, 1.0],
                    ).createShader(rect);
                  },
                  blendMode: BlendMode.dstOut,
                  child: Image.asset(
                    'assets/images/pngs/photo_2024-07-03_11-18-33 1 (2).png',
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 12.w, right: 24.w, left: 24.w),
                  child: WishCard(
                    name: "New awesome pink earphones",
                    price: 13,
                    onBuy: (p0) {},
                  ),
                )
              ],
            ),
            SizedBox(
              height: 24.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 16.w,
              ),
              child: Column(
                children: [
                  Text(
                    "Turn your\nhard work",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 28.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  Text(
                    "into dream-fulfilling rewards",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    height: 40.h,
                  ),
                  NextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const WishesScreen()));
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
