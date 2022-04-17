import 'package:adeline_project_dev/constant/constant.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TotalGoldWidget extends StatelessWidget {
  const TotalGoldWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 5, right: 5),
      child: SizedBox(
        width: double.infinity,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
            side: BorderSide(color: Colors.grey, width: 0.8),
          ),
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 5.0),
                  child: Text(
                    'Total Gold',
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                ),
                Row(
                  children: [
                    ValueListenableBuilder(
                      valueListenable: totalGold,
                      builder: (BuildContext context, int value, Widget? child) {
                        return Text(
                          '${NumberFormat('###,###,###,###').format(totalGold.value).replaceAll(' ', '')} G ',
                          style: Theme.of(context).textTheme.bodyText1?.copyWith(fontSize: 14),
                        );
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  String getTotalGold() {
    return NumberFormat('###,###,###,###').format(totalGold.value).replaceAll(' ', '');
  }
}
