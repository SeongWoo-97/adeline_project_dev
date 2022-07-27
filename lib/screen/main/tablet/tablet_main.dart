import 'dart:ui';

import 'package:adeline_app/model/dark_mode/responsive/rwd_dark_theme_data.dart';
import 'package:adeline_app/screen/main/widget/adventure_island.dart';
import 'package:adeline_app/screen/main/widget/character_search_bar.dart';
import 'package:adeline_app/screen/main/widget/crystal_price.dart';
import 'package:adeline_app/screen/main/widget/distribution_calculator.dart';
import 'package:adeline_app/screen/main/widget/drawer.dart';
import 'package:adeline_app/screen/main/widget/lostark_coupon.dart';
import 'package:adeline_app/screen/main/widget/procyon_compass.dart';
import 'package:flutter/material.dart';

class TabletMainScreen extends StatelessWidget {
  const TabletMainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: rwdDarkThemeData,
      child: Scaffold(
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
      ),
    );
  }
}
