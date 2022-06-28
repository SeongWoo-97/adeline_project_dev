import 'dart:convert';
import 'package:adeline_app/model/notice/lobox_notice.dart';
import 'package:adeline_app/model/notice/notice.dart';
import 'package:async/async.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;


class NoticeProvider extends ChangeNotifier {
  final AsyncMemoizer _memoizer = AsyncMemoizer();
  ScrollController scrollController = ScrollController();
  List<LostArkNotice> notices = [];
  int tag = 0;
  List<String> options = ['전체', '공지', '점검'];

  fetchLostArkNotice() async {
    return this._memoizer.runOnce(() async {
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
    try {
      http.Response response = await http.get(Uri.parse('http://132.226.22.9:3381/notice'));
      Map<String, dynamic> json = jsonDecode(response.body);
      LoboxNotice notice = LoboxNotice.fromJson(json);
      return notice;
    } catch (e) {}
  }
  void noticeOnChanged(int value) {
    tag = value;
    notifyListeners();
  }


}
