import 'dart:async';
import 'dart:convert';

import 'package:adeline_app/model/notice/adventure_island.dart';
import 'package:adeline_app/model/notice/event_notice.dart';
import 'package:adeline_app/screen/mobile/custom_scroll.dart';
import 'package:adeline_app/screen/mobile/home_screen/widget/admob_widget.dart';
import 'package:adeline_app/screen/mobile/home_screen/widget/character_search_bar.dart';
import 'package:adeline_app/screen/mobile/home_screen/widget/crystal_market_price_widget/crystal_market_price_widget.dart';
import 'package:adeline_app/screen/mobile/home_screen/widget/lobox_notice_widget.dart';
import 'package:adeline_app/screen/mobile/home_screen/widget/lostark_notice_widget.dart';
import 'package:adeline_app/screen/mobile/home_screen/widget/notice_controller/notice_controller.dart';
import 'package:adeline_app/screen/responsive/home/widget/adventure_island.dart';
import 'package:adeline_app/screen/responsive/home/widget/procyon_compass.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:html/parser.dart' as parser;
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../../../model/toast/toast.dart';
import '../drawer_screen/drawer_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with AutomaticKeepAliveClientMixin {
  Future<AdventureIsland?>? adventureIsland;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    NoticeProvider noticeProvider = Provider.of<NoticeProvider>(context, listen: false);
    adventureIsland = noticeProvider.fetchAdventureIsland();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return PlatformScaffold(
      appBar: PlatformAppBar(
        title: Text('HOME'),
        material: (_, __) => MaterialAppBarData(),
        cupertino: (_, __) => CupertinoNavigationBarData(),
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
            mainAxisSize: MainAxisSize.min,
            children: [
              CharacterSearchBar(),
              LoboxNoticeWidget(),
              CrystalMarketPriceWidget(),
              LostArkNoticeWidget(),
              AdmobWidget(),
              Container(
                child: Card(
                  child: FutureBuilder(
                    future: adventureIsland,
                    builder: (BuildContext context, AsyncSnapshot<AdventureIsland?> snapshot) {
                      if (snapshot.hasData == true) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(height: 5),
                              Text('모험 섬', style: Theme.of(context).textTheme.bodyText1),
                              SizedBox(height: 5),
                              Text('${snapshot.data?.islandDate}', style: Theme.of(context).textTheme.bodyText2),
                              SizedBox(height: 5),
                              Container(
                                margin: const EdgeInsets.only(left: 5, right: 5, bottom: 5),
                                child: Row(
                                  children: [
                                    Flexible(
                                      child: Stack(
                                        children: [
                                          ClipRRect(
                                            borderRadius: BorderRadius.circular(8),
                                            child: Image.asset(
                                              'assets/adventure_island/${snapshot.data?.islandList[0].name}.jpg',
                                              cacheHeight: 150,
                                              cacheWidth: 200,
                                            ),
                                          ),
                                          Positioned(
                                            top: 5,
                                            right: 10,
                                            child: Image.asset(
                                              'assets/adventure_reward/${snapshot.data?.islandList[0].reward}.png',
                                              width: 35,
                                              height: 35,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Flexible(
                                      child: Stack(
                                        children: [
                                          ClipRRect(
                                            borderRadius: BorderRadius.circular(8),
                                            child: Image.asset(
                                              'assets/adventure_island/${snapshot.data?.islandList[1].name}.jpg',
                                              cacheHeight: 150,
                                              cacheWidth: 200,
                                            ),
                                          ),
                                          Positioned(
                                            top: 5,
                                            right: 10,
                                            child: Image.asset(
                                              'assets/adventure_reward/${snapshot.data?.islandList[1].reward}.png',
                                              width: 35,
                                              height: 35,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Flexible(
                                      child: Stack(
                                        children: [
                                          ClipRRect(
                                            borderRadius: BorderRadius.circular(8),
                                            child: Image.asset(
                                              'assets/adventure_island/${snapshot.data?.islandList[2].name}.jpg',
                                              cacheHeight: 150,
                                              cacheWidth: 200,
                                            ),
                                          ),
                                          Positioned(
                                            top: 5,
                                            right: 10,
                                            child: Image.asset(
                                              'assets/adventure_reward/${snapshot.data?.islandList[2].reward}.png',
                                              width: 35,
                                              height: 35,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              ProcyonCompassWidget(),
                            ],
                          );
                        }
                      }
                      return Center(child: CircularProgressIndicator());
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
