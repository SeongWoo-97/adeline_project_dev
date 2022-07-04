import 'package:flutter/material.dart';

class ProcyonCompassWidget extends StatelessWidget {
  const ProcyonCompassWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.contain,
      child: Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 5,
            ),
            Text('프로키온 나침반 일정', style: Theme.of(context).textTheme.bodyText2),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 5, 5, 5),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '월',
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      SizedBox(height: 10),
                      Image.asset('assets/procyon_compass/chaos_gate.png', width: 45, height: 45),
                      SizedBox(height: 5),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 5, 5, 5),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '화',
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      SizedBox(height: 10),
                      Image.asset('assets/procyon_compass/field_boss.png', width: 45, height: 45),
                      SizedBox(height: 10),
                      Image.asset('assets/procyon_compass/ghost_ship.png', width: 45, height: 45),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 5, 5, 5),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '수',
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      SizedBox(
                        height: 45,
                        width: 45,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 5, 5, 5),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '목',
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      SizedBox(height: 10),
                      Image.asset('assets/procyon_compass/chaos_gate.png', width: 45, height: 45),
                      SizedBox(height: 10),
                      Image.asset('assets/procyon_compass/ghost_ship.png', width: 45, height: 45),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 5, 5, 5),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '금',
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      SizedBox(height: 10),
                      Image.asset('assets/procyon_compass/field_boss.png', width: 45, height: 45),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 5, 5, 5),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '토',
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      SizedBox(height: 10),
                      Image.asset('assets/procyon_compass/ghost_ship.png', width: 45, height: 45),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 5, 5, 5),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '일',
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      SizedBox(height: 10),
                      Image.asset('assets/procyon_compass/chaos_gate.png', width: 45, height: 45),
                      SizedBox(height: 10),
                      Image.asset('assets/procyon_compass/field_boss.png', width: 45, height: 45),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
