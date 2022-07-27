import 'dart:convert';
import 'dart:ui';

import 'package:adeline_app/model/dark_mode/responsive/rwd_dark_theme_data.dart';
import 'package:adeline_app/screen/main/controller/notice_controller.dart';
import 'package:adeline_app/screen/main/widget/adventure_island.dart';
import 'package:adeline_app/screen/main/widget/character_search_bar.dart';
import 'package:adeline_app/screen/main/widget/crystal_price.dart';
import 'package:adeline_app/screen/main/widget/distribution_calculator.dart';
import 'package:adeline_app/screen/main/widget/drawer.dart';
import 'package:adeline_app/screen/main/widget/lostark_coupon.dart';
import 'package:adeline_app/screen/main/widget/procyon_compass.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class DesktopMainScreen extends StatelessWidget {
  const DesktopMainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: rwdDarkThemeData,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Lobox width : ${MediaQuery.of(context).size.width} height : ${MediaQuery.of(context).size.height}'),
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
      ),
    );
  }
}
