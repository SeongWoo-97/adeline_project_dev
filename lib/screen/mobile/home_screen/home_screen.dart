import 'dart:async';
import 'dart:convert';

import 'package:adeline_app/model/character_list/character_list.dart';
import 'package:adeline_app/model/notice/event_notice.dart';
import 'package:adeline_app/screen/mobile/custom_scroll.dart';
import 'package:adeline_app/screen/mobile/home_screen/widget/character_search_bar.dart';
import 'package:adeline_app/screen/mobile/home_screen/widget/crystal_market_price_widget/crystal_market_price_widget.dart';
import 'package:adeline_app/screen/mobile/home_screen/widget/lobox_notice_widget.dart';
import 'package:adeline_app/screen/mobile/home_screen/widget/lostark_notice_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:html/parser.dart' as parser;
import 'package:http/http.dart' as http;

import '../../../model/toast/toast.dart';
import '../drawer_screen/drawer_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with AutomaticKeepAliveClientMixin {
  BannerAd bannerAd = BannerAd(
    adUnitId: 'ca-app-pub-2659418845004468/1781199037',
    size: AdSize.banner,
    request: AdRequest(),
    listener: BannerAdListener(),
  );

  @override
  bool get wantKeepAlive => true;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return PlatformScaffold(
      appBar: PlatformAppBar(
        title: Text('HOME'),
        material: (_, __) => MaterialAppBarData(),
        cupertino: (_, __) => CupertinoNavigationBarData(),
        trailingActions: [
          TextButton(
            child: Text('테스트 버튼'),
            onPressed: () async {
              try {
                http.Response response = await http.get(Uri.parse('http://132.226.22.9:3381/lobox/event'));
                List<dynamic> json = jsonDecode(response.body);
                List<LostArkEventNotice> list = [];
                json.forEach((element) {
                  list.add(LostArkEventNotice.fromJson(element));
                });
                list.forEach((element) {
                  print(element.title);
                });
              } on TimeoutException {
                ToastMessage.toast('접속 시간이 초과 되었습니다.');
              } catch (e) {
                print('오류(HomeScreen) : ${e}');
              }
            },
          ),
        ],
      ),
      material: (_, __) => MaterialScaffoldData(
        drawer: Container(
          width: 230,
          child: DrawerScreen(),
        ),
      ),
      body: ScrollConfiguration(
        behavior: CustomScroll(),
        child: SingleChildScrollView(
          child: Column(
            children: [
              CharacterSearchBar(),
              LoboxNoticeWidget(),
              CrystalMarketPriceWidget(),
              LostArkNoticeWidget(),
              FutureBuilder(
                future: bannerAd.load(),
                builder: (context, snapshot) {
                  return Container(
                    child: AdWidget(ad: bannerAd),
                    width: bannerAd.size.width.toDouble(),
                    height: 60.0,
                    alignment: Alignment.center,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
