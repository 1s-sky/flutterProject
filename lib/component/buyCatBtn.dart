import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:midterm/home.dart';
import 'package:midterm/model/appData.dart';
import 'package:midterm/model/catData.dart';

class BuyCatBtn extends StatefulWidget {
  const BuyCatBtn(
      {super.key,
      required this.price,
      required this.maxCount,
      required this.cat,
      required this.appBox,
      required this.catBox,
      required this.img});
  final int price;
  final int maxCount;
  final List<String> cat;
  final Box<AppData> appBox;
  final Box<CatData> catBox;
  final String img;

  @override
  State<BuyCatBtn> createState() => _BuyCatBtnState();
}

class _BuyCatBtnState extends State<BuyCatBtn> {
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

  //버튼 누르면 실행
  Future<void> _pressedBuy(int price, int maxCount, List<String> cat,
      Box<AppData> appBox, Box<CatData> catBox) async {
    return setState(() {
      int money = appBox.get('appData')!.money - price;
      int count = 0;
      bool visiability = true;

      appBox.put('appData', AppData(money: money, count: count));
      catBox.put(
          'catData',
          CatData(
              maxCount: maxCount,
              selectedImgNum: 0,
              cat: cat,
              visiability: visiability));
    });
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
                    if (widget.appBox.get('appData')!.money >= widget.price) {
                      _pressedBuy(widget.price, widget.maxCount, widget.cat,
                          widget.appBox, widget.catBox);
                      //구매에 성공하면 홈으로 이동
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Home()));
                    } else {
                      //실패하면 경고문 출력
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
                  child: const Text("구매하기")),
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
