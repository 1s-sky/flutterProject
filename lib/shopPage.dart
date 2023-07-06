import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:midterm/component/buyCatBtn.dart';
import 'package:midterm/component/buyHomeBtn.dart';
import 'package:midterm/model/appData.dart';
import 'package:midterm/model/catData.dart';
import 'package:midterm/global.dart';
import 'package:midterm/home.dart';
import 'package:midterm/model/homeData.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({Key? key}) : super(key: key);

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> with TickerProviderStateMixin {
  late TabController tabController;
  @override
  void initState() {
    tabController = TabController(
      length: 2,
      vsync: this,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //필요한 데이터 꺼내기
    Box<CatData> catBox = Hive.box('catData');
    Box<AppData> appBox = Hive.box('appData');
    Box<HomeData> homeBox = Hive.box('homeData');
    Box<int> homeIndex = Hive.box('index');
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '구매하기',
        ),
        leading: IconButton(
            onPressed: () {
              //뒤로가기
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Home()));
            },
            icon: const Icon(Icons.arrow_back)),
      ),
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(),
            ),
            //탭으로 종류 바꾸기
            child: TabBar(
              tabs: [
                //고양이 구매 탭
                Container(
                  height: 40,
                  alignment: Alignment.center,
                  child: const Text(
                    '고양이',
                  ),
                ),
                //집 구매 탭
                Container(
                  height: 40,
                  alignment: Alignment.center,
                  child: const Text(
                    '집',
                  ),
                ),
              ],
              labelColor: Colors.black,
              controller: tabController,
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: tabController,
              children: [
                Container(
                  alignment: Alignment.bottomLeft,
                  padding: const EdgeInsets.fromLTRB(15, 20, 15, 20),
                  child: SingleChildScrollView(
                      child: Column(
                    children: [
                      //얼룩냥이
                      BuyCatBtn(
                          price: 0,
                          maxCount: 10,
                          cat: ocat,
                          appBox: appBox,
                          catBox: catBox,
                          img: 'assets/origin/cat0.png'),
                      //흰냥이
                      BuyCatBtn(
                          price: 20,
                          maxCount: 20,
                          cat: wcat,
                          appBox: appBox,
                          catBox: catBox,
                          img: 'assets/white/wcat0.png'),
                      //회색냥이
                      BuyCatBtn(
                          price: 30,
                          maxCount: 30,
                          cat: gcat,
                          appBox: appBox,
                          catBox: catBox,
                          img: 'assets/grey/gcat0.png'),
                    ],
                  )),
                ),
                //집
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.fromLTRB(15, 20, 15, 20),
                  child: SingleChildScrollView(
                      child: Column(
                    children: [
                      BuyHomeBtn(
                        homeNum: 0,
                        price: 0,
                        appBox: appBox,
                        homeBox: homeBox,
                        homeIndex: homeIndex,
                        img: 'assets/home0.png',
                      ),
                      BuyHomeBtn(
                        homeNum: 1,
                        price: 50,
                        appBox: appBox,
                        homeBox: homeBox,
                        homeIndex: homeIndex,
                        img: 'assets/home1.png',
                      ),
                      BuyHomeBtn(
                        homeNum: 2,
                        price: 100,
                        appBox: appBox,
                        homeBox: homeBox,
                        homeIndex: homeIndex,
                        img: 'assets/home2.png',
                      ),
                    ],
                  )),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
