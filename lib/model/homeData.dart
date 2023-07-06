import 'package:hive_flutter/hive_flutter.dart';
part 'homeData.g.dart';

@HiveType(typeId: 3)
class HomeData {
  @HiveField(0)
  int homeNum;
  @HiveField(1)
  int price;
  @HiveField(2)
  bool isBought;
  @HiveField(3)
  HomeData({
    required this.homeNum,
    required this.price,
    required this.isBought,
  });

  // int getHomeNum() {
  //   return homeNum;
  // }

  // int getPrice() {
  //   return price;
  // }

  // bool getIsBought() {
  //   return isBought;
  // }

  // void setHomeNum(int homeNum) {
  //   this.homeNum = homeNum;
  // }

  // void setPrice(int price) {
  //   this.price = price;
  // }

  // void setIsBought(bool isBought) {
  //   this.isBought = isBought;
  //}
}
