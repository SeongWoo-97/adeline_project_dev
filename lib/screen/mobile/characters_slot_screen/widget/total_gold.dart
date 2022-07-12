import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../model/user/user_provider.dart';

class TotalGoldWidget extends StatelessWidget {
  const TotalGoldWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context, listen: false);

    return Card(
      margin: const EdgeInsets.fromLTRB(5, 5, 5, 5),
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
            Consumer<UserProvider>(
              builder: (context, instance, child) {
                return Row(
                  children: [
                    Text(
                      '${NumberFormat('###,###,###,###').format(userProvider.updateTotalGold()).replaceAll(' ', '')} G ',
                      style: Theme.of(context).textTheme.bodyText1?.copyWith(fontSize: 14),
                    ),
                  ],
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
