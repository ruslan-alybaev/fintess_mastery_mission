import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fitness_mastery_mission/hive/wish.dart';
import 'package:hive/hive.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  List<Wish> purchasedWishes = [];

  @override
  void initState() {
    super.initState();
    // Открываем Box для purchased_wishes
    Hive.openBox<Wish>('purchased_wishes').then((box) {
      setState(() {
        // Загружаем все элементы из Box в список purchasedWishes
        purchasedWishes = box.values.toList();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff2D2D2D),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Padding(
            padding: EdgeInsets.all(16.w),
            child: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
              size: 24,
            ),
          ),
        ),
        centerTitle: true,
        title: Text(
          "Wishes history",
          style: TextStyle(
            fontSize: 20.sp, 
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: purchasedWishes.isEmpty
            ? Center(
                child: Text(
                  "No purchased wishes yet.",
                  style: TextStyle(
                    fontSize: 16.sp, 
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                  ),
                ),
              )
            : ListView.builder(
                itemCount: purchasedWishes.length,
                itemBuilder: (context, index) {
                  final wish = purchasedWishes[index];
                  String formattedDate = wish.purchaseDate != null
                      ? "${wish.purchaseDate!.year}.${wish.purchaseDate!.month.toString().padLeft(2, '0')}.${wish.purchaseDate!.day.toString().padLeft(2, '0')}"
                      : "No date";
                  return Padding(
                    padding: EdgeInsets.only(top: 12.w),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 12.w),
                      decoration: BoxDecoration(
                        color: const Color(0xff3D4352),
                        borderRadius: BorderRadius.circular(16.r),  
                        border: Border.all(
                          color: const Color(0xff848482),
                          width: 0.5.w,  
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 12.w),
                        child: Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  formattedDate,
                                  style: TextStyle(
                                    fontSize: 12.sp, 
                                    fontWeight: FontWeight.w400,
                                    color: const Color(0xffD6D6D6),
                                  ),
                                ),
                                Text(
                                  wish.name,
                                  maxLines: 2,
                                  style: TextStyle(
                                    fontSize: 16.sp, 
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                            const Spacer(),
                            Container(
                              width: 80.w,  
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(16.r),  
                                  bottomRight: Radius.circular(16.r),  
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    "assets/images/svgs/coins.24.svg",
                                    height: 24.h,  
                                    width: 24.w,  
                                  ),
                                  SizedBox(width: 5.w),  
                                  Text(
                                    wish.price.toString(),
                                    style: TextStyle(
                                      fontSize: 16.sp, 
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
