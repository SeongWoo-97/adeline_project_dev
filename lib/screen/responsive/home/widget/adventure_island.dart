import 'package:flutter/material.dart';

class RwdAdventureIslandWidget extends StatelessWidget {
  const RwdAdventureIslandWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 5),
            Text(
              '모험 섬',
              style: Theme.of(context).textTheme.bodyText1,
            ),
            SizedBox(height: 5),
            Text('2022-06-30 19:00 시작'),
            SizedBox(height: 5),
            Container(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                    child: Image.asset(
                      'assets/adventure_island/우거진 갈대의 섬.jpg',
                      height: 150,
                    ),
                  ),
                  Flexible(
                    child: Image.asset(
                      'assets/adventure_island/우거진 갈대의 섬.jpg',
                      height: 150,
                    ),
                  ),
                  Flexible(
                    child: Image.asset(
                      'assets/adventure_island/우거진 갈대의 섬.jpg',
                      height: 150,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
