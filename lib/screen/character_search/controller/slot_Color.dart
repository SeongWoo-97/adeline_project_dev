import 'package:flutter/material.dart';

class slotColor {
  static List<Color> gradeColors(int? grade) {
    List<Color> list = [];
    if (grade != null) {
      switch (grade) {
        case 1:
          list.add(Colors.white);
          break;
        case 2: // 희귀
          list.add(Color.fromRGBO(17, 31, 44, 1));
          list.add(Color.fromRGBO(17, 61, 93, 1));
          break;
        case 3: // 영웅
          list.add(Color.fromRGBO(38, 19, 49, 1));
          list.add(Color.fromRGBO(72, 13, 93, 1));
          break;
        case 4: // 전설
          list.add(Color.fromRGBO(54, 32, 3, 1));
          list.add(Color.fromRGBO(158, 95, 4, .9));
          break;
        case 5: // 유물
          list.add(Color.fromRGBO(52, 26, 9, 1));
          list.add(Color.fromRGBO(162, 64, 6, 1));
          break;
        case 6: // 고대
          list.add(Color.fromRGBO(61, 51, 37, 1));
          list.add(Color.fromRGBO(220, 201, 153, 1));
          break;
        case 7: // 에스더
          list.add(Color.fromRGBO(12, 46, 44, .6));
          list.add(Color.fromRGBO(47, 171, 168, 1));
          break;
        default:
          list.add(Colors.white);
          break;
      }
    }
    return list;
  }

  static Color itemNameColor(int? grade) {
    Color color = Colors.grey;
    if (grade != null) {
      switch (grade) {
        case 1: // 고급
          break;
        case 2: // 희귀
          color = Color(0xFF00B0FA);
          break;
        case 3: // 영웅
          color = Color(0xFFce43fc);
          break;
        case 4: // 전설
          color = Color(0xFFF99200);
          break;
        case 5: // 유물
          color = Color(0xFFFA5D00);
          break;
        case 6: // 고대
          color = Color(0xFFE3C7A1);
          break;
        case 7: // 에스더
          color = Color(0xFF3CF2E6);
          break;
        default:
          break;
      }
    }
    return color;
  }

  static Color qualityColor(int? quality) {
    Color color = Colors.greenAccent;
    if (quality != null) {
      if (quality >= 0 && quality <= 9) {
        color = Color.fromRGBO(255, 96, 0, 1);
      }
      if (quality >= 10 && quality <= 29) {
        color = Color.fromRGBO(255, 210, 0, 1);
      }
      if (quality >= 30 && quality <= 69) {
        color = Color.fromRGBO(145, 254, 2, 1);
      }
      if (quality >= 70 && quality <= 89) {
        color = Color.fromRGBO(0, 181, 255, 1);
      }
      if (quality >= 90 && quality <= 99) {
        color = Color.fromRGBO(206, 67, 252, 1);
      }
      if (quality == 100) {
        color = Color.fromRGBO(254, 150, 0, 1);
      }
    }
    return color;
  }
  static Color cardNameColor(int? grade) {
    Color color = Colors.white;
    if (grade != null) {
      switch (grade) {
        case 1: // 고급
          color = Color(0xFFFFFFFF);
          break;
        case 2: // 희귀
          color = Color(0xFF8DF901);
          break;
        case 3: // 영웅
          color = Color(0xFF00B0FA);
          break;
        case 4: // 전설
          color = Color(0xFFce43fc);
          break;
        case 5: // 유물
          color = Color(0xFFF99200);
          break;
        case 6: // 고대
          color = Color(0xFFE3C7A1);
          break;
        case 7: // 에스더
          color = Color(0xFF3CF2E6);
          break;
        default:
          break;
      }
    }
    return color;
  }
}