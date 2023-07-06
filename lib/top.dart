import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:midterm/model/appData.dart';

class Top extends StatefulWidget {
  const Top({Key? key, required this.appData}) : super(key: key);
  final AppData appData;

  @override
  State<Top> createState() => _TopState();
}

class _TopState extends State<Top> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset('assets/title.png'),
          Row(
            children: [
              Text("${widget.appData.money}"),
              const SizedBox(
                width: 5,
              ),
              Image.asset('assets/coin.png', width: 20, height: 20),
            ],
          ),
        ],
      ),
    );
  }
}
