import 'dart:convert';

import 'package:adeline_app/model/notice/event_notice.dart';
import 'package:adeline_app/model/uri_launch/launch_url.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class EventNoticeProvider extends ChangeNotifier {
  PageController pageController = PageController();
  Future<List<Widget>>? mobileLostArkEventNotice;
  Future<List<Widget>>? lostArkEventNotice;
  List<LostArkEventNotice?> eventList = [];
  int currentIndex = 0;
  int dotCount = 1;

  // return Mobile Event Widget
  Future<List<Widget>>? fetchLostArkEventNotice() async {
    http.Response response = await http.get(Uri.parse('http://132.226.22.9:3381/lobox/event'));
      List<dynamic> json = jsonDecode(response.body);
      json.forEach((element) => eventList.add(LostArkEventNotice.fromJson(element)));

      List<Widget> pageList = List.generate((eventList.length / 2).ceil(), (index) {
        if ((index * 2) + 1 == eventList.length) {
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
                      child: Image.network(eventList[index * 2]!.thumbImage),
                    ),
                  ),
                  onTap: () {
                    LaunchUrl.launchURL(eventList[index * 2]!.url);
                  },
                ),
              ),
              Flexible(child: Container())
            ],
          );
        }
        if (eventList[index * 2] != null && eventList[(index * 2) + 1] != null) {
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
                      child: Image.network(eventList[index * 2]!.thumbImage),
                    ),
                  ),
                  onTap: () {
                    LaunchUrl.launchURL(eventList[index * 2]!.url);
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
                          borderRadius: BorderRadius.circular(8), child: Image.network(eventList[(index * 2) + 1]!.thumbImage)),
                      onTap: () {
                        LaunchUrl.launchURL(eventList[(index * 2) + 1]!.url);
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
  }

  // return Desktop, Tablet Event Widget
  Future<List<Widget>>? fetchRwdLostArkEventNotice() async {
    http.Response response = await http.get(Uri.parse('http://132.226.22.9:3381/lobox/event'));
    List<dynamic> json = jsonDecode(response.body);
    List<LostArkEventNotice> list = [];
    List<Widget> eventWidgetList = [];
    // 이벤트 인스턴스 생성
    json.forEach((element) => list.add(LostArkEventNotice.fromJson(element)));
    // 생성한 인스턴스로 위젯 생성
    list.forEach((element) {
      eventWidgetList.add(InkWell(
        child: Container(
          height: 95,
          padding: const EdgeInsets.only(right: 10,bottom: 5),
          decoration: BoxDecoration(
            border: Border.all(color: Color(0xFF212121)),
            borderRadius: BorderRadius.circular(8),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(7),
            child: Image.network(element.thumbImage,fit: BoxFit.contain,),
          ),
        ),
        onTap: () {
          LaunchUrl.launchURL(element.url);
        },
      ));
    });
    return eventWidgetList;
  }

  void onPageChange(int value) {
    currentIndex = value;
    notifyListeners();
  }
}
