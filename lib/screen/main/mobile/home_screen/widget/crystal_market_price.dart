import 'dart:convert';

import 'package:adeline_app/model/crystal_price/crystal_price.dart';
import 'package:adeline_app/model/dark_mode/dark_theme_provider.dart';
import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';


class CrystalMarketPriceWidget extends StatefulWidget {
  @override
  State<CrystalMarketPriceWidget> createState() => _CrystalMarketPriceWidgetState();
}

class _CrystalMarketPriceWidgetState extends State<CrystalMarketPriceWidget> {
  final AsyncMemoizer _memoizer = AsyncMemoizer();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(1, 0, 1, 5),
      child: FutureBuilder(
        future: fetchCrystalMarketPrice(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData == true) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Row(
                children: [
                  Flexible(
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                        side: BorderSide(color: DarkMode.isDarkMode.value ? Colors.grey : Colors.black, width: .5),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(5, 7, 10, 7),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(3, 0, 0, 0),
                                  child: Text('크리스탈 구매 ', style: Theme.of(context).textTheme.bodyText2),
                                ),
                              ],
                            ),
                            Padding(
                                padding: const EdgeInsets.fromLTRB(7, 0, 0, 0),
                                child: Text('${NumberFormat('###,###').format(int.parse(snapshot.data!.buy))} G',
                                    style: Theme.of(context).textTheme.bodyText2)),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                        side: BorderSide(color: DarkMode.isDarkMode.value ? Colors.grey : Colors.black, width: .5),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(5, 7, 10, 7),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(3, 0, 0, 0),
                                  child: Text('크리스탈 판매 ', style: Theme.of(context).textTheme.bodyText2),
                                ),
                              ],
                            ),
                            Padding(
                                padding: const EdgeInsets.fromLTRB(7, 0, 0, 0),
                                child: Text('${NumberFormat('###,###').format(int.parse(snapshot.data!.sell))} G',
                                    style: Theme.of(context).textTheme.bodyText2)),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }
          }
          return Row(
            children: [
              Flexible(
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                    side: BorderSide(color: DarkMode.isDarkMode.value ? Colors.grey : Colors.black, width: .5),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(5, 7, 10, 7),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(3, 0, 0, 0),
                              child: Text('크리스탈 구매 ', style: Theme.of(context).textTheme.bodyText2),
                            ),
                          ],
                        ),
                        Padding(
                            padding: const EdgeInsets.fromLTRB(7, 0, 0, 0),
                            child: Text('0 G', style: Theme.of(context).textTheme.bodyText2)),
                      ],
                    ),
                  ),
                ),
              ),
              Flexible(
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                    side: BorderSide(color: DarkMode.isDarkMode.value ? Colors.grey : Colors.black, width: .5),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(5, 7, 10, 7),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(3, 0, 0, 0),
                              child: Text('크리스탈 판매 ', style: Theme.of(context).textTheme.bodyText2),
                            ),
                          ],
                        ),
                        Padding(
                            padding: const EdgeInsets.fromLTRB(7, 0, 0, 0),
                            child: Text('0 G', style: Theme.of(context).textTheme.bodyText2)),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Future<dynamic> fetchCrystalMarketPrice() async {
    return this._memoizer.runOnce(() async {
      try {
        http.Response response = await http.get(Uri.parse('http://152.70.248.4:5000/crystal/'));
        Map<String, dynamic> json = jsonDecode(response.body);
        print('... : $json');
        CrystalPrice crystalPrice = CrystalPrice.fromJson(json);
        return crystalPrice;
      } catch (e) {
        Future.delayed(Duration(seconds: 10), () {
          print('재접속');
          fetchCrystalMarketPrice();
          setState(() {});
        });
      }
    });
  }
}
