import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:midterm/home.dart';
import 'package:midterm/model/appData.dart';
import 'package:midterm/model/homeData.dart';

class BuyHomeBtn extends StatefulWidget {
  const BuyHomeBtn(
      {super.key,
      required this.homeNum,
      required this.price,
      required this.appBox,
      required this.homeBox,
      required this.img,
      required this.homeIndex});
  final int price;
  final int homeNum;
  final Box<AppData> appBox;
  final Box<HomeData> homeBox;
  final Box<int> homeIndex;
  final String img;

  @override
  State<BuyHomeBtn> createState() => _BuyHomeBtnState();
}

class _BuyHomeBtnState extends State<BuyHomeBtn> {
  //금액이 모자라면 경고문 출력
  void flutterDialog(int price) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            title: const Column(
              children: <Widget>[
                Text("금액이 부족합니다."),
              ],
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  '${widget.price}원을 모아주세요',
                ),
              ],
            ),
            actions: <Widget>[
              TextButton(
                child: const Text("확인"),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }

  Future<void> _pressedHome(int homeNum, int price, Box<AppData> appBox,
      Box<HomeData> homeBox, Box<int> homeIndex) async {
    return setState(() {
      if (!(homeBox.getAt(homeNum)!.isBought)) {
        //구매이력이 없으면
        int money = appBox.get('appData')!.money - price;
        bool isBought = true;
        appBox.put('appData',
            AppData(money: money, count: appBox.get('appData')!.count));
        homeBox.putAt(homeNum,
            HomeData(homeNum: homeNum, price: price, isBought: isBought));
      }
      //index 변경
      homeIndex.put('index', homeNum);
    });
  }

  Widget printText(int homeNum, Box<HomeData> homeBox) {
    if (homeBox.getAt(homeNum)!.isBought) {
      return const Text('적용하기');
    } else {
      return const Text('구매하기');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //미리보기 이미지
            Image.asset(widget.img, height: 100),
            Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              //가격
              Text('${widget.price}\$'),
              const SizedBox(
                height: 6,
              ),
              //구매하기 버튼
              ElevatedButton(
                  onPressed: () {
                    //구매이력 있음
                    if (widget.homeBox.getAt(widget.homeNum)!.isBought) {
                      widget.homeIndex.put('index', widget.homeNum);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Home()));
                    }
                    //구매이력 없음&돈 있음
                    else if (widget.appBox.get('appData')!.money >=
                        widget.price) {
                      _pressedHome(widget.homeNum, widget.price, widget.appBox,
                          widget.homeBox, widget.homeIndex);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Home()));
                    }
                    //구매이력 없음&돈 없음
                    else {
                      flutterDialog(10);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.amber[700],
                    backgroundColor: Colors.black,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(50))),
                    elevation: 5,
                    fixedSize: const Size(100, 40),
                  ),
                  child: printText(widget.homeNum, widget.homeBox)),
            ]),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        const Divider(thickness: 1, height: 1, color: Colors.black38),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
