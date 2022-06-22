import 'package:adeline_app/model/uri_launch/launch_url.dart';
import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:web_scraper/web_scraper.dart';

import '../../../../../model/notice/event_notice.dart';

class EventNoticeProvider extends ChangeNotifier {
  PageController pageController = PageController();
  final AsyncMemoizer _asyncMemoizer = AsyncMemoizer();

  List<LostArkEventNotice> eventList = [];
  int currentIndex = 0;
  int dotCount = 1;

  fetchLostArkEventNotice() async {
    return _asyncMemoizer.runOnce(() async {
      final webScraper = WebScraper('https://lostark.game.onstove.com');
      List<dynamic> thumbImageList = [];
      List<dynamic> titleList = [];
      List<dynamic> eventDateTime = [];
      List<dynamic> statusList = [];
      List<dynamic> linkList = [];

      if (await webScraper.loadWebPage('/News/Event/Now?page=1&searchtype=0&searchtext=')) {
        thumbImageList = webScraper.getElementAttribute('div.list.list--event > ul > li > a > div.list__thumb > img', 'src');
        titleList = webScraper.getElementTitle('div.list.list--event > ul > li > a > div.list__subject > span.list__title');
        eventDateTime = webScraper.getElementTitle('div.list.list--event > ul > li > a > div.list__term');
        statusList =
            webScraper.getElementTitle('div.list.list--event > ul > li > a > div.list__status > span.list__status--ongoing');
        linkList = webScraper.getElementAttribute('div.list.list--event > ul > li > a', 'href');
      }
      if (await webScraper.loadWebPage('/News/Event/Now?page=2&searchtype=0&searchtext=')) {
        thumbImageList = List.from(thumbImageList)
          ..addAll(webScraper.getElementAttribute('div.list.list--event > ul > li > a > div.list__thumb > img', 'src'));
        titleList = List.from(titleList)
          ..addAll(webScraper.getElementTitle('div.list.list--event > ul > li > a > div.list__subject > span.list__title'));
        eventDateTime = List.from(eventDateTime)
          ..addAll(webScraper.getElementTitle('div.list.list--event > ul > li > a > div.list__term'));
        statusList = List.from(statusList)
          ..addAll(
              webScraper.getElementTitle('div.list.list--event > ul > li > a > div.list__status > span.list__status--ongoing'));
        linkList = List.from(linkList)..addAll(webScraper.getElementAttribute('div.list.list--event > ul > li > a', 'href'));
      }
      eventList = List.generate(
        titleList.length,
        (index) => LostArkEventNotice(
          thumbImageList[index],
          titleList[index],
          eventDateTime[index],
          statusList[index],
          linkList[index],
        ),
      );
      List<Widget> pageList = List.generate((eventList.length / 2).ceil(), (index) {
        // if((index * 2) + 1 >) 끝에 두 숫자가 eventList 의 개수와 같게되면? 으로 할까?
        if((index * 2) + 1 == eventList.length){
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Flexible(
                child: InkWell(
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Color(0xFF212121)),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(7),
                      child: Image.network(thumbImageList[index * 2]),
                    ),
                  ),
                  onTap: () {
                    LaunchUrl.launchURL('https://lostark.game.onstove.com' + linkList[index * 2]);
                  },
                ),
              ),
              Flexible(child: Container())
            ],
          );
        }
        if (titleList[index * 2] != null && titleList[(index * 2) + 1] != null) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Flexible(
                child: InkWell(
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Color(0xFF212121)),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(7),
                      child: Image.network(thumbImageList[index * 2]),
                    ),
                  ),
                  onTap: () {
                    LaunchUrl.launchURL('https://lostark.game.onstove.com' + linkList[index * 2]);
                  },
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Flexible(
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Color(0xFF212121)),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(7),
                    child: InkWell(
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(8), child: Image.network(thumbImageList[(index * 2) + 1])),
                      onTap: () {
                        LaunchUrl.launchURL('https://lostark.game.onstove.com' + linkList[(index * 2) + 1]);
                      },
                    ),
                  ),
                ),
              )
            ],
          );
        }
        return Container(
          child: Text('서버점검중!'),
        );
      });

      dotCount = (eventList.length / 2).ceil();
      notifyListeners();
      return pageList;
    });
  }

  void onPageChange(int value) {
    currentIndex = value;
    notifyListeners();
  }
}
