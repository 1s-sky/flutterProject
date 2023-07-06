import 'package:flutter/material.dart';

class CatPic extends StatelessWidget {
  Widget displayCat() {
    return Image.asset(cat[selectedImgNum], width: 280, height: 280);
  }

  final int maxCount;
  final int selectedImgNum;
  final List<String> cat;

  CatPic({
    required this.maxCount,
    required this.selectedImgNum,
    required this.cat,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 15,
      top: 100,
      child:
          displayCat(), //Image.asset(catData.getImg(),width: 280, height: 280),
    );
  }
}
