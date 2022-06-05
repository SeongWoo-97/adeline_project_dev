import 'package:async/async.dart';
import 'package:flutter/cupertino.dart';
import 'package:web_scraper/web_scraper.dart';

import '../../../../../model/notice/notice.dart';

class NoticeProvider extends ChangeNotifier {
  final AsyncMemoizer _memoizer = AsyncMemoizer();
  ScrollController scrollController = ScrollController();
  List<LostArkNotice> notices = [];
  int tag = 0;
  List<String> options = ['전체', '공지', '점검'];

  fetchLostArkNotice() async {
    return this._memoizer.runOnce(() async {
      final webScraper = WebScraper('https://lostark.game.onstove.com');
      if (await webScraper.loadWebPage('/News/Notice/List')) {
        List<dynamic> linkList = webScraper.getElementAttribute('div.list.list--default > ul > li > a', 'href');
        List<dynamic> titleList =
            webScraper.getElementTitle('div.list.list--default > ul > li > a > div.list__subject > span.list__title');
        List<dynamic> categoryList =
            webScraper.getElementTitle('div.list.list--default > ul > li > a > div.list__category > span');

        return notices = List.generate(
            titleList.length - 4, (index) => LostArkNotice(titleList[index + 4], categoryList[index + 4], linkList[index + 4]));
      }
      return notices;
    });
  }

  void noticeOnChanged(int value) {
    tag = value;
    notifyListeners();
  }
}
