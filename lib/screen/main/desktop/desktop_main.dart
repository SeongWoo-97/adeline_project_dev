
import 'dart:ui';

import 'package:adeline_app/model/dark_mode/responsive/rwd_dark_theme_data.dart';
import 'package:adeline_app/screen/main/widget/adventure_island.dart';
import 'package:adeline_app/screen/main/widget/character_search_bar.dart';
import 'package:adeline_app/screen/main/widget/crystal_price.dart';
import 'package:adeline_app/screen/main/widget/distribution_calculator.dart';
import 'package:adeline_app/screen/main/widget/drawer.dart';
import 'package:adeline_app/screen/main/widget/lostark_coupon.dart';
import 'package:adeline_app/screen/main/widget/procyon_compass.dart';
import 'package:adeline_app/screen/main/widget/rwd_lobox_notice_widget.dart';
import 'package:flutter/material.dart';


class DesktopMainScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: rwdDarkThemeData,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Lobox2 width : ${MediaQuery.of(context).size.width} height : ${MediaQuery.of(context).size.height}'),
        ),
        drawer: RwdDrawerWidget(),
        body: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                      IntrinsicHeight(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Flexible(
                                flex: 9,
                                child: RwdCrystalAndNoticePrice()),
                            Flexible(
                              flex: 3,
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(0, 10, 10, 0),
                                child: Column(
                                  children: [
                                    RwdDistributionCaluWidget(),
                                    SizedBox(height: 10),
                                    RwdCouponWidget(),
                                    SizedBox(height: 10),
                                    RwdLoboxNoticeWidget(),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Flexible(child: RwdAdventureIslandWidget()),
                            SizedBox(width: 10),
                            Flexible(child: ProcyonCompassWidget()),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
