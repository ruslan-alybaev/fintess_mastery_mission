import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WishCard extends StatelessWidget {
  final String name;
  final int price;
  final Function(int) onBuy;
  
  const WishCard({
    required this.name,
    required this.price,
    required this.onBuy,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            child: Expanded(
              child: Text(
                name,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const Spacer(),
          GestureDetector(
            onTap: () {
              onBuy(price);
            },
            child: Container(
              width: 80.w,
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
                        "assets/images/svgs/coins.24.svg",
                        height: 16.h,
                        width: 16.w,
                      ),
                      SizedBox(
                        width: 4.w,
                      ),
                      Text(
                        price.toString(),
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
          ),
        ],
      ),
    );
  }
}
