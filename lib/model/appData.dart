import 'package:hive_flutter/hive_flutter.dart';

part 'appData.g.dart';

@HiveType(typeId: 2)
class AppData {
  @HiveField(0)
  int money;
  @HiveField(1)
  int count;

  AppData({
    required this.money,
    required this.count,
  });
}
