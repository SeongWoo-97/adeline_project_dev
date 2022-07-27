import 'package:flutter/material.dart';

import '../../../model/dark_mode/dark_theme_provider.dart';
import '../../binpago_webview/binpago_webview.dart';
import '../../merchant_location/merchant_location_screen.dart';

class DrawerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: ListView(
          padding: const EdgeInsets.all(0),
          children: [
            Container(
              margin: const EdgeInsets.fromLTRB(15, 15, 0, 0),
              child: Text(
                '도구',
                style: TextStyle(color: DarkMode.isDarkMode.value ? Colors.white70 : Colors.grey),
              ),
            ),
            ListTile(
              visualDensity: const VisualDensity(horizontal: 0, vertical: -3),
              title: const Text(
                '떠돌이 상인 지도', style: const TextStyle(fontFamily: 'NotoSansKR', fontSize: 16),
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) => MerchantLocationScreen()));
              },
            ),
            ListTile(
              visualDensity: const VisualDensity(horizontal: 0, vertical: -3),
              title: const Text('쿠크세이튼 빙고 도우미', style: const TextStyle(fontFamily: 'NotoSansKR', fontSize: 16),),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) => BinpagoWebView()));
              },
            ),
            // ListTile(
            //   visualDensity: const VisualDensity(horizontal: 0, vertical: -3),
            //   title: const Text(
            //     '레이드 보상 계산기',
            //     style: const TextStyle(fontFamily: 'NotoSansKR', fontSize: 16),
            //   ),
            //   onTap: () {},
            // ),
            // Divider(
            //   color: Colors.grey,
            // ),
            // Container(
            //   margin: const EdgeInsets.fromLTRB(15, 5, 0, 0),
            //   child: Text(
            //     '검색',
            //     style: TextStyle(color: DarkMode.isDarkMode.value ? Colors.white70 : Colors.grey),
            //   ),
            // ),
            // ListTile(
            //   visualDensity: const VisualDensity(horizontal: 0, vertical: -3),
            //   title: const Text(
            //     '멀티 검색',
            //     style: const TextStyle(fontFamily: 'NotoSansKR', fontSize: 16),
            //   ),
            //   onTap: () {},
            // ),
            // ListTile(
            //   visualDensity: const VisualDensity(horizontal: 0, vertical: -3),
            //   title: const Text(
            //     '거래소 시세 검색',
            //     style: const TextStyle(fontFamily: 'NotoSansKR', fontSize: 16),
            //   ),
            //   onTap: () {},
            // ),
            // Divider(
            //   color: Colors.grey,
            // ),
            // Container(
            //   margin: const EdgeInsets.fromLTRB(15, 5, 0, 0),
            //   child: Text(
            //     '소개',
            //     style: TextStyle(color: DarkMode.isDarkMode.value ? Colors.white70 : Colors.grey),
            //   ),
            // ),
            // ListTile(
            //   visualDensity: const VisualDensity(horizontal: 0, vertical: -3),
            //   title: const Text(
            //     '유튜버 & 방송 소개',
            //     style: const TextStyle(fontFamily: 'NotoSansKR', fontSize: 16),
            //   ),
            //   onTap: () {},
            // ),
            // ListTile(
            //   visualDensity: const VisualDensity(horizontal: 0, vertical: -3),
            //   title: const Text(
            //     '로스트아크 유저 이모티콘',
            //     style: const TextStyle(fontFamily: 'NotoSansKR', fontSize: 16),
            //   ),
            //   onTap: () {},
            // ),
            // ListTile(
            //   visualDensity: const VisualDensity(horizontal: 0, vertical: -3),
            //   title: const Text(
            //     '로스트아크 OST Player',
            //     style: const TextStyle(fontFamily: 'NotoSansKR', fontSize: 16),
            //   ),
            //   onTap: () {},
            // ),
            // Divider(
            //   color: Colors.grey,
            // ),
            // Container(
            //   margin: const EdgeInsets.fromLTRB(15, 5, 0, 0),
            //   child: Text(
            //     '정보',
            //     style: TextStyle(color: DarkMode.isDarkMode.value ? Colors.white70 : Colors.grey),
            //   ),
            // ),
            // ListTile(
            //   visualDensity: const VisualDensity(horizontal: 0, vertical: -3),
            //   title: const Text(
            //     '시너지 목록',
            //     style: const TextStyle(fontFamily: 'NotoSansKR', fontSize: 16),
            //   ),
            //   onTap: () {},
            // ),
            // ListTile(
            //   visualDensity: const VisualDensity(horizontal: 0, vertical: -3),
            //   title: const Text(
            //     '장비 세트 효과 리스트',
            //     style: const TextStyle(fontFamily: 'NotoSansKR', fontSize: 16),
            //   ),
            //   onTap: () {},
            // ),
            // ListTile(
            //   visualDensity: const VisualDensity(horizontal: 0, vertical: -3),
            //   title: const Text(
            //     '각인 정보 리스트',
            //     style: const TextStyle(fontFamily: 'NotoSansKR', fontSize: 16),
            //   ),
            //   onTap: () {},
            // ),
            // ListTile(
            //   visualDensity: const VisualDensity(horizontal: 0, vertical: -3),
            //   title: const Text(
            //     '직업 스킬 리스트',
            //     style: const TextStyle(fontFamily: 'NotoSansKR', fontSize: 16),
            //   ),
            //   onTap: () {},
            // ),
          ],
        ),
      ),
    );
  }
}
