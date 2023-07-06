import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:midterm/model/appData.dart';
import 'package:midterm/model/catData.dart';
import 'package:midterm/component/catPic.dart';
import 'package:midterm/model/homeData.dart';
import 'package:midterm/shopPage.dart';
import 'package:midterm/top.dart';
import 'global.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future<void> _pressed(int i) async {
    return setState(() {
      Box<CatData> catBox = Hive.box('catData');
      var catData = catBox.get('catData');
      Box<AppData> appBox = Hive.box('appData');
      var appData = appBox.get('appData');

      int money = appData!.money;
      int count = appData.count;

      money = appData.money + 1;
      count = appData.count + 1;

      appBox.put('appData', AppData(money: money, count: count));

      int selectedImgNum = i;
      bool visiability = true;
      appData = appBox.get('appData');
      if (appData!.count >= catData!.maxCount) {
        selectedImgNum = 4;
        money = appData.money + catData.maxCount;
        appBox.put('appData', AppData(money: money, count: count));
        visiability = false;
      }

      catBox.put(
          'catData',
          CatData(
              maxCount: catData.maxCount,
              selectedImgNum: selectedImgNum,
              cat: catData.cat,
              visiability: visiability));
    });
  }

  Widget displayCat(CatData catData) {
    return Image.asset(catData.cat[catData.selectedImgNum],
        width: 280, height: 280);
  }

  @override
  Widget build(BuildContext context) {
    Box<CatData> catBox = Hive.box('catData');
    Box<AppData> appBox = Hive.box('appData');
    Box<int> index = Hive.box('index');
    var catData = catBox.get('catData');
    var appData = appBox.get('appData');

    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            //Status Bar
            const SizedBox(
              height: 24,
            ),

            //Top
            Top(appData: appData!),

            //body
            Expanded(
              child: Stack(
                children: [
                  //집
                  Positioned(
                    left: -185,
                    top: -50,
                    child: Image.asset('assets/home${index.get('index')!}.png',
                        height: 450),
                  ),
                  //고양이
                  if (catData != null)
                    CatPic(
                        maxCount: catData.maxCount,
                        selectedImgNum: catData.selectedImgNum,
                        cat: catData.cat),
                  //버튼들
                  Positioned(
                    left: 35,
                    top: 340,
                    child: Visibility(
                      visible: catData!.visiability,
                      child: Row(
                        children: [
                          ElevatedButton(
                              onPressed: () => _pressed(1),
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.amber[700],
                                backgroundColor: Colors.black,
                                shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(50))),
                                elevation: 5,
                                fixedSize: const Size(80, 40),
                              ),
                              child: const Text("밥먹자!")),
                          const SizedBox(
                            width: 10,
                          ),
                          ElevatedButton(
                              onPressed: () => _pressed(2),
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.white,
                                backgroundColor: Colors.amber[700],
                                shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
                                elevation: 5,
                                fixedSize: const Size(80, 40),
                              ),
                              child: const Text("손!")),
                          const SizedBox(
                            width: 10,
                          ),
                          ElevatedButton(
                              onPressed: () => _pressed(3),
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.amber[700],
                                backgroundColor: Colors.black,
                                shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
                                elevation: 5,
                                fixedSize: const Size(80, 40),
                              ),
                              child: const Text("엎드려!")),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            //bottom
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              height: 60,
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 183, 109, 33),
                border: Border(
                  top: BorderSide(color: Colors.black, width: 2.5),
                ),
              ),
              child: IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ShopPage()));
                  },
                  icon: const Icon(Icons.shopping_bag)),
            ),
          ],
        ));
  }
}
