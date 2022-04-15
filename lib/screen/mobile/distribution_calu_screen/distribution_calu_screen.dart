import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';

class DistributionCaluScreen extends StatefulWidget {
  const DistributionCaluScreen({Key? key}) : super(key: key);

  @override
  _DistributionCaluScreenState createState() => _DistributionCaluScreenState();
}

class _DistributionCaluScreenState extends State<DistributionCaluScreen> {
  bool fourMembers = false;
  bool eightMembers = false;
  int distributionValue1 = 0;
  int distributionValue2 = 0;
  int getGold = 0;
  int memberNum = 4;
  final key = GlobalKey<FormState>();
  TextEditingController itemPriceController = TextEditingController(text: '0');

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
        appBar: PlatformAppBar(
          title: Text('분배금 계산기', style: Theme.of(context).textTheme.bodyText1),
          material: (_, __) => MaterialAppBarData(
            backgroundColor: Colors.white,
            elevation: .5,
            title: Text(
              '분배금 계산기',
              style:
                  Theme.of(context).textTheme.bodyText1?.copyWith(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
            ),
            centerTitle: true,
          ),
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
                          toast('$values인 선택');
                          bidPrice(itemPriceController.text, int.parse(values.toString()));
                          memberNum = int.parse(values.toString());
                        });
                      },
                      elevation: 0,
                      defaultSelected: 4,
                      buttonTextStyle: ButtonTextStyle(
                        textStyle: Theme.of(context).textTheme.bodyText1,
                        selectedColor: Colors.black,
                        unSelectedColor: Colors.blue,
                      ),
                      unSelectedColor: Colors.transparent,
                      unSelectedBorderColor: Colors.grey,
                      selectedBorderColor: Colors.indigo,
                      selectedColor: Colors.black26,
                      width: MediaQuery.of(context).size.width * 0.453,
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
                          borderSide: BorderSide(color: Colors.grey, width: 0.5),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey, width: 0.5),
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      onChanged: (value) {
                        if (memberNum != null) {
                          bidPrice(value, memberNum);
                        }
                      },
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Card(
                  elevation: 1,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.black26, width: 1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Text(
                          '$memberNum인 기준',
                          style: Theme.of(context).textTheme.bodyText1,
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
                                  '$distributionValue1 Gold',
                                  style: Theme.of(context).textTheme.bodyText1?.copyWith(fontSize: 16),
                                ),
                              ],
                            ),
                            SizedBox(height: 5,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Flexible(child: Text('본인 : ${(int.parse(itemPriceController.text) - distributionValue1 - (int.parse(itemPriceController.text) * 0.05)).round()} Gold')),
                                Flexible(child: Text('파티원 : ${(distributionValue1/(memberNum-1)).round()} Gold')),
                              ],
                            ),
                            SizedBox(height: 10,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '파티원 균등 배분 : ',
                                  style: Theme.of(context).textTheme.bodyText1?.copyWith(fontSize: 16),
                                ),
                                Text(
                                  '$distributionValue2 Gold',
                                  style: Theme.of(context).textTheme.bodyText1?.copyWith(fontSize: 16),
                                ),

                              ],
                            ),
                            SizedBox(height: 5,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Flexible(child: Text('본인 : ${((int.parse(itemPriceController.text) -(int.parse(itemPriceController.text) * 0.05)) / memberNum).round()} Gold')),
                                Flexible(child: Text('파티원 : ${((int.parse(itemPriceController.text) -(int.parse(itemPriceController.text) * 0.05)) / memberNum).round()} Gold')),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  void toast(String msg) {
    Fluttertoast.showToast(
      msg: msg,
      gravity: ToastGravity.CENTER,
      fontSize: 16,
      toastLength: Toast.LENGTH_SHORT,
      textColor: Colors.white,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.grey,
    );
  }

  void bidPrice(String price, int memberNum) {
    setState(() {
      int num = (int.parse(price).toDouble() * 0.95 * ((memberNum - 1) / memberNum)).round();
      distributionValue1 = (num / 1.1).round();
      distributionValue2 = num;
    });
  }
}