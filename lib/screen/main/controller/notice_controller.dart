import 'dart:convert';

import 'package:adeline_app/model/crystal_price/crystal_price.dart';
import 'package:adeline_app/model/notice/adventure_island.dart';
import 'package:adeline_app/model/notice/lobox_notice.dart';
import 'package:adeline_app/model/notice/notice.dart';
import 'package:async/async.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class NoticeProvider extends ChangeNotifier {
  final AsyncMemoizer _memoizer1 = AsyncMemoizer();
  final AsyncMemoizer _memoizer2 = AsyncMemoizer();
  final AsyncMemoizer<CrystalPrice> _memoizer3 = AsyncMemoizer();
  final AsyncMemoizer _memoizer4 = AsyncMemoizer();
  Future<AdventureIsland?>? adventureIsland;
  Future? lostArkNotice;
  Future<CrystalPrice>? crystalPrice;

  ScrollController scrollController = ScrollController();
  List<LostArkNotice> notices = [];
  int tag = 0;
  List<String> options = ['전체', '공지', '점검'];

  fetchLostArkNotice() async {
    return this._memoizer1.runOnce(() async {
      try {
        http.Response response = await http.get(Uri.parse('http://132.226.22.9:3381/lobox/notice'));
        List<dynamic> json = jsonDecode(response.body);
        json.forEach((element) => notices.add(LostArkNotice.fromJson(element)));
        return notices;
      } catch (e) {
        print('오류(NoticeProvider) : $e');
      }
    });
  }

  Future<dynamic> fetchLoboxNotice() async {
    return this._memoizer2.runOnce(() async {
      try {
        http.Response response = await http.get(Uri.parse('http://132.226.22.9:3381/notice'));
        Map<String, dynamic> json = jsonDecode(response.body);
        LoboxNotice notice = LoboxNotice.fromJson(json);
        return notice;
      } catch (e) {}
    });
  }

  Future<CrystalPrice> fetchCrystalMarketPrice() async {
    http.Response response = await http.get(Uri.parse('http://152.70.248.4:5000/crystal/'));
    Map<String, dynamic> json = jsonDecode(response.body);
    CrystalPrice crystalPrice = CrystalPrice.fromJson(json);
    print('fetchCrystalMarketPrice: 크리스탈 가격 : ${crystalPrice.sell}, ${crystalPrice.buy}');
    return crystalPrice;
  }

  Future<AdventureIsland?> fetchAdventureIsland() async {
    try {
      http.Response response = await http.get(Uri.parse('http://152.70.248.4:5000/adventureisland/'));
      Map<String, dynamic> json = jsonDecode(utf8.decode(response.bodyBytes));
      print(json);
      AdventureIsland adventureIsland = AdventureIsland.fromJson(json);
      return adventureIsland;
    } catch (e) {}
    return null;
  }

  void noticeOnChanged(int value) {
    tag = value;
    notifyListeners();
  }
}
