import 'package:adeline_app/screen/binpago_webview/binpago_layout.dart';
import 'package:adeline_app/screen/binpago_webview/mobile_binpago_webview.dart';
import 'package:adeline_app/screen/cheating_paper/not_mobile_cheating_paper.dart';
import 'package:adeline_app/screen/home_work/characters_isExist/character_select_screen.dart';
import 'package:adeline_app/screen/merchant_location/merchant_location_layout.dart';
import 'package:adeline_app/screen/merchant_location/mobile_merchant_location_screen.dart';
import 'package:adeline_app/screen/settings/sources_screen.dart';
import 'package:flutter/material.dart';

class RwdDrawerWidget extends StatelessWidget {
  const RwdDrawerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextStyle? subMenuStyle = Theme.of(context).textTheme.bodyText2;
    TextStyle? menuStyle = Theme.of(context).textTheme.bodyText1;
    return SafeArea(
      child: Container(
        width: 230,
        child: Drawer(
          child: ListView(
            padding: const EdgeInsets.all(0),
            children: [
              Container(
                margin: const EdgeInsets.fromLTRB(15, 15, 0, 5),
                child: Text('도구', style: subMenuStyle?.copyWith(color: Colors.grey)),
              ),
              ListTile(
                visualDensity: const VisualDensity(horizontal: 0, vertical: -3),
                title: Text('캐릭터 숙제 관리', style: menuStyle),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => CharacterSelectScreen()));
                },
              ),
              ListTile(
                visualDensity: const VisualDensity(horizontal: 0, vertical: -3),
                title: Text('떠돌이 상인 지도', style: menuStyle),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => MerchantLocationLayout()));
                },
              ),
              ListTile(
                visualDensity: const VisualDensity(horizontal: 0, vertical: -3),
                title: Text('레이드 커닝페이퍼', style: menuStyle),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => NotMobileCheatingPaperScreen()));

                },
              ),

              ListTile(
                visualDensity: const VisualDensity(horizontal: 0, vertical: -3),
                title: Text('쿠크세이튼 빙고 도우미', style: menuStyle),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => BinpagoLayout()));

                },
              ),

              // Divider(color: Colors.grey, height: 6),
              ListTile(
                visualDensity: const VisualDensity(horizontal: 0, vertical: -3),
                title: Text('출처', style: menuStyle),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => SourcesScreen()));
                },
              ),
              // ListTile(
              //   visualDensity: const VisualDensity(horizontal: 0, vertical: -3),
              //   title: Text('멀티 검색', style: menuStyle),
              //   onTap: () {},
              // ),
              // ListTile(
              //   visualDensity: const VisualDensity(horizontal: 0, vertical: -3),
              //   title: Text('거래소 시세 검색', style: menuStyle),
              //   onTap: () {},
              // ),
              // Divider(color: Colors.grey, height: 6),
              // Container(
              //   margin: const EdgeInsets.fromLTRB(15, 5, 0, 5),
              //   child: Text('소개', style: subMenuStyle),
              // ),
              // ListTile(
              //   visualDensity: const VisualDensity(horizontal: 0, vertical: -3),
              //   title: Text('유튜버 & 방송 소개', style: menuStyle),
              //   onTap: () {},
              // ),
              // ListTile(
              //   visualDensity: const VisualDensity(horizontal: 0, vertical: -3),
              //   title: Text('로스트아크 유저 이모티콘', style: menuStyle),
              //   onTap: () {},
              // ),
              // ListTile(
              //   visualDensity: const VisualDensity(horizontal: 0, vertical: -3),
              //   title: Text('로스트아크 OST Player', style: menuStyle),
              //   onTap: () {},
              // ),
              // Divider(
              //   color: Colors.grey,
              //   height: 6,
              // ),
              // Container(
              //   margin: const EdgeInsets.fromLTRB(15, 5, 0, 5),
              //   child: Text('정보', style: subMenuStyle),
              // ),
              // ListTile(
              //   visualDensity: const VisualDensity(horizontal: 0, vertical: -3),
              //   title: Text('시너지 목록', style: menuStyle),
              //   onTap: () {},
              // ),
              // ListTile(
              //   visualDensity: const VisualDensity(horizontal: 0, vertical: -3),
              //   title: Text('장비 세트 효과 리스트', style: menuStyle),
              //   onTap: () {},
              // ),
              // ListTile(
              //   visualDensity: const VisualDensity(horizontal: 0, vertical: -3),
              //   title: Text('각인 정보 리스트', style: menuStyle),
              //   onTap: () {},
              // ),
              // ListTile(
              //   visualDensity: const VisualDensity(horizontal: 0, vertical: -3),
              //   title: Text('직업 스킬 리스트', style: menuStyle),
              //   onTap: () {},
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
