import 'package:adeline_app/model/profile/avatar_list/avatar.dart';
import 'package:adeline_app/model/profile/character_profile.dart';
import 'package:adeline_app/model/profile/character_profile_provider.dart';
import 'package:adeline_app/screen/character_search/controller/slot_Color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:provider/provider.dart';

class AvatarOverWidget extends StatelessWidget {
  const AvatarOverWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CharacterProfileProvider profileProvider = Provider.of<CharacterProfileProvider>(context, listen: false);
    CharacterProfile profile = profileProvider.profile;
    List<Avatar?> avatars = [
      profile.avatarList?.overWeapon,
      profile.avatarList?.overHead,
      profile.avatarList?.overTop,
      profile.avatarList?.overBottom,
      profile.avatarList?.overFace,
    ];
    return Flexible(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(5, 0, 0, 5),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: avatarSlotWidget(context, avatars),
        ),
      ),
    );
  }

  List<Widget> avatarSlotWidget(BuildContext context, List<Avatar?> avatars) {
    List<Widget> list = [];

    for (int i = 0; i < avatars.length; i++) {
      if (avatars[i] != null) {
        Color nameColor = slotColor.itemNameColor(avatars[i]!.grade);
        List<Color> bgColors = slotColor.gradeColors(avatars[i]!.grade);
        list.add(
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 7),
            child: InkWell(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        'https://cdn-lostark.game.onstove.com/' + avatars[i]!.itemTitle!.imgUrl.toString(),
                      ),
                    ),
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
                  Flexible(
                    child: Container(
                      height: 40,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 5),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                avatars[i]!.itemTitle!.parts.toString(),
                                style: Theme.of(context).textTheme.caption?.copyWith(height: 1.2, color: nameColor),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 5),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                avatars[i]!.name.toString(),
                                style: Theme.of(context).textTheme.caption?.copyWith(height: 1.2, color: nameColor),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              onTap: () {
                showPlatformDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        contentPadding: const EdgeInsets.fromLTRB(10, 20, 10, 5),
                        content: SingleChildScrollView(
                          child: Container(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 10),
                                  child: Center(
                                    child: Text(
                                      avatars[i]!.name.toString(),
                                      style: Theme.of(context).textTheme.bodyText1?.copyWith(color: nameColor),
                                    ),
                                  ),
                                ),
                                Flexible(
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 7),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        // 기본효과
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            Container(
                                              width: 50,
                                              height: 50,
                                              child: ClipRRect(
                                                borderRadius: BorderRadius.circular(8),
                                                child: Image.network(
                                                  'https://cdn-lostark.game.onstove.com/' +
                                                      avatars[i]!.itemTitle!.imgUrl.toString(),
                                                ),
                                              ),
                                              decoration: BoxDecoration(
                                                border: Border.all(color: Colors.grey),
                                                borderRadius: BorderRadius.circular(8),
                                                gradient: LinearGradient(
                                                  end: Alignment.topLeft,
                                                  begin: Alignment.bottomRight,
                                                  colors: bgColors,
                                                ),
                                              ),
                                            ),
                                            Flexible(
                                              child: Container(
                                                height: 50,
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets.only(left: 5),
                                                      child: Align(
                                                        alignment: Alignment.topLeft,
                                                        child: Text(
                                                          avatars[i]!.itemTitle!.parts.toString(),
                                                          style: Theme.of(context).textTheme.caption?.copyWith(
                                                            height: 1.2,
                                                            color: nameColor,
                                                          ),
                                                          overflow: TextOverflow.ellipsis,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(top: 5),
                                          child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              '기본 효과',
                                              style: Theme.of(context).textTheme.bodyText2?.copyWith(
                                                color: Color(0xFFA9D0F5),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Flexible(
                                          child: Container(
                                              width: double.maxFinite,
                                              child: Text(avatars[i]!.avatarEffect!.basicEffect!,
                                                  style: Theme.of(context).textTheme.caption)
                                          ),
                                        ),
                                        // 추가효과
                                        Padding(
                                          padding: const EdgeInsets.only(top: 5),
                                          child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              '성향',
                                              style: Theme.of(context).textTheme.bodyText2?.copyWith(
                                                color: Color(0xFFA9D0F5),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Flexible(
                                          child: Container(
                                            width: double.maxFinite,
                                            child: ListView.builder(
                                                itemCount: avatars[i]!.avatarEffect!.plusEffect?.length,
                                                shrinkWrap: true,
                                                physics: NeverScrollableScrollPhysics(),
                                                itemBuilder: (context, index) {
                                                  return Text(avatars[i]!.avatarEffect!.plusEffect![index],
                                                      style: Theme.of(context).textTheme.caption);
                                                }),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    });
              },
            ),
          ),
        );
      } else {
        list.add(Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 7),
          child: InkWell(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 44,
                  height: 44,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset('assets/emptySlot/avatar/over/$i.png'),
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.transparent),
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                Flexible(
                  child: Container(
                    height: 40,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 5),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              '장착된 아이템 없음',
                              style: Theme.of(context).textTheme.caption?.copyWith(
                                    height: 1.2,
                                  ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
            onTap: () {},
          ),
        ));
      }
    }
    return list;
  }
}
