import 'package:adeline_app/model/uri_launch/launch_url.dart';
import 'package:adeline_app/screen/mobile/home_screen/widget/lostark_notice_controller/notice_controller.dart';
import 'package:chips_choice_null_safety/chips_choice_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../model/dark_mode/dark_theme_provider.dart';
import 'lostark_notice_controller/event_notice_controller.dart';
import 'package:page_view_dot_indicator/page_view_dot_indicator.dart';

class LostArkNoticeWidget extends StatefulWidget {
  @override
  State<LostArkNoticeWidget> createState() => _LostArkNoticeWidgetState();
}

class _LostArkNoticeWidgetState extends State<LostArkNoticeWidget> {
  @override
  Widget build(BuildContext context) {
    EventNoticeProvider eventNoticeProvider = Provider.of<EventNoticeProvider>(context, listen: false);
    NoticeProvider noticeProvider = Provider.of<NoticeProvider>(context, listen: false);
    return Card(
      margin: const EdgeInsets.fromLTRB(5, 0, 5, 0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(color: Colors.grey, width: .5),
      ),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Consumer<NoticeProvider>(
                builder: (context, instance, child) {
                  return ChipsChoice<int>.single(
                    padding: EdgeInsets.only(left: 5),
                    value: instance.tag,
                    onChanged: (val) => instance.noticeOnChanged(val),
                    choiceItems: C2Choice.listFrom<int, String>(
                      source: instance.options,
                      value: (i, v) => i,
                      label: (i, v) => v,
                    ),
                    choiceStyle: C2ChoiceStyle(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      labelPadding: const EdgeInsets.all(0),
                      margin: const EdgeInsets.all(0),
                      showCheckmark: false,
                      color: DarkMode.isDarkMode.value ? Colors.white70 : Colors.black,
                      backgroundColor: DarkMode.isDarkMode.value ? Color(0xFF212121) : Colors.white,
                      borderColor: DarkMode.isDarkMode.value ? Color(0xFF212121) : Colors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    choiceActiveStyle: C2ChoiceStyle(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      labelPadding: const EdgeInsets.all(0),
                      margin: const EdgeInsets.all(0),
                      color: DarkMode.isDarkMode.value ? Colors.white : Colors.black,
                      backgroundColor: DarkMode.isDarkMode.value ? Color(0xFF212121) : Colors.white,
                      borderColor: DarkMode.isDarkMode.value ? Color(0xFF212121) : Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      showCheckmark: false,
                    ),
                  );
                },
              ),
              Consumer<NoticeProvider>(
                builder: (context, instance, child) {
                  return Container(
                    height: 130,
                    width: MediaQuery.of(context).size.width - 20,
                    child: FutureBuilder(
                      future: noticeProvider.fetchLostArkNotice(),
                      builder: (context,snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return FittedBox(
                            fit: BoxFit.scaleDown,
                            child: CircularProgressIndicator(
                              color: DarkMode.isDarkMode.value ? Colors.grey : Colors.blue,
                            ),
                          );
                        } else if (snapshot.connectionState == ConnectionState.done) {
                          return RawScrollbar(
                            isAlwaysShown: true,
                            controller: noticeProvider.scrollController,
                            radius: Radius.circular(20),
                            thumbColor: DarkMode.isDarkMode.value ? Colors.grey : Colors.grey,
                            thickness: 4,
                            child: ListView.builder(
                              itemCount: noticeProvider.notices.length,
                              controller: noticeProvider.scrollController,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                if (noticeProvider.options[noticeProvider.tag] == "공지" &&
                                    noticeProvider.notices[index].category == "공지") {
                                  return InkWell(
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(15, 0, 5, 10),
                                      child: Container(
                                        child: Text(
                                          "[${noticeProvider.notices[index].category}] ${noticeProvider.notices[index].title}",
                                          overflow: TextOverflow.ellipsis,
                                          style: Theme.of(context).textTheme.bodyText2?.copyWith(fontSize: 15),
                                        ),
                                      ),
                                    ),
                                    onTap: () {
                                      LaunchUrl.launchURL("https://lostark.game.onstove.com" + noticeProvider.notices[index].url);
                                    },
                                  );
                                } else if (noticeProvider.options[noticeProvider.tag] == "점검" &&
                                    noticeProvider.notices[index].category == "점검") {
                                  return InkWell(
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(15, 0, 5, 10),
                                      child: Container(
                                        child: Text(
                                          "[${noticeProvider.notices[index].category}] ${noticeProvider.notices[index].title}",
                                          overflow: TextOverflow.ellipsis,
                                          style: Theme.of(context).textTheme.bodyText2?.copyWith(fontSize: 15),
                                        ),
                                      ),
                                    ),
                                    onTap: () {
                                      LaunchUrl.launchURL("https://lostark.game.onstove.com" + noticeProvider.notices[index].url);
                                    },
                                  );
                                } else if (noticeProvider.options[noticeProvider.tag] == "전체") {
                                  return InkWell(
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(15, 0, 5, 10),
                                      child: Container(
                                        child: Text(
                                          "[${noticeProvider.notices[index].category}] ${noticeProvider.notices[index].title}",
                                          overflow: TextOverflow.ellipsis,
                                          style: Theme.of(context).textTheme.bodyText2?.copyWith(fontSize: 15),
                                        ),
                                      ),
                                    ),
                                    onTap: () {
                                      LaunchUrl.launchURL("https://lostark.game.onstove.com" + noticeProvider.notices[index].url);
                                    },
                                  );
                                }
                                return Container();
                              },
                            ),
                          );
                        } else {
                          return Text('로스트아크 서버가 점검중입니다.');
                        }
                      },
                    ),
                  );
                },
              ),
              Container(
                height: 100,
                width: MediaQuery.of(context).size.width - 10,
                child: FutureBuilder(
                  future: eventNoticeProvider.fetchLostArkEventNotice(),
                  builder: (context, AsyncSnapshot snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return FittedBox(
                        fit: BoxFit.scaleDown,
                        child: CircularProgressIndicator(
                          color: DarkMode.isDarkMode.value ? Colors.grey : Colors.blue,
                        ),
                      );
                    } else if (snapshot.connectionState == ConnectionState.done) {
                      if(snapshot.data?.length == 0) {
                        return Center(child: Text('로스트아크 서버가 점검중입니다.'));
                      }
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(15, 0, 15, 10),
                        child: PageView.builder(
                          controller: eventNoticeProvider.pageController,
                          itemCount: snapshot.data?.length,
                          itemBuilder: (context, index) {
                            if(snapshot.hasData) {
                              return snapshot.data![index];
                            } else {
                              return Container(child: Text('비어있음'),);
                            }
                          },
                          onPageChanged: (value) {
                            eventNoticeProvider.onPageChange(value);
                          },
                        ),
                      );
                    } else {
                      return Text('로스트아크 서버가 점검중입니다.');
                    }
                  },
                ),
              ),
              Consumer<EventNoticeProvider>(
                builder: (context, instance, child) {
                  return Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    width: MediaQuery.of(context).size.width - 10,
                    child: PageViewDotIndicator(
                      currentItem: instance.currentIndex,
                      count: instance.dotCount,
                      unselectedColor: Colors.grey[700]!,
                      selectedColor: Colors.white,
                      size: Size(8, 8),
                      unselectedSize: Size(8, 8),
                    ),
                  );
                },
              )
            ],
          ),
        ],
      ),
    );
  }
}
