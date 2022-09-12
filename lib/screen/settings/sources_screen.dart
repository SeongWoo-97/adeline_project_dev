import 'package:adeline_app/model/uri_launch/launch_url.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class SourcesScreen extends StatefulWidget {
  const SourcesScreen({Key? key}) : super(key: key);

  @override
  State<SourcesScreen> createState() => _SourcesScreenState();
}

class _SourcesScreenState extends State<SourcesScreen> {
  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      appBar: PlatformAppBar(
        title: Text('출처'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('링크 클릭시 해당 링크로 이동합니다.\n'),
            InkWell(
              child: Text('아이콘 출처\n - https://lostark.game.onstove.com/\n'),
              onTap: () {
                LaunchUrl.launchURL("https://lostark.game.onstove.com");
              },
            ),
            InkWell(
              child: Text('떠돌이 상인지도 출처\n - https://lostark.inven.co.kr/\n'),
              onTap: () {
                LaunchUrl.launchURL("https://lostark.inven.co.kr/");

              },
            ),
            InkWell(
              child: Text('떠돌이 상인 이미지 수정\n 수정자 - 코코넛별\n - 네이버 블로그 주소 : https://blog.naver.com/lovelycoconut/222468022028\n'),
              onTap: () {
                LaunchUrl.launchURL("https://blog.naver.com/lovelycoconut/222468022028");

              },
            ),
            InkWell(
              child: Text('빙고 도우미 페이지\n - https://github.com/ialy1595/kouku-saton-bingo\n'),
              onTap: () {
                LaunchUrl.launchURL("https://github.com/ialy1595/kouku-saton-bingo");

              },
            ),
            InkWell(
              child: Text('크리스탈, 모험섬 API 제공\n- 제작자 : 모코코더\n- 디스코드 주소:https://discord.gg/Bgsb7WkwVg\n'),
              onTap: () {
                LaunchUrl.launchURL("https://discord.gg/Bgsb7WkwVg");

              },
            ),
            InkWell(
              child: Text('레이드 공략 요약본 제공\n- 제작자 : 덕진\n- 네이버 블로그 주소 : https://blog.naver.com/bdj4767\n'),
              onTap: () {
                LaunchUrl.launchURL("https://blog.naver.com/bdj4767");
              },
            ),
            InkWell(
              child: Text('레이드 공략 요약본 제공\n- 제작자 : 큐티근육맨(니나브)\n'),
              onTap: () {},
            ),
            InkWell(child: Text('소스를 제공해 주신 분들 감사합니다.(꾸벅)'))
          ],
        ),
      ),
    );
  }
}
