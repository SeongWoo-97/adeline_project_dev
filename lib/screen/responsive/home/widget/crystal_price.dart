import 'package:adeline_app/model/notice/event_notice.dart';
import 'package:adeline_app/model/uri_launch/launch_url.dart';
import 'package:adeline_app/screen/mobile/home_screen/widget/notice_controller/event_notice_controller.dart';
import 'package:adeline_app/screen/mobile/home_screen/widget/notice_controller/notice_controller.dart';
import 'package:chips_choice_null_safety/chips_choice_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class RwdCrystalAndNoticePrice extends StatefulWidget {
  const RwdCrystalAndNoticePrice({Key? key}) : super(key: key);

  @override
  State<RwdCrystalAndNoticePrice> createState() => _RwdCrystalAndNoticePriceState();
}

class _RwdCrystalAndNoticePriceState extends State<RwdCrystalAndNoticePrice> {
  Future<List<LostArkEventNotice>>? fetchRwdLostArkEventNotice;
  Future? fetchLostArkNotice;
  TextStyle? bodyText;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    bodyText = Theme.of(context).textTheme.bodyText2;
    // 화면크기가 조정될 때 FutureBuilder 가 rebuild 방지
    EventNoticeProvider eventNoticeProvider = Provider.of<EventNoticeProvider>(context, listen: false);
    NoticeProvider noticeProvider = Provider.of<NoticeProvider>(context, listen: false);

    fetchRwdLostArkEventNotice = eventNoticeProvider.fetchRwdLostArkEventNotice();
    fetchLostArkNotice = noticeProvider.fetchLostArkNotice();
  }

  @override
  Widget build(BuildContext context) {
    NoticeProvider noticeProvider = Provider.of<NoticeProvider>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // 크리스탈 가격
          Row(
            children: [
              Flexible(
                child: Card(
                  margin: const EdgeInsets.only(bottom: 10),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(5, 7, 10, 7),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('크리스탈 구매 ', style: bodyText),
                        Text('${NumberFormat('###,###').format(int.parse('2406'))} G', style: bodyText),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Flexible(
                child: Card(
                  margin: const EdgeInsets.only(bottom: 10),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(5, 7, 10, 7),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('크리스탈 판매 ', style: bodyText),
                        Text('${NumberFormat('###,###').format(int.parse('2415'))} G', style: bodyText),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          // 공지사항
          Card(
            margin: const EdgeInsets.all(0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
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
                      child: FutureBuilder(
                        future: fetchLostArkNotice,
                        builder: (context, snapshot) {
                          if (snapshot.hasData == true) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              print('스냅샵');
                              return FittedBox(
                                fit: BoxFit.scaleDown,
                                child: CircularProgressIndicator(
                                  color: Colors.grey,
                                ),
                              );
                            } else if (snapshot.connectionState == ConnectionState.done) {
                              return Scrollbar(
                                // 창 조절 시 랜더링 오류 발생
                                // interactive: true,
                                // isAlwaysShown: true,
                                // crossAxisMargin: 5,
                                // thumbColor: Colors.grey,
                                controller: noticeProvider.scrollController,
                                radius: Radius.circular(20),
                                thickness: 5,
                                child: ListView.builder(
                                  itemCount: noticeProvider.notices.length,
                                  controller: noticeProvider.scrollController,
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    if (noticeProvider.options[noticeProvider.tag] == "공지" &&
                                        noticeProvider.notices[index].category == "공지") {
                                      return InkWell(
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(15, 3, 5, 7),
                                          child: Container(
                                            child: Text(
                                              "[${noticeProvider.notices[index].category}] ${noticeProvider.notices[index].title}",
                                              overflow: TextOverflow.ellipsis,
                                              style: Theme.of(context).textTheme.bodyText2?.copyWith(fontSize: 15),
                                            ),
                                          ),
                                        ),
                                        onTap: () {
                                          LaunchUrl.launchURL(noticeProvider.notices[index].url);
                                        },
                                      );
                                    } else if (noticeProvider.options[noticeProvider.tag] == "점검" &&
                                        noticeProvider.notices[index].category == "점검") {
                                      return InkWell(
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(15, 3, 5, 7),
                                          child: Container(
                                            child: Text(
                                              "[${noticeProvider.notices[index].category}] ${noticeProvider.notices[index].title}",
                                              overflow: TextOverflow.ellipsis,
                                              style: Theme.of(context).textTheme.bodyText2?.copyWith(fontSize: 15),
                                            ),
                                          ),
                                        ),
                                        onTap: () {
                                          LaunchUrl.launchURL(noticeProvider.notices[index].url);
                                        },
                                      );
                                    } else if (noticeProvider.options[noticeProvider.tag] == "전체") {
                                      return InkWell(
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(15, 3, 5, 7),
                                          child: Container(
                                            child: Text(
                                              "[${noticeProvider.notices[index].category}] ${noticeProvider.notices[index].title}",
                                              overflow: TextOverflow.ellipsis,
                                              style: Theme.of(context).textTheme.bodyText2?.copyWith(fontSize: 15),
                                            ),
                                          ),
                                        ),
                                        onTap: () {
                                          LaunchUrl.launchURL(noticeProvider.notices[index].url);
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
                SizedBox(height: 10),
                Container(
                  height: 100,
                  child: FutureBuilder(
                    future: fetchRwdLostArkEventNotice,
                    builder: (context, AsyncSnapshot<List<LostArkEventNotice>> snapshot) {
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
                            child: GridView.builder(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              // controller: con,
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 5,
                                mainAxisExtent: 100,
                                childAspectRatio: 1 / 2,
                                crossAxisSpacing: 0,
                                mainAxisSpacing: 0,
                              ),
                              itemCount: snapshot.data?.length,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Color(0xFF212121)),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(7),
                                      child: Image.network(snapshot.data![index].thumbImage),
                                    ),
                                  ),
                                  onTap: () {
                                    LaunchUrl.launchURL(snapshot.data![index].url);
                                  },
                                );
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}
