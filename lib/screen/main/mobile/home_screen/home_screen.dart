import 'package:adeline_app/model/notice/adventure_island.dart';
import 'package:adeline_app/screen/custom_scroll.dart';
import 'package:adeline_app/screen/main/controller/notice_controller.dart';
import 'package:adeline_app/screen/main/mobile/drawer_screen.dart';
import 'package:adeline_app/screen/main/mobile/home_screen/widget/admob_widget.dart';
import 'package:adeline_app/screen/main/mobile/home_screen/widget/character_search_bar.dart';
import 'package:adeline_app/screen/main/mobile/home_screen/widget/crystal_market_price.dart';
import 'package:adeline_app/screen/main/mobile/home_screen/widget/lobox_notice.dart';
import 'package:adeline_app/screen/main/mobile/home_screen/widget/lostark_notice.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:provider/provider.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with AutomaticKeepAliveClientMixin {
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
                    future: Provider.of<NoticeProvider>(context, listen: false).adventureIsland,
                    builder: (BuildContext context, AsyncSnapshot<AdventureIsland?> snapshot) {
                      if (snapshot.hasData == true) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(height: 5),
                              Text('모험 섬', style: Theme.of(context).textTheme.headline1),
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
                              FittedBox(
                                fit: BoxFit.contain,
                                child: Card(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text('프로키온 나침반 일정', style: Theme.of(context).textTheme.headline1),
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(10, 5, 5, 5),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Text(
                                                  '월',
                                                  style: Theme.of(context).textTheme.bodyText1,
                                                ),
                                                SizedBox(height: 10),
                                                Image.asset('assets/procyon_compass/chaos_gate.png', width: 45, height: 45),
                                                SizedBox(height: 5),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(10, 5, 5, 5),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Text(
                                                  '화',
                                                  style: Theme.of(context).textTheme.bodyText1,
                                                ),
                                                SizedBox(height: 10),
                                                Image.asset('assets/procyon_compass/field_boss.png', width: 45, height: 45),
                                                SizedBox(height: 10),
                                                Image.asset('assets/procyon_compass/ghost_ship.png', width: 45, height: 45),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(10, 5, 5, 5),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Text(
                                                  '수',
                                                  style: Theme.of(context).textTheme.bodyText1,
                                                ),
                                                SizedBox(
                                                  height: 45,
                                                  width: 45,
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(10, 5, 5, 5),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Text(
                                                  '목',
                                                  style: Theme.of(context).textTheme.bodyText1,
                                                ),
                                                SizedBox(height: 10),
                                                Image.asset('assets/procyon_compass/chaos_gate.png', width: 45, height: 45),
                                                SizedBox(height: 10),
                                                Image.asset('assets/procyon_compass/ghost_ship.png', width: 45, height: 45),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(10, 5, 5, 5),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Text(
                                                  '금',
                                                  style: Theme.of(context).textTheme.bodyText1,
                                                ),
                                                SizedBox(height: 10),
                                                Image.asset('assets/procyon_compass/field_boss.png', width: 45, height: 45),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(10, 5, 5, 5),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Text(
                                                  '토',
                                                  style: Theme.of(context).textTheme.bodyText1,
                                                ),
                                                SizedBox(height: 10),
                                                Image.asset('assets/procyon_compass/chaos_gate.png', width: 45, height: 45),
                                                SizedBox(height: 10),
                                                Image.asset('assets/procyon_compass/ghost_ship.png', width: 45, height: 45),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(10, 5, 5, 5),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Text(
                                                  '일',
                                                  style: Theme.of(context).textTheme.bodyText1,
                                                ),
                                                SizedBox(height: 10),
                                                Image.asset('assets/procyon_compass/chaos_gate.png', width: 45, height: 45),
                                                SizedBox(height: 10),
                                                Image.asset('assets/procyon_compass/field_boss.png', width: 45, height: 45),
                                              ],
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
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
