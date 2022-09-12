import 'package:adeline_app/model/dark_mode/dark_theme_provider.dart';
import 'package:adeline_app/model/toast/toast.dart';
import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:intl/intl.dart';

class DistributionCaluScreen extends StatefulWidget {
  const DistributionCaluScreen({Key? key}) : super(key: key);

  @override
  _DistributionCaluScreenState createState() => _DistributionCaluScreenState();
}

class _DistributionCaluScreenState extends State<DistributionCaluScreen> with AutomaticKeepAliveClientMixin {
  bool fourMembers = false;
  bool eightMembers = false;
  int distributionValue1 = 0;
  int distributionValue2 = 0;
  int getGold = 0;
  int memberNum = 4;
  final key = GlobalKey<FormState>();
  TextEditingController itemPriceController = TextEditingController(text: '0');
  BannerAd bannerAd = BannerAd(
    adUnitId: 'ca-app-pub-2659418845004468/1781199037',
    size: AdSize.banner,
    request: AdRequest(),
    listener: BannerAdListener(),
  );

  @override
  void initState() {
    super.initState();
    bannerAd.load();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return PlatformScaffold(
        appBar: PlatformAppBar(
          title: Text('분배금 계산기'),
        ),
        body: SafeArea(
          child: Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: CustomRadioButton(
                      buttonLables: ['4인', '8인'],
                      buttonValues: [4, 8],
                      radioButtonValue: (values) {
                        setState(() {
                          ToastMessage.toast('$values인 선택');
                          bidPrice(itemPriceController.text, int.parse(values.toString()));
                          memberNum = int.parse(values.toString());
                        });
                      },
                      elevation: 0,
                      defaultSelected: 4,
                      buttonTextStyle: ButtonTextStyle(
                        selectedColor: DarkMode.isDarkMode.value ? Colors.white : Colors.black,
                        unSelectedColor: DarkMode.isDarkMode.value ? Colors.white : Colors.black,
                      ),
                      unSelectedColor: Colors.transparent,
                      selectedColor: DarkMode.isDarkMode.value ? Color(0xFF121212) : Colors.black12,
                      width: MediaQuery.of(context).size.width * 0.45,
                      absoluteZeroSpacing: false,
                      customShape:
                          RoundedRectangleBorder(borderRadius: BorderRadius.circular(8), side: BorderSide(color: Colors.grey)),
                      enableShape: true,
                    ),
                  )
                ],
              ),
              PlatformWidgetBuilder(
                cupertino: (_, child, __) => Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: Form(
                    key: key,
                    child: PlatformTextFormField(
                      controller: itemPriceController,
                      textAlign: TextAlign.center,
                      cupertino: (_, __) => CupertinoTextFormFieldData(
                        keyboardType: TextInputType.number,
                        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(7),
                        ),
                      ),
                      onChanged: (value) {
                        bidPrice(value, memberNum);
                      },
                    ),
                  ),
                ),
                material: (_, child, __) => ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: 45,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(14, 7, 14, 7),
                    child: TextFormField(
                      controller: itemPriceController,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.zero,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: DarkMode.isDarkMode.value ? Colors.white70 : Colors.grey, width: 0.8),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: DarkMode.isDarkMode.value ? Colors.white70 : Colors.grey, width: 0.8),
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      onChanged: (value) {
                        bidPrice(value, memberNum);
                      },
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Card(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Text(
                          '$memberNum인 기준',
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '선점 입찰 적정가 : ',
                                  style: Theme.of(context).textTheme.bodyText1?.copyWith(fontSize: 16),
                                ),
                                Text(
                                  '${getTotalGold(distributionValue1)} Gold',
                                  style: Theme.of(context).textTheme.bodyText1?.copyWith(fontSize: 16),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Flexible(
                                    child: Text(
                                        '본인 - ${getTotalGold((int.parse(itemPriceController.text) - distributionValue1 - (int.parse(itemPriceController.text) * 0.05)).round())} G')),
                                Flexible(child: Text('파티원 - ${getTotalGold((distributionValue1 / (memberNum - 1)).round())} G')),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '파티원 균등 분배 : ',
                                  style: Theme.of(context).textTheme.bodyText1?.copyWith(fontSize: 16),
                                ),
                                Text(
                                  '${getTotalGold(distributionValue2)} Gold',
                                  style: Theme.of(context).textTheme.bodyText1?.copyWith(fontSize: 16),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Flexible(
                                    child: Text(
                                        '본인 - ${getTotalGold(((int.parse(itemPriceController.text) - (int.parse(itemPriceController.text) * 0.05)) / memberNum).round())} G')),
                                Flexible(
                                    child: Text(
                                        '파티원 - ${getTotalGold(((int.parse(itemPriceController.text) - (int.parse(itemPriceController.text) * 0.05)) / memberNum).round())} G')),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              FutureBuilder(
                future: bannerAd.load(),
                builder: (context, snapshot) {
                  return Container(
                    child: AdWidget(ad: bannerAd),
                    width: bannerAd.size.width.toDouble(),
                    height: 60.0,
                    alignment: Alignment.center,
                  );
                },
              ),
            ],
          ),
        ));
  }

  void bidPrice(String price, int memberNum) {
    setState(() {
      int num = (int.parse(price).toDouble() * 0.95 * ((memberNum - 1) / memberNum)).round();
      distributionValue1 = (num / 1.1).round();
      distributionValue2 = num;
    });
  }

  String getTotalGold(int number) {
    return NumberFormat('###,###,###,###').format(number).replaceAll(' ', '');
  }
}
