import 'package:flutter/material.dart';
import 'package:midterm/global.dart';
import 'package:midterm/model/appData.dart';
import 'package:midterm/model/catData.dart';
import 'package:midterm/model/homeData.dart';
import 'home.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(CatDataAdapter());
  Hive.registerAdapter(AppDataAdapter());
  Hive.registerAdapter(HomeDataAdapter());

  await Hive.openBox<CatData>('catData');
  await Hive.openBox<AppData>('appData');
  await Hive.openBox<HomeData>('homeData');
  await Hive.openBox<int>('index');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Box<CatData> catBox = Hive.box('catData');
    Box<AppData> appBox = Hive.box('appData');
    Box<HomeData> homeBox = Hive.box('homeData');
    Box<int> index = Hive.box('index');

    //Hive DB에 초기값 넣어주기
    if (index.isEmpty) index.put('index', 0);
    if (catBox.isEmpty) {
      catBox.put(
          'catData',
          CatData(
              maxCount: 10, selectedImgNum: 0, cat: ocat, visiability: true));
    }
    if (appBox.isEmpty) {
      appBox.put('appData', AppData(money: 0, count: 0));
    }
    if (homeBox.isEmpty) {
      for (var hData in homePic) {
        homeBox.put(
          hData.homeNum,
          HomeData(
              homeNum: hData.homeNum,
              price: hData.price,
              isBought: hData.isBought),
        );
      }
    }

    return const MaterialApp(
      home: Home(),
    );
  }
}
