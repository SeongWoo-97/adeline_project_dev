import 'package:adeline_app/model/profile/character_profile_provider.dart';
import 'package:adeline_app/model/profile/gem/gem.dart';
import 'package:adeline_app/screen/character_search/controller/slot_Color.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GemSlotWidget extends StatelessWidget {
  const GemSlotWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CharacterProfileProvider profileProvider = Provider.of<CharacterProfileProvider>(context, listen: false);
    List<Gem> gemData = profileProvider.profile.gem!;
    List<Widget> gems = [];
    if (gemData.length != 0) {
      gemData
        ..sort((a, b) {
          return a.title!.substring(0, 1).codeUnits[0].compareTo(b.title!.substring(0, 1).codeUnits[0]);
        });
      gemData = List.from(gemData.reversed);
      gemData.forEach((gem) {
        List<Color> bgColors = slotColor.gradeColors(gem.grade);
        gems.add(
          Flexible(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Lv.${gem.title!.replaceAll(RegExp(r'[^0-9]'), '')}', style: Theme.of(context).textTheme.caption),
                Container(
                  width: 40,
                  height: 25,
                  margin: EdgeInsets.fromLTRB(5, 5, 5, 5),
                  child: ClipOval(child: Image.network('https://cdn-lostark.game.onstove.com/' + gem.imgUrl.toString())),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.transparent),
                    borderRadius: BorderRadius.circular(5),
                    gradient: LinearGradient(
                      end: Alignment.bottomRight,
                      begin: Alignment.topLeft,
                      colors: bgColors,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      });
    }
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: gems,
    );
  }
}
