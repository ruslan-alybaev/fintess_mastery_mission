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
    return SafeArea(
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
                  'assets/images/photo_2024-07-03_11-18-33 1.png',
                  height: MediaQuery.of(context).size.height * 0.5,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
              Positioned(
                bottom: 12.w,
                right: 12.w,
                child: Row(
                  children: [
                    SvgPicture.asset("assets/icons/coins.40.svg"),
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
    );
  }
}

class OnboardingSecondScreen extends StatelessWidget {
  final void Function()? onNextPressed;
  const OnboardingSecondScreen({super.key, this.onNextPressed});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
                  'assets/images/photo_2024-07-03_11-18-33 1 (1).png',
                  height: MediaQuery.of(context).size.height * 0.5,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
              Positioned(
                bottom: 12.w,
                right: 12.w,
                child: Row(
                  children: [
                    SvgPicture.asset("assets/icons/coins.40.svg"),
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
    );
  }
}

class OnboardingThirdScreen extends StatelessWidget {
  const OnboardingThirdScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
                  'assets/images/photo_2024-07-03_11-18-33 1 (2).png',
                  height: MediaQuery.of(context).size.height * 0.5,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 12.w,),
                child: Container(
                  constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width - 48.w),
                  height: 63.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: const Color(0xff3D4352),
                    borderRadius: BorderRadius.circular(16.r),
                    border: Border.all(
                      color: const Color(0xff848482),
                      width: 0.5.w,
                    ),
                  ),
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 12.w),
                        child: Text(
                          "New awesome pink earphones",
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const Spacer(),
                      Container(
                        width: 60.w,
                        decoration: BoxDecoration(
                          color: const Color(0xff2D2D2D),
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(16.r),
                            bottomRight: Radius.circular(16.r),
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Buy",
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w400,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(
                              height: 4.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  "assets/icons/coins.24.svg",
                                  height: 16.h,
                                  width: 16.w,
                                ),
                                SizedBox(
                                  width: 4.w,
                                ),
                                Text(
                                  "13.0",
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
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
    );
  }
}
