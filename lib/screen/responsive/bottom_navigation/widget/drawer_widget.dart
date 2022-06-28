import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class RwdDrawerWidget extends StatelessWidget {
  const RwdDrawerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextStyle? subMenuStyle = Theme.of(context).textTheme.bodyText2?.copyWith(color: Colors.grey,fontSize: 12.5.sp);
    TextStyle? menuStyle = Theme.of(context).textTheme.bodyText1?.copyWith(fontSize: 12.5.sp);

    return SafeArea(
      child: Drawer(
        width: 46.sp,
        child: ListView(
          padding: const EdgeInsets.all(0),
          children: [
            Container(
              margin: const EdgeInsets.fromLTRB(15, 15, 0, 5),
              child: Text('도구', style: subMenuStyle),
            ),
            ListTile(
              visualDensity: const VisualDensity(horizontal: 0, vertical: -3),
              title: Text('캐릭터 숙제 관리', style: menuStyle),
              onTap: () {},
            ),
            ListTile(
              visualDensity: const VisualDensity(horizontal: 0, vertical: -3),
              title: Text('떠돌이 상인 지도', style: menuStyle),
              onTap: () {},
            ),
            ListTile(
              visualDensity: const VisualDensity(horizontal: 0, vertical: -3),
              title: Text('레이드 보상 계산기', style: menuStyle),
              onTap: () {},
            ),
            ListTile(
              visualDensity: const VisualDensity(horizontal: 0, vertical: -3),
              title: Text('쿠크세이튼 빙고 도우미', style: menuStyle),
              onTap: () {},
            ),
            Divider(color: Colors.grey, height: 6),
            Container(
              margin: const EdgeInsets.fromLTRB(15, 5, 0, 0),
              child: Text('검색', style: subMenuStyle),
            ),
            ListTile(
              visualDensity: const VisualDensity(horizontal: 0, vertical: -3),
              title: Text('멀티 검색', style: menuStyle),
              onTap: () {},
            ),
            ListTile(
              visualDensity: const VisualDensity(horizontal: 0, vertical: -3),
              title: Text('거래소 시세 검색', style: menuStyle),
              onTap: () {},
            ),
            Divider(color: Colors.grey, height: 6),
            Container(
              margin: const EdgeInsets.fromLTRB(15, 5, 0, 5),
              child: Text('소개', style: subMenuStyle),
            ),
            ListTile(
              visualDensity: const VisualDensity(horizontal: 0, vertical: -3),
              title: Text('유튜버 & 방송 소개', style: menuStyle),
              onTap: () {},
            ),
            ListTile(
              visualDensity: const VisualDensity(horizontal: 0, vertical: -3),
              title: Text('로스트아크 유저 이모티콘', style: menuStyle),
              onTap: () {},
            ),
            ListTile(
              visualDensity: const VisualDensity(horizontal: 0, vertical: -3),
              title: Text('로스트아크 OST Player', style: menuStyle),
              onTap: () {},
            ),
            Divider(
              color: Colors.grey,
              height: 6,
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(15, 5, 0, 5),
              child: Text('정보', style: subMenuStyle),
            ),
            ListTile(
              visualDensity: const VisualDensity(horizontal: 0, vertical: -3),
              title: Text('시너지 목록', style: menuStyle),
              onTap: () {},
            ),
            ListTile(
              visualDensity: const VisualDensity(horizontal: 0, vertical: -3),
              title: Text('장비 세트 효과 리스트', style: menuStyle),
              onTap: () {},
            ),
            ListTile(
              visualDensity: const VisualDensity(horizontal: 0, vertical: -3),
              title: Text('각인 정보 리스트', style: menuStyle),
              onTap: () {},
            ),
            ListTile(
              visualDensity: const VisualDensity(horizontal: 0, vertical: -3),
              title: Text('직업 스킬 리스트', style: menuStyle),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
