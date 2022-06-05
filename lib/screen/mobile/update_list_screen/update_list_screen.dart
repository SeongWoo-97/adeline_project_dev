import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:provider/provider.dart';

import '../../../model/dark_mode/dark_theme_provider.dart';

class UpdateListScreen extends StatefulWidget {
  const UpdateListScreen({Key? key}) : super(key: key);

  @override
  State<UpdateListScreen> createState() => _UpdateListScreenState();
}

class _UpdateListScreenState extends State<UpdateListScreen> {
  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      appBar: PlatformAppBar(
        title: Text('업데이트 내역'),
      ),
      body: ListView(
        children: [
          ExpansionTile(
            title: Text(
              '1.3.0 Ver',
            ),
            backgroundColor: DarkMode.isDarkMode.value ? Colors.grey[800] : Colors.white,
            collapsedIconColor: DarkMode.isDarkMode.value ? Colors.white : Colors.grey,
            iconColor: DarkMode.isDarkMode.value ? Colors.white : Colors.grey,
            expandedAlignment: Alignment.topLeft,
            childrenPadding: const EdgeInsets.only(bottom: 10),
            textColor: DarkMode.isDarkMode.value ? Colors.white : Colors.black,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('- 원정대 콘텐츠 커스텀 기능'),
                    Text('- 콘텐츠 현황판 추가'),
                    Text('- 전체 골드 추가'),
                    Text('- 골드 콘텐츠 기능 추가'),
                    Text('- 분배금 계산기 개선'),
                    Text('- 떠돌이상인 로웬 대륙 추가'),
                    Text('- 직업별 직업아이콘 추가'),
                    Text('- 일일/주간/골드 클리어 아이콘 추가'),
                    Text('- 다크모드 지원'),
                    Text('- 일부 UI 변경'),
                  ],
                ),
              )
            ],
          ),
          ExpansionTile(
            title: Text(
              '1.2.0 Ver',
            ),
            backgroundColor: DarkMode.isDarkMode.value ? Colors.grey[800] : Colors.white,
            collapsedIconColor: DarkMode.isDarkMode.value ? Colors.white : Colors.grey,
            iconColor: DarkMode.isDarkMode.value ? Colors.white : Colors.grey,
            expandedAlignment: Alignment.topLeft,
            childrenPadding: const EdgeInsets.only(bottom: 10),
            textColor: DarkMode.isDarkMode.value ? Colors.white : Colors.black,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('- 콘텐츠 설정 페이지 일일/주간 UI 변경'),
                    Text('- 콘텐츠 순서 변경할 수 있도록 개선'),
                    Text('- 캐릭터 슬롯창 UI 변경'),
                    Text('- 아이콘 및 폰트 크기 수정'),
                    Text('- 일일/주간 콘텐츠 완료 시 슬롯창 색깔 변경'),
                    Text('- 데자뷰아이콘 변경'),
                    Text('- 하단 메뉴바 레이아웃 변경'),
                    Text('- 빙고 도우미(빙파고) WebView 추가'),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
