import 'package:event_bus/event_bus.dart';
import 'package:fitness_mastery_mission/hive/wish.dart';
import 'package:fitness_mastery_mission/presentation/onboarding/screens/onboarding_screens.dart';
import 'package:fitness_mastery_mission/presentation/wishes/screens/wishes_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(WishAdapter());
  await Hive.openBox<Wish>('wishes');

  final getIt = GetIt.instance;
  getIt.registerSingleton<EventBus>(EventBus());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812), 
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            scaffoldBackgroundColor: const Color(0xff2d2d2d),
          ),
          home: const OnboardingScreens(),
        );
      },
    );
  }
}
