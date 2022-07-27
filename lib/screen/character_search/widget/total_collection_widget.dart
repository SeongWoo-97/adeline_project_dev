import 'package:adeline_app/model/profile/character_profile_provider.dart';
import 'package:adeline_app/model/profile/collection/collectivePoint.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TotalCollectionPerWidget extends StatelessWidget {
  const TotalCollectionPerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CharacterProfileProvider profile = Provider.of<CharacterProfileProvider>(context, listen: false);
    CollectionNormalForm? island = profile.profile.collectivePoint?.mindIsland;
    CollectionNormalForm? leafWorld = profile.profile.collectivePoint?.leafWorld;
    CollectionNormalForm? ignaeaToken = profile.profile.collectivePoint?.ignaeaToken;
    CollectionNormalForm? voyageItem = profile.profile.collectivePoint?.voyageItem;
    CollectionNormalForm? greatWorksArt = profile.profile.collectivePoint?.greatWorksArt;
    CollectionNormalForm? orpheusStar = profile.profile.collectivePoint?.orpheusStar;
    CollectionNormalForm? heartGiant = profile.profile.collectivePoint?.heartGiant;
    CollectionMococoForm? seedMococo = profile.profile.collectivePoint?.seedMococo;
    double width = 25;
    double height = 25;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Column(
                children: [
                  Image.asset(
                    'assets/collection_small_image/1.webp',
                    width: 30,
                    height: 30,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text('${island?.count}')
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Column(
                children: [
                  Image.asset(
                    'assets/collection_small_image/2.webp',
                    width: 30,
                    height: 30,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text('${orpheusStar?.count}')
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Column(
                children: [
                  Image.asset(
                    'assets/collection_small_image/3.webp',
                    width: 30,
                    height: 30,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text('${heartGiant?.count}')
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Column(
                children: [
                  Image.asset(
                    'assets/collection_small_image/4.webp',
                    width: 30,
                    height: 30,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text('${greatWorksArt?.count}')
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Column(
                children: [
                  Image.asset(
                    'assets/collection_small_image/5.webp',
                    width: 30,
                    height: 30,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text('${seedMococo?.count}')
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Column(
                children: [
                  Image.asset(
                    'assets/collection_small_image/6.webp',
                    width: 30,
                    height: 30,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text('${voyageItem?.count}')
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Column(
                children: [
                  Image.asset(
                    'assets/collection_small_image/7.webp',
                    width: 30,
                    height: 30,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text('${ignaeaToken?.count}')
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Column(
                children: [
                  Image.asset(
                    'assets/collection_small_image/8.webp',
                    width: 30,
                    height: 30,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text('${leafWorld?.count}')
                ],
              ),
            ),
          ],
        ),
        Divider(endIndent: 10, indent: 5),
      ],
    );
  }
}
