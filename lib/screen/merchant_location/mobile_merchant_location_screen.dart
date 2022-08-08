import 'package:adeline_app/screen/merchant_location/controller/merchant_location_controller.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:photo_view/photo_view.dart';

import '../../constant/constant.dart';

class MobileMerchantLocationScreen extends StatefulWidget {
  const MobileMerchantLocationScreen({Key? key}) : super(key: key);
  @override
  _MobileMerchantLocationScreenState createState() => _MobileMerchantLocationScreenState();
}

class _MobileMerchantLocationScreenState extends State<MobileMerchantLocationScreen> {
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
}


