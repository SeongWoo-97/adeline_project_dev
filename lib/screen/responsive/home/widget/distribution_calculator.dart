import 'package:flutter/material.dart';

class RwdDistributionCaluWidget extends StatefulWidget {
  const RwdDistributionCaluWidget({Key? key}) : super(key: key);

  @override
  State<RwdDistributionCaluWidget> createState() => _RwdDistributionCaluWidgetState();
}

class _RwdDistributionCaluWidgetState extends State<RwdDistributionCaluWidget> {
  bool isFour = false;
  bool isEight = false;

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
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    hintText: '경매 아이템 가격',
                    hintStyle: Theme.of(context).textTheme.bodyText2?.copyWith(color: Colors.grey),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [Flexible(child: Text('선점 입찰 적정가')), Flexible(child: Text('1,732 G'))],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [Flexible(child: Text('파티원 균등 분배')), Flexible(child: Text('1,232 G'))],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
