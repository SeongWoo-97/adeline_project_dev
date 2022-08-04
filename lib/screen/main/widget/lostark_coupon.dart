import 'package:flutter/material.dart';

class RwdCouponWidget extends StatelessWidget {
  const RwdCouponWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 10),
          Text('이벤트 쿠폰 코드', style: Theme.of(context).textTheme.bodyText1),
          Divider(thickness: 1.5,),
          Text('로아와함께하는시원한여름휴가', style: Theme.of(context).textTheme.bodyText1),
          Text('2022.06.25(토)~2022.09.28(수)', style: Theme.of(context).textTheme.caption),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}
