import 'package:adeline_app/main.dart';
import 'package:adeline_app/model/user/content/restGauge_content.dart';
import 'package:adeline_app/model/user/user.dart';
import 'package:adeline_app/model/user/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

class NotMobileDailyContentsWidget extends StatefulWidget {
  final int characterIndex;

  NotMobileDailyContentsWidget(this.characterIndex);

  @override
  State<NotMobileDailyContentsWidget> createState() => _NotMobileDailyContentsWidgetState();
}

class _NotMobileDailyContentsWidgetState extends State<NotMobileDailyContentsWidget> {
  final box = Hive.box<User>(hiveUserName);

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context, listen: false);
    int characterIndex = widget.characterIndex;
    return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: userProvider.charactersProvider.characters[characterIndex].dailyContents.length,
        itemBuilder: (context, index) {
          if (userProvider.charactersProvider.characters[characterIndex].dailyContents[index] is RestGaugeContent) {
            return InkWell(
              child: restGaugeContentTile(userProvider.charactersProvider.characters[characterIndex].dailyContents[index]),
              onTap: () => userProvider.restGaugeContentClearCheck(characterIndex, index),
            );
          } else if (userProvider.charactersProvider.characters[characterIndex].dailyContents[index].isChecked == true) {
            return InkWell(
              child: Padding(
                padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                child: Card(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                            child: Image.asset(
                                '${userProvider.charactersProvider.characters[characterIndex].dailyContents[index].iconName}',
                                width: 25,
                                height: 25),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                            child: Text(
                              userProvider.charactersProvider.characters[characterIndex].dailyContents[index].name,
                              style: Theme.of(context).textTheme.bodyText2,
                            ),
                          ),
                        ],
                      ),
                      Checkbox(
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        value: userProvider.charactersProvider.characters[characterIndex].dailyContents[index].clearChecked,
                        checkColor: Color.fromRGBO(119, 210, 112, 1),
                        activeColor: Colors.transparent,
                        side: BorderSide(color: Colors.grey, width: 1.5),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3)),
                        onChanged: (bool? value) {
                          userProvider.dailyContentClearCheck(characterIndex, index, value);
                        },
                      )
                    ],
                  ),
                ),
              ),
              onTap: () => userProvider.dailyContentClearCheck(
                  characterIndex, index, !userProvider.charactersProvider.characters[characterIndex].dailyContents[index].clearChecked),
            );
          } else {
            return Container();
          }
        });
  }

  Widget restGaugeContentTile(RestGaugeContent restGaugeContent) {
    if (restGaugeContent.isChecked == false) {
      return Container();
    } else {
      return Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
        child: Card(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                    child: Image.asset('${restGaugeContent.iconName}', width: 25, height: 25),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                    child: Text(
                      restGaugeContent.name,
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                  ),
                ],
              ),
              Container(
                alignment: Alignment.center,
                height: 40,
                child: restGaugeContent.clearNum == restGaugeContent.maxClearNum
                    ? Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Icon(
                          Icons.check,
                          color: Color.fromRGBO(119, 210, 112, 1),
                          size: 20,
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.only(right: 5),
                        child: Text(
                          '${restGaugeContent.clearNum} / ${restGaugeContent.maxClearNum}',
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                      ),
              )
            ],
          ),
        ),
      );
    }
  }
}
