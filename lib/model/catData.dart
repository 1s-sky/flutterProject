import 'package:hive/hive.dart';

part 'catData.g.dart';

@HiveType(typeId: 1)
class CatData {
  @HiveField(0)
  int maxCount;
  @HiveField(1)
  int selectedImgNum;
  @HiveField(2)
  List<String> cat;
  @HiveField(3)
  bool visiability;

  CatData({
    required this.maxCount,
    required this.selectedImgNum,
    required this.cat,
    required this.visiability,
  });

  // int getMaxCount() {
  //   return maxCount;
  // }

  // int getSelectedImgNum() {
  //   return selectedImgNum;
  // }

  // List<String> getCat() {
  //   return cat;
  // }

  // void setMaxCount(int maxCount) {
  //   this.maxCount = maxCount;
  // }

  // void setSelectedImgNum(int selectedImgNum) {
  //   this.selectedImgNum = selectedImgNum;
  // }

  // void setCat(List<String> cat) {
  //   this.cat = [...cat];
  // }
}
