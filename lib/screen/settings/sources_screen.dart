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
            Text('아이콘 출처\n - https://lostark.game.onstove.com/\n'),
            Text('떠돌이 상인지도 출처\n - https://lostark.inven.co.kr/\n'),
            Text('떠돌이 상인 이미지 수정\n - https://blog.naver.com/lovelycoconut/222468022028\n'),
            Text('빙고 도우미 페이지\n - https://github.com/ialy1595/kouku-saton-bingo\n'),
            Text('크리스탈, 모험섬 API 제공\n- 제작자 : 모코코더\n- 디스코드 주소:https://discord.gg/Bgsb7WkwVg\n'),
            Text('소스를 제공해 주신 분들 감사합니다.(꾸벅)')
          ],
        ),
      ),
    );
  }
}