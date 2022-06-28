import 'package:adeline_app/model/uri_launch/launch_url.dart';
import 'package:adeline_app/screen/mobile/home_screen/widget/notice_controller/event_notice_controller.dart';
import 'package:adeline_app/screen/mobile/home_screen/widget/notice_controller/notice_controller.dart';
import 'package:adeline_app/screen/responsive/bottom_navigation/widget/drawer_widget.dart';
import 'package:chips_choice_null_safety/chips_choice_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:page_view_dot_indicator/page_view_dot_indicator.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class RwdBottomNavigationScreen extends StatefulWidget {
  const RwdBottomNavigationScreen({Key? key}) : super(key: key);

  @override
  State<RwdBottomNavigationScreen> createState() => _RwdBottomNavigationScreenState();
}

class _RwdBottomNavigationScreenState extends State<RwdBottomNavigationScreen> {
  @override
  Widget build(BuildContext context) {
    EventNoticeProvider eventNoticeProvider =
        Provider.of<EventNoticeProvider>(context, listen: false);
    NoticeProvider noticeProvider = Provider.of<NoticeProvider>(context, listen: false);
    TextStyle? bodyText = Theme.of(context).textTheme.bodyText2?.copyWith(fontSize: 12.5.sp);
    return Scaffold(
      body: Row(
        children: [
          Container(
            child: RwdDrawerWidget(),
          ),
          Expanded(
              flex: 6,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // 캐릭터 검색바
                  Container(
                    margin: const EdgeInsets.only(top: 15),
                    width: 30.w,
                    height: 40,
                    child: TextFormField(
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(hintText: '캐릭터 검색'),
                    ),
                  ),
                  // 크리스탈 가격
                  Padding(
                    padding: const EdgeInsets.fromLTRB(5, 10, 5, 10),
                    child: Row(
                      children: [
                        Flexible(
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(5, 7, 10, 7),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(3, 0, 0, 0),
                                        child: Text('크리스탈 구매 ', style: bodyText),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                      padding: const EdgeInsets.fromLTRB(7, 0, 0, 0),
                                      child: Text(
                                          '${NumberFormat('###,###').format(int.parse('2405'))} G',
                                          style: bodyText)),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Flexible(
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(5, 7, 10, 7),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(3, 0, 0, 0),
                                        child: Text('크리스탈 판매 ', style: bodyText),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                      padding: const EdgeInsets.fromLTRB(7, 0, 0, 0),
                                      child: Text(
                                          '${NumberFormat('###,###').format(int.parse('2415'))} G',
                                          style: bodyText)),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // 공지사항
                  Padding(
                    padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                    child: Card(
                      margin: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 40,
                            child: Consumer<NoticeProvider>(
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
                                    color: Colors.white70,
                                    backgroundColor: Color(0xFF212121),
                                    borderColor: Color(0xFF212121),
                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                  ),
                                  choiceActiveStyle: C2ChoiceStyle(
                                    padding: const EdgeInsets.only(left: 10, right: 10),
                                    labelPadding: const EdgeInsets.all(0),
                                    margin: const EdgeInsets.all(0),
                                    color: Colors.white,
                                    backgroundColor: Color(0xFF212121),
                                    borderColor: Color(0xFF212121),
                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                    showCheckmark: false,
                                  ),
                                );
                              },
                            ),
                          ),
                          Consumer<NoticeProvider>(
                            builder: (context, instance, child) {
                              return Container(
                                height: 130,
                                width: 100.w,
                                child: FutureBuilder(
                                  future: noticeProvider.fetchLostArkNotice(),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData == true) {
                                      if (snapshot.connectionState == ConnectionState.waiting) {
                                        return FittedBox(
                                          fit: BoxFit.scaleDown,
                                          child: CircularProgressIndicator(
                                            color: Colors.grey,
                                          ),
                                        );
                                      } else if (snapshot.connectionState ==
                                          ConnectionState.done) {
                                        return RawScrollbar(
                                          thumbVisibility: true,
                                          controller: noticeProvider.scrollController,
                                          radius: Radius.circular(20),
                                          crossAxisMargin: 5,
                                          thumbColor: Colors.grey,
                                          thickness: 5,
                                          child: ListView.builder(
                                            itemCount: noticeProvider.notices.length,
                                            controller: noticeProvider.scrollController,
                                            shrinkWrap: true,
                                            itemBuilder: (context, index) {
                                              if (noticeProvider.options[noticeProvider.tag] ==
                                                      "공지" &&
                                                  noticeProvider.notices[index].category ==
                                                      "공지") {
                                                return InkWell(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.fromLTRB(15, 3, 5, 7),
                                                    child: Container(
                                                      child: Text(
                                                        "[${noticeProvider.notices[index].category}] ${noticeProvider.notices[index].title}",
                                                        overflow: TextOverflow.ellipsis,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyText2
                                                            ?.copyWith(fontSize: 15),
                                                      ),
                                                    ),
                                                  ),
                                                  onTap: () {
                                                    LaunchUrl.launchURL(
                                                        noticeProvider.notices[index].url);
                                                  },
                                                );
                                              } else if (noticeProvider
                                                          .options[noticeProvider.tag] ==
                                                      "점검" &&
                                                  noticeProvider.notices[index].category ==
                                                      "점검") {
                                                return InkWell(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.fromLTRB(15, 3, 5, 7),
                                                    child: Container(
                                                      child: Text(
                                                        "[${noticeProvider.notices[index].category}] ${noticeProvider.notices[index].title}",
                                                        overflow: TextOverflow.ellipsis,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyText2
                                                            ?.copyWith(fontSize: 15),
                                                      ),
                                                    ),
                                                  ),
                                                  onTap: () {
                                                    LaunchUrl.launchURL(
                                                        noticeProvider.notices[index].url);
                                                  },
                                                );
                                              } else if (noticeProvider
                                                      .options[noticeProvider.tag] ==
                                                  "전체") {
                                                return InkWell(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.fromLTRB(15, 3, 5, 7),
                                                    child: Container(
                                                      child: Text(
                                                        "[${noticeProvider.notices[index].category}] ${noticeProvider.notices[index].title}",
                                                        overflow: TextOverflow.ellipsis,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyText2
                                                            ?.copyWith(fontSize: 15),
                                                      ),
                                                    ),
                                                  ),
                                                  onTap: () {
                                                    LaunchUrl.launchURL(
                                                        noticeProvider.notices[index].url);
                                                  },
                                                );
                                              }
                                              return Container();
                                            },
                                          ),
                                        );
                                      }
                                    }
                                    return Center(child: Text('로스트아크 서버가 점검중입니다.'));
                                    // return FittedBox(
                                    //   fit: BoxFit.scaleDown,
                                    //   child: CircularProgressIndicator(
                                    //     color: DarkMode.isDarkMode.value ? Colors.grey : Colors.blue,
                                    //   ),
                                    // );
                                  },
                                ),
                              );
                            },
                          ),
                          Container(
                            height: 100,
                            width: 100.w,
                            child: FutureBuilder(
                              future: eventNoticeProvider.fetchLostArkEventNotice(),
                              builder: (context, AsyncSnapshot snapshot) {
                                if (snapshot.hasData == true) {
                                  if (snapshot.connectionState == ConnectionState.waiting) {
                                    return FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child: CircularProgressIndicator(
                                        color: Colors.grey,
                                      ),
                                    );
                                  } else if (snapshot.connectionState == ConnectionState.done) {
                                    if (snapshot.data?.length == 0) {
                                      return Center(child: Text(''));
                                    }
                                    return Padding(
                                      padding: const EdgeInsets.fromLTRB(15, 0, 15, 10),
                                      child: PageView.builder(
                                        controller: eventNoticeProvider.pageController,
                                        itemCount: snapshot.data?.length,
                                        itemBuilder: (context, index) {
                                          if (snapshot.hasData) {
                                            return snapshot.data![index];
                                          } else {
                                            return Container(
                                              child: Text(''),
                                            );
                                          }
                                        },
                                        onPageChanged: (value) {
                                          eventNoticeProvider.onPageChange(value);
                                        },
                                      ),
                                    );
                                  }
                                }
                                return FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: CircularProgressIndicator(
                                    color: Colors.grey,
                                  ),
                                );
                              },
                            ),
                          ),
                          Consumer<EventNoticeProvider>(
                            builder: (context, instance, child) {
                              return Container(
                                margin: const EdgeInsets.only(bottom: 10),
                                width: 100.w,
                                child: PageViewDotIndicator(
                                  currentItem: instance.currentIndex,
                                  count: instance.dotCount == 0 ? 1 : instance.dotCount,
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
                    ),
                  ),
                ],
              )),
        ],
      ),
    );
  }
}
