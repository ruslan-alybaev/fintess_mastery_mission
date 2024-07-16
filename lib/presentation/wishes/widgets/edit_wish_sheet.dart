import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:event_bus/event_bus.dart';
import 'package:fitness_mastery_mission/event_bus/wish_deleted_event.dart';
import 'package:fitness_mastery_mission/event_bus/wish_updated_event.dart';
import 'package:fitness_mastery_mission/hive/wish.dart';

class EditWishSheet extends StatelessWidget {
  final Wish wish;

  const EditWishSheet({super.key, required this.wish});

  @override
  Widget build(BuildContext context) {
    final TextEditingController nameController =
        TextEditingController(text: wish.name);
    final TextEditingController priceController =
        TextEditingController(text: wish.price.toString());

    return Container(
      color: const Color(0xff3D4352),
      height: MediaQuery.of(context).size.height - 100.h,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 6.w),
            child: Center(
              child: Container(
                width: 36.w,
                height: 5.h,
                decoration: BoxDecoration(
                  color: const Color(0xff7F7F7F),
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ),
          ),
          SizedBox(height: 6.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Row(
              children: [
                Text(
                  "Add your wish",
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                    decoration: TextDecoration.none,
                  ),
                ),
                const Spacer(),
                Container(
                  width: 30.w,
                  height: 30.h,
                  padding: EdgeInsets.zero,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xff7F7F7F),
                  ),
                  child: Center(
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.close,
                        color: Color(0xffC2C2C2),
                      ),
                      iconSize: 20.sp,
                      padding: EdgeInsets.zero,
                      alignment: Alignment.center,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 27.h),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 24.w,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Name",
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                    decoration: TextDecoration.none,
                  ),
                ),
                SizedBox(height: 2.h),
                Material(
                  color: Colors.transparent,
                  child: TextField(
                    cursorColor: Colors.white,
                    controller: nameController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color(0xff485268),
                      contentPadding: EdgeInsets.symmetric(horizontal: 20.w),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8.r)),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                SizedBox(height: 12.h),
                Text(
                  "Price",
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                    decoration: TextDecoration.none,
                  ),
                ),
                SizedBox(height: 2.h),
                Material(
                  color: Colors.transparent,
                  child: TextField(
                    cursorColor: Colors.white,
                    controller: priceController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color(0xff485268),
                      prefixIcon: Container(
                        width: 30.w,
                        height: 30.h,
                        alignment: Alignment.center,
                        child: Text(
                          "\$",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 20.w),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.r),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                SizedBox(height: 24.h),
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 44.h,
                        child: ElevatedButton(
                          onPressed: () {
                            final updatedWish = Wish(
                              name: nameController.text,
                              price: double.tryParse(priceController.text) ?? 0,
                              purchaseDate: DateTime.now(),
                            );
                            final box = Hive.box<Wish>('wishes');
                            box.putAt(box.keys.toList().indexOf(wish.key),
                                updatedWish);

                            final eventBus = GetIt.instance<EventBus>();
                            eventBus.fire(WishUpdatedEvent(wish, updatedWish));

                            Navigator.pop(context);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xff007AFF),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                          ),
                          child: Text(
                            'Save changes',
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w400,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 8.w),
                    SizedBox(
                      height: 44.h,
                      child: ElevatedButton(
                        onPressed: () {
                          final box = Hive.box<Wish>('wishes');
                          box.delete(wish.key);

                          final eventBus = GetIt.instance<EventBus>();
                          eventBus.fire(WishDeletedEvent(wish));

                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xffFF3B30),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: 10.w,
                            horizontal: 12.w,
                          ),
                          child: SvgPicture.asset(
                            "assets/icons/delete.24.svg",
                            height: 24.h,
                            width: 24.w,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
