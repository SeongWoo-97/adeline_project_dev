import 'package:adeline_app/screen/merchant_location/controller/merchant_location_controller.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:photo_view/photo_view.dart';

import '../../constant/constant.dart';

class NotMobileMerchantLocationScreen extends StatefulWidget {
  const NotMobileMerchantLocationScreen({Key? key}) : super(key: key);
  @override
  _NotMobileMerchantLocationScreenState createState() => _NotMobileMerchantLocationScreenState();
}

class _NotMobileMerchantLocationScreenState extends State<NotMobileMerchantLocationScreen> {
  final TextEditingController _typeAheadController = TextEditingController();
  SuggestionsBoxController _suggestionsBoxController = SuggestionsBoxController();
  CupertinoSuggestionsBoxController _cupertinoSuggestionsBoxController = CupertinoSuggestionsBoxController();
  List<String> regions = [];
  String selectedItem = '';
  late int selectedContinent;
  late int? selectedRegion = 1;
  Map<String, int> map = {};
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

  }
  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      appBar: PlatformAppBar(
        title: Text('떠돌이 상인 위치'),
      ),
      material: (_, __) => MaterialScaffoldData(
        body: GestureDetector(
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
                  height: MediaQuery.of(context).size.height * 0.8,
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
    );
  }
}


