import 'package:event_bus/event_bus.dart';
import 'package:fitness_mastery_mission/event_bus/wish_added_event.dart';
import 'package:fitness_mastery_mission/event_bus/wish_deleted_event.dart';
import 'package:fitness_mastery_mission/event_bus/wish_updated_event.dart';
import 'package:fitness_mastery_mission/hive/wish.dart';
import 'package:fitness_mastery_mission/presentation/history/screens/history_screen.dart';
import 'package:fitness_mastery_mission/presentation/wishes/widgets/edit_wish_sheet.dart';
import 'package:fitness_mastery_mission/presentation/wishes/widgets/wish_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class WishesScreen extends StatefulWidget {
  const WishesScreen({super.key});

  @override
  State<WishesScreen> createState() => _WishesScreenState();
}

class _WishesScreenState extends State<WishesScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final List<Wish> wishes = [];
  final List<Wish> purchasedWishes = [];
  int currentBalance = 150;

  @override
  void initState() {
    super.initState();
    Hive.openBox<Wish>('wishes').then((box) {
      setState(() {
        wishes.addAll(box.values.where((wish) => wish.purchaseDate != null));
      });
    });

    final eventBus = GetIt.instance<EventBus>();
    eventBus.on<WishAddedEvent>().listen((event) {
      setState(() {
        wishes.add(event.wish);
      });
    });
    eventBus.on<WishDeletedEvent>().listen((event) {
      setState(() {
        wishes.remove(event.wish);
      });
    });

    eventBus.on<WishUpdatedEvent>().listen((event) {
      setState(() {
        final index = wishes.indexOf(event.oldWish);
        if (index != -1) {
          wishes[index] = event.updatedWish;
        }
      });
    });
  }

  @override
  void dispose() {
    nameController.dispose();
    priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff2d2d2d),
        leading: Padding(
          padding: EdgeInsets.all(16.w),
          child: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
          ),
        ),
        centerTitle: true,
        title: Text(
          'Wishes',
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
        child: Column(
          children: [
            Row(
              children: [
                Row(
                  children: [
                    SvgPicture.asset("assets/images/svgs/coins.40.svg"),
                    SizedBox(width: 8.w),
                    currentBalance == 0
                        ? Expanded(
                            child: Text(
                              "You have no coins. Complete challenges, earn coins, and reward yourself",
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                                color: Colors.white,
                              ),
                            ),
                          )
                        : Text(
                            currentBalance.toString(),
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 20.sp,
                              color: Colors.white,
                            ),
                          ),
                  ],
                ),
                const Spacer(),
                SizedBox(
                  height: 44.h,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HistoryScreen(
                            purchasedWishes: purchasedWishes,
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff007AFF),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      "History",
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 24.h),
            wishes.isEmpty
                ? Text(
                    "Your wishlist is empty. Think of something you really want and let it become your goal and motivation to work on yourself",
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                    ),
                  )
                : Flexible(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: wishes.length,
                      itemBuilder: (context, index) {
                        final wish = wishes[index];
                        return GestureDetector(
                          onTap: () {
                            showCupertinoModalBottomSheet(
                              context: context,
                              builder: (context) => EditWishSheet(
                                wish: wish,
                              ),
                            );
                          },
                          child: Padding(
                            padding: EdgeInsets.only(bottom: 12.h),
                            child: WishCard(
                              name: wish.name,
                              price: wish.price,
                              onBuy: (price) {
                                setState(() {
                                  if (currentBalance >= price) {
                                    showCupertinoDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return Theme(
                                          data: ThemeData.dark(),
                                          child: CupertinoAlertDialog(
                                            title: Text(
                                              "Purchase confirmation",
                                              style: TextStyle(
                                                fontSize: 17.sp,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.white,
                                              ),
                                            ),
                                            content: Text(
                                              "Are you sure you really want to spend coins on this wish?",
                                              style: TextStyle(
                                                fontSize: 13.sp,
                                                fontWeight: FontWeight.w400,
                                                color: Colors.white,
                                              ),
                                            ),
                                            actions: [
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: Text(
                                                  "Back",
                                                  style: TextStyle(
                                                    fontSize: 17.sp,
                                                    fontWeight: FontWeight.w400,
                                                    color:
                                                        const Color(0xff0A84FF),
                                                  ),
                                                ),
                                              ),
                                              TextButton(
                                                onPressed: () {
                                                  currentBalance -= price;
                                                  wishes.removeAt(index);

                                                  purchasedWishes.add(wish);

                                                  final box =
                                                      Hive.box<Wish>('wishes');
                                                  box.delete(wish.key);

                                                  final eventBus = GetIt
                                                      .instance<EventBus>();
                                                  eventBus.fire(
                                                      WishDeletedEvent(wish));
                                                  Navigator.pop(context);
                                                },
                                                child: Text(
                                                  "Confirm",
                                                  style: TextStyle(
                                                    fontSize: 17.sp,
                                                    fontWeight: FontWeight.w600,
                                                    color:
                                                        const Color(0xff0A84FF),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    );
                                  } else {
                                    showCupertinoDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return Theme(
                                          data: ThemeData.dark(),
                                          child: CupertinoAlertDialog(
                                            title: Text(
                                              "Not enough coins",
                                              style: TextStyle(
                                                fontSize: 17.sp,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.white,
                                              ),
                                            ),
                                            content: Text(
                                              "Not enough coins to buy the wish. Complete challenges and earn more.",
                                              style: TextStyle(
                                                fontSize: 13.sp,
                                                fontWeight: FontWeight.w400,
                                                color: Colors.white,
                                              ),
                                            ),
                                            actions: [
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: Text(
                                                  "Back",
                                                  style: TextStyle(
                                                    fontSize: 17.sp,
                                                    fontWeight: FontWeight.w400,
                                                    color:
                                                        const Color(0xff0A84FF),
                                                  ),
                                                ),
                                              ),
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: Text(
                                                  "Challenges",
                                                  style: TextStyle(
                                                    fontSize: 17.sp,
                                                    fontWeight: FontWeight.w600,
                                                    color:
                                                        const Color(0xff0A84FF),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    );
                                  }
                                });
                              },
                            ),
                          ),
                        );
                      },
                    ),
                  ),
            SizedBox(height: 10.h),
            const AddButton(),
          ],
        ),
      ),
    );
  }
}

class AddButton extends StatelessWidget {
  const AddButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showCupertinoModalBottomSheet(
          context: context,
          builder: (context) {
            return const AddWishSheet();
          },
        );
      },
      child: Container(
        height: 63.h,
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Color(0xff007AFF),
          borderRadius: BorderRadius.all(
            Radius.circular(16),
          ),
        ),
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 20.w),
              child: Text(
                "Add your wish",
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                ),
              ),
            ),
            const Spacer(),
            Container(
              width: 80.w,
              decoration: const BoxDecoration(
                color: Color(0xff007AFF),
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                ),
              ),
              child: IconButton(
                onPressed: () {
                  showCupertinoModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return const AddWishSheet();
                    },
                  );
                },
                icon: SvgPicture.asset("assets/images/svgs/add.plus.24.svg"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AddWishSheet extends StatelessWidget {
  const AddWishSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController priceController = TextEditingController();

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
            padding: EdgeInsets.symmetric(horizontal: 24.w),
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
                      hintText: 'T-shirt with goose',
                      hintStyle: const TextStyle(
                        color: Colors.white54,
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 20.w),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
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
                      hintText: '37',
                      hintStyle: TextStyle(
                        color: Colors.white54,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400,
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 20.w),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                SizedBox(height: 24.h),
                SizedBox(
                  height: 44.h,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      final newWish = Wish(
                        name: nameController.text,
                        price: int.tryParse(priceController.text) ?? 0,
                        purchaseDate: DateTime.now(),
                      );
                      final box = Hive.box<Wish>('wishes');
                      box.add(newWish);
                      final eventBus = GetIt.instance<EventBus>();
                      eventBus.fire(WishAddedEvent(newWish));
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff007AFF),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      'Add wish',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
