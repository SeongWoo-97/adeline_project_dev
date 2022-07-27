import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class RwdDistributionCaluWidget extends StatefulWidget {
  const RwdDistributionCaluWidget({Key? key}) : super(key: key);

  @override
  State<RwdDistributionCaluWidget> createState() => _RwdDistributionCaluWidgetState();
}

class _RwdDistributionCaluWidgetState extends State<RwdDistributionCaluWidget> {
  bool isFour = false;
  bool isEight = false;
  int distributionValue1 = 0; // 선점 입찰 적정가
  int distributionValue2 = 0; // 파티원 균등 분배
  TextEditingController itemPriceController = TextEditingController(text: '0');

  int price = 0;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    child: Text(
                      '4인',
                      style: Theme.of(context).textTheme.caption,
                    ),
                    style: ElevatedButton.styleFrom(primary: isFour ? Colors.white12 : Colors.black),
                    onPressed: () {
                      setState(() {
                        isFour = true;
                        isEight = false;
                        bidPrice(itemPriceController.text);
                      });
                    },
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    child: Text('8인', style: Theme.of(context).textTheme.caption),
                    style: ElevatedButton.styleFrom(primary: isEight ? Colors.white12 : Colors.black),
                    onPressed: () {
                      setState(() {
                        isFour = false;
                        isEight = true;
                        bidPrice(itemPriceController.text);
                      });
                    },
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
              child: Container(
                height: 40,
                child: TextFormField(
                  controller: itemPriceController,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    hintText: '경매 아이템 가격',
                    hintStyle: Theme.of(context).textTheme.bodyText2?.copyWith(color: Colors.grey),
                  ),
                  onChanged: (value) => bidPrice(value),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Flexible(child: Text('선점 입찰 적정가')),
                  Flexible(
                      child: InkWell(
                          onTap: () async {
                            ClipboardData data = ClipboardData(text: distributionValue1.toString());
                            await Clipboard.setData(data);
                          },
                          child: Text('${getTotalGold(distributionValue1)} G')))
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Flexible(child: Text('파티원 균등 분배')),
                  Flexible(
                      child: InkWell(
                          onTap: () async {
                            ClipboardData data = ClipboardData(text: distributionValue2.toString());
                            await Clipboard.setData(data);
                          },
                          child: Text('${getTotalGold(distributionValue2)} G')))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void bidPrice(String price) {
    setState(() {
      if (isFour) {
        int num = (int.parse(price).toDouble() * 0.95 * ((4 - 1) / 4)).round();
        distributionValue1 = (num / 1.1).round();
        distributionValue2 = num;
      }
      if (isEight) {
        int num = (int.parse(price).toDouble() * 0.95 * ((8 - 1) / 8)).round();
        distributionValue1 = (num / 1.1).round();
        distributionValue2 = num;
      }
    });
  }

  String getTotalGold(int number) {
    return NumberFormat('###,###,###,###').format(number).replaceAll(' ', '');
  }
}
