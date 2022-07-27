import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:photo_view/photo_view.dart';

import '../../constant/constant.dart';

class MerchantLocationScreen extends StatefulWidget {
  const MerchantLocationScreen({Key? key}) : super(key: key);
  @override
  _MerchantLocationScreenState createState() => _MerchantLocationScreenState();
}

class _MerchantLocationScreenState extends State<MerchantLocationScreen> {
  final TextEditingController _typeAheadController = TextEditingController();
  SuggestionsBoxController _suggestionsBoxController = SuggestionsBoxController();
  CupertinoSuggestionsBoxController _cupertinoSuggestionsBoxController = CupertinoSuggestionsBoxController();
  List<String> regions = [];
  String selectedItem = '';
  late int selectedContinent;
  late int? selectedRegion = 1;
  Map<String, int> map = {};
  BannerAd bannerAd = BannerAd(
    adUnitId: 'ca-app-pub-2659418845004468/1781199037',
    size: AdSize.banner,
    request: AdRequest(),
    listener: BannerAdListener(),
  );
  @override
  void dispose() {
    // TODO: implement dispose
    _typeAheadController.dispose();
    _suggestionsBoxController.close();
    _cupertinoSuggestionsBoxController.close();
    super.dispose();
  }
  @override
  void initState() {
    super.initState();
    bannerAd.load();

  }
  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      appBar: PlatformAppBar(
        title: Text('떠돌이 상인 위치'),
      ),
      cupertino: (_, __) => CupertinoPageScaffoldData(
        body: SafeArea(
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    children: [
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CupertinoTypeAheadField(
                            getImmediateSuggestions: true,
                            textFieldConfiguration: CupertinoTextFieldConfiguration(
                              controller: _typeAheadController,
                              prefix: Padding(
                                padding: const EdgeInsets.fromLTRB(5, 10, 0, 10),
                                child: Icon(Icons.search),
                              ),
                            ),
                            suggestionsCallback: (String pattern) {
                              return StateService.getSuggestions(pattern);
                            },
                            onSuggestionSelected: (String suggestion) {
                              _typeAheadController.text = suggestion;
                              setState(() {
                                selectedRegion = merchantMap[suggestion];
                              });
                            },
                            suggestionsBoxController: _cupertinoSuggestionsBoxController,
                            itemBuilder: (BuildContext context, String suggestion) {
                              return Padding(
                                padding: EdgeInsets.all(4.0),
                                child: Text(suggestion),
                              );
                            },
                            minCharsForSuggestions: 1,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: DropdownSearch<String>(
                            validator: (v) => v == null ? "required field" : null,
                            selectedItem: '',
                            items: merchantMapOfMap.keys.toList(),
                            onChanged: (value) {
                              setState(() {
                                map.clear();
                                map.addAll(merchantMapOfMap[value]!);
                              });
                              // print(map);
                            },
                          ),
                        ),
                      ),
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: DropdownSearch<String>(
                            validator: (v) => v == null ? "required field" : null,
                            items: map.keys.toList(),
                            selectedItem: selectedItem,
                            onChanged: (value) {
                              setState(() {
                                selectedRegion = map[value];
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                      vertical: 5.0,
                      horizontal: 10.0,
                    ),
                    height: MediaQuery.of(context).size.height * 0.5,
                    child: ClipRect(
                      child: PhotoView.customChild(
                        backgroundDecoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(15)),
                        child: Image.asset(
                          "assets/map/$selectedRegion.png",
                        ),
                        initialScale: 1.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      material: (_, __) => MaterialScaffoldData(
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: SingleChildScrollView(
            child: Column(
              children: [
                // 패키지 업데이트로 인한 코드 수정 필요
                // Row(
                //   children: [
                //     Flexible(
                //       child: Padding(
                //         padding: const EdgeInsets.all(8.0),
                //         child: TypeAheadField(
                //           getImmediateSuggestions: true,
                //           textFieldConfiguration: TextFieldConfiguration(
                //             controller: _typeAheadController,
                //             decoration: InputDecoration(
                //               label: Text('맵 이름 검색'),
                //               icon: Icon(Icons.search),
                //             ),
                //           ),
                //           suggestionsCallback: (String pattern) {
                //             return StateService.getSuggestions(pattern);
                //           },
                //           onSuggestionSelected: (String suggestion) {
                //             _typeAheadController.text = suggestion;
                //             setState(() {
                //               selectedRegion = merchantMap[suggestion];
                //             });
                //           },
                //           suggestionsBoxController: _suggestionsBoxController,
                //           itemBuilder: (BuildContext context, String suggestion) {
                //             return Padding(
                //               padding: EdgeInsets.all(4.0),
                //               child: ListTile(title: Text(suggestion)),
                //             );
                //           },
                //           noItemsFoundBuilder: (BuildContext context) => Padding(
                //             padding: const EdgeInsets.all(5.0),
                //             child: Text("검색 결과가 존재하지 않습니다."),
                //           ),
                //           minCharsForSuggestions: 1,
                //         ),
                //       ),
                //     ),
                //   ],
                // ),
                Row(
                  children: [
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: DropdownSearch<String>(
                          validator: (v) => v == null ? "required field" : null,

                          selectedItem: '',
                          items: merchantMapOfMap.keys.toList(),
                          onChanged: (value) {
                            setState(() {
                              map.clear();
                              map.addAll(merchantMapOfMap[value]!);
                            });
                          },
                        ),
                      ),
                    ),
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: DropdownSearch<String>(
                          validator: (v) => v == null ? "required field" : null,

                          items: map.keys.toList(),
                          selectedItem: selectedItem,
                          onChanged: (value) {
                            setState(() {
                              selectedRegion = map[value];
                            });
                          },

                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.symmetric(
                    vertical: 5.0,
                    horizontal: 10.0,
                  ),
                  height: MediaQuery.of(context).size.height * 0.5,
                  child: ClipRect(
                    child: PhotoView.customChild(
                      backgroundDecoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(15)),
                      child: Image.asset(
                        "assets/map/$selectedRegion.png",
                      ),
                      initialScale: 1.0,
                    ),
                  ),
                ),
                StatefulBuilder(
                  builder: (context, setState) => Container(
                    child: AdWidget(ad: bannerAd),
                    width: bannerAd.size.width.toDouble(),
                    height: 60.0,
                    alignment: Alignment.center,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  RenderBox? _findBorderBox(RenderBox box) {
    RenderBox? borderBox;

    box.visitChildren((child) {
      if (child is RenderCustomPaint) {
        borderBox = child;
      }

      final box = _findBorderBox(child as RenderBox);
      if (box != null) {
        borderBox = box;
      }
    });

    return borderBox;
  }
}

class StateService {
  static final List<String> states = [
    '로그힐',
    '안게모스 산 기슭',
    '국경지대',
    '살란드 구릉지',
    '오즈혼 구릉지',
    '자고라스 산',
    '레이크바',
    '메드리닉 수도원',
    '빌브린 숲',
    '격전의 평야',
    '디오리카 평원',
    '해무리 언덕',
    '배꽃나무 자생지',
    '흑장미 교회당',
    '라니아 단구',
    '보레아 영지',
    '크로커니스 해변',
    '바다향기 숲',
    '달콤한 숲',
    '성큼바위 숲',
    '침묵하는 거인의 숲',
    '델파이 현',
    '등나무 언덕',
    '소리의 숲',
    '거울 계곡',
    '황혼의 연무',
    '메마른 통로',
    '갈라진 땅',
    '네벨호른',
    '바람결 구릉지',
    '토트리치',
    '리제 폭포',
    '크로나 항구',
    '파르나 숲',
    '페스나르 고원',
    '베르닐 삼림',
    '발란카르 산맥',
    '얼어붙은 바다',
    '칼날바람 언덕',
    '서리감옥 고원',
    '머무른 시간의 호수',
    '얼음나비 절벽',
    '은빛물결 호수',
    '유리연꽃 호수',
    '바람향기 언덕',
    '파괴된 제나일',
    '엘조윈의 그늘',
    '시작의 땅',
    '미완의 정원',
    '검은모루 작업장',
    '무쇠망치 작업장',
    '기약의 땅',
    '칼라자 마을',
    '얕은 바닷길',
    '별모래 해변',
    '티카티카 군락지',
    '비밀의 숲',
    '칸다리아 영지',
    '벨리온 유적지',
    '어금니의 강',
    '웅크린 늑대의 땅',
  ];

  static List<String> getSuggestions(String query) {
    List<String> matches = <String>[];
    matches.addAll(states);
    matches.retainWhere((s) => s.toLowerCase().contains(query.toLowerCase()));
    return matches;
  }
}
