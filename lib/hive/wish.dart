import 'package:hive/hive.dart';

part 'wish.g.dart';

@HiveType(typeId: 0)
class Wish extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  int price;

  @HiveField(2)
  DateTime? purchaseDate; 

  Wish({
    required this.name,
    required this.price,
    this.purchaseDate, 
  });
}
