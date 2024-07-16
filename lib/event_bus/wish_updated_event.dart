
import 'package:fitness_mastery_mission/hive/wish.dart';

class WishUpdatedEvent {
  final Wish oldWish;
  final Wish updatedWish;

  WishUpdatedEvent(this.oldWish, this.updatedWish);
}