import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

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
              '2.0.1 Ver (2022.09.12)',
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
                    Text('버그', style: Theme.of(context).textTheme.bodyText1),
                    Text('- 숙제관리 2일 이상 미접속시 휴식게이지가 정상적으로 집계되지 않는 버그 수정'),
                  ],
                ),
              )
            ],
          ),

          ExpansionTile(
            title: Text(
              '2.0.0 Ver (2022.08.26)',
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
                    Text('안내', style: Theme.of(context).textTheme.bodyText1),
                    Text('- 신규 내실 기억의 오르골 추가'),
                    Text('- 레이드 콘텐츠 클리어 시 테두리 초록색으로 변경'),
                    Text('개선', style: Theme.of(context).textTheme.bodyText1),
                    Text('- 레이드 추가 골드 개선'),
                    Text('일반/버스 -> 수입/지출 로 변경하였습니다. 추가골드는 수입과 지출의 합으로 결정됩니다.',style: Theme.of(context).textTheme.caption),
                    Text('추가 골드는 "골드 획득 캐릭터"에 영향을 받지 않습니다.',style: Theme.of(context).textTheme.caption),
                    Text('추가', style: Theme.of(context).textTheme.bodyText1),
                    Text('- 골드 획득 캐릭터 지정 기능 추가'),
                    Text('버그', style: Theme.of(context).textTheme.bodyText1),
                    Text('- 일부 캐릭터에서 검색이 안되는 버그 수정'),
                    Text('- 트라이포드 버그 수정'),
                    Text('- 레이드 아이콘 콘텐츠 별로 구분되지 않는 버그 수정'),
                    Text('- 닉네임 12글자 수정 불가능한 버그 수정'),
                  ],
                ),
              )
            ],
          ),
          ExpansionTile(
            title: Text(
              '1.5.6 Ver',
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
                    Text(
                      '안내',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    Text('- 공식 전투정보실 업데이트에 따른 대응'),
                    Text('- Web App 사전 준비 패치'),
                  ],
                ),
              )
            ],
          ),
          ExpansionTile(
            title: Text(
              '1.5.0 Ver',
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
                    Text(
                      '안내',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    Text('- 골드 콘텐츠 개선으로 인한 기존 DB를 사용불가'),
                    Text('- 앱 아이콘 변경'),
                    Text('- 앱 이름 변경 (변경 전 : 아델라인, 변경 후: 로박스)'),
                    Text('- 캐릭터 현황판에 표시되는 콘텐츠를 각 캐릭터마다 클리어 기준 수치를 선택할 수 있습니다.'),
                    Text('- 캐릭터 슬롯 창 아래에 배너광고가 추가되었습니다.'),
                    Text(
                      '개선',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    Text('- 골드 콘텐츠에 각 난이도 별로 체크 할 수 있도록 개선'),
                    Text('- 캐릭터 목록 불러오는 구조 개선'),
                    Text('- 콘텐츠 현황판 개선'),
                    Text('- 캐릭터 검색 카드 UI 개선'),
                    Text(
                      '추가',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    Text('- 홈 화면에 프로키온 나침반, 모험섬 위젯 추가'),
                    Text('- 캐릭터검색에 수집형콘텐츠 행 추가'),
                    Text('- 일일/주간 기본 콘텐츠 추가'),
                    Text('- 커스텀 콘텐츠에 사용되는 아이콘 추가'),
                    Text('- 엘가시아 떠돌이 상인 지도 추가'),
                    Text('- [아델] 원정대콘텐츠 항상펼치기/항상접기 기능 추가'),
                    Text('- [아델] 첫 화면설정 기능을 추가'),
                    Text(
                      '버그',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    Text('- 숙제관리 초기화 버그 수정'),
                    Text('- 이벤트를 전체 불러오지 못하는 현상 수정'),
                    Text('- [패검객] 수동초기화시 프리징 현상 수정'),
                  ],
                ),
              )
            ],
          ),
          ExpansionTile(
            title: Text(
              '1.4.0 Ver',
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
                    Text('- 홈 화면 추가'),
                    Text('- 첫 실행시 "캐릭터 설정 화면" 에서 "홈 화면"으로 변경'),
                    Text('- 로스트아크 공지사항 및 이벤트 불러오기 기능 추가'),
                    Text('- 크리스탈 가격 추가'),
                    Text('- 로박스 공지사항 추가'),
                    Text('- 캐릭터 검색 기능 추가'),
                    Text('- 숙제관리 "수동 초기화" 추가'),
                    Text('- 원정대 콘텐츠 축소/확장할 수 있도록 UI 수정'),
                    Text('- 캐릭터 슬롯에 일일/주간 버튼 순서 버그 수정'),
                  ],
                ),
              )
            ],
          ),
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
