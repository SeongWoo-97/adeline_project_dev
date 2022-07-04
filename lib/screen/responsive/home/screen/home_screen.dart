import 'dart:ui';

import 'package:adeline_app/screen/responsive/home/widget/adventure_island.dart';
import 'package:adeline_app/screen/responsive/home/widget/character_search_bar.dart';
import 'package:adeline_app/screen/responsive/home/widget/lostark_coupon.dart';
import 'package:adeline_app/screen/responsive/home/widget/crystal_price.dart';
import 'package:adeline_app/screen/responsive/home/widget/distribution_calculator.dart';
import 'package:adeline_app/screen/responsive/home/widget/drawer.dart';
import 'package:adeline_app/screen/responsive/home/widget/procyon_compass.dart';
import 'package:flutter/material.dart';

class RwdHomeScreen extends StatefulWidget {
  const RwdHomeScreen({Key? key}) : super(key: key);

  @override
  State<RwdHomeScreen> createState() => _RwdBottomNavigationScreenState();
}

class _RwdBottomNavigationScreenState extends State<RwdHomeScreen> {
  DateTime now = DateTime.now();
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: LayoutBuilder(builder: (context, constraints) {
        if (constraints.maxWidth >= 1270) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Lobox width : ${MediaQuery.of(context).size.width} height : ${MediaQuery.of(context).size.height}'),
            ),
            body: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RwdDrawerWidget(),
                Expanded(
                  child: ScrollConfiguration(
                    behavior: ScrollConfiguration.of(context).copyWith(
                      dragDevices: {
                        PointerDeviceKind.touch,
                        PointerDeviceKind.mouse,
                      },
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // 캐릭터 검색바
                          Align(alignment: Alignment.center, child: RwdCharacterSearchBarWidget()),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Flexible(
                                  flex: 9,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      RwdCrystalAndNoticePrice(),
                                      IntrinsicHeight(
                                        child: Padding(
                                          padding: const EdgeInsets.only(left: 10, right: 10),
                                          child: Row(
                                            crossAxisAlignment: CrossAxisAlignment.stretch,
                                            children: [
                                              RwdAdventureIslandWidget(),
                                              SizedBox(width: 15),
                                              ProcyonCompassWidget(),
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  )),
                              Flexible(
                                flex: 3,
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(0, 10, 10, 0),
                                  child: Column(
                                    children: [
                                      RwdDistributionCaluWidget(),
                                      SizedBox(height: 15),
                                      RwdCouponWidget(),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        } else {
          return Scaffold(
            appBar: AppBar(
              title: Text('width : ${MediaQuery.of(context).size.width} height : ${MediaQuery.of(context).size.height}'),
            ),
            drawer: RwdDrawerWidget(),
            body: ScrollConfiguration(
              behavior: ScrollConfiguration.of(context).copyWith(
                dragDevices: {
                  PointerDeviceKind.touch,
                  PointerDeviceKind.mouse,
                },
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 캐릭터 검색바
                    Align(alignment: Alignment.center, child: RwdCharacterSearchBarWidget()),
                    // 공지사항, 크리스탈, 이벤트
                    RwdCrystalAndNoticePrice(),
                    IntrinsicHeight(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Flexible(
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(10, 0, 15, 15),
                              child: RwdDistributionCaluWidget(),
                            ),
                          ),
                          Flexible(
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 10, 15),
                              child: RwdCouponWidget(),
                            ),
                          ),
                        ],
                      ),
                    ),
                    IntrinsicHeight(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          SizedBox(width: 10),
                          RwdAdventureIslandWidget(),
                          SizedBox(width: 10),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 10, 15),
                            child: ProcyonCompassWidget(),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        }
      }),
    );
  }
}
