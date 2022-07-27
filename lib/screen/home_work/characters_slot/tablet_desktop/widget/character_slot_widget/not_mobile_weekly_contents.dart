import 'package:adeline_app/main.dart';
import 'package:adeline_app/model/user/user.dart';
import 'package:adeline_app/model/user/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';


class NotMobileWeeklyContentsWidget extends StatefulWidget {
  final int characterIndex;
  const NotMobileWeeklyContentsWidget(this.characterIndex);

  @override
  State<NotMobileWeeklyContentsWidget> createState() => _NotMobileWeeklyContentsWidgetState();
}

class _NotMobileWeeklyContentsWidgetState extends State<NotMobileWeeklyContentsWidget> {
  final box = Hive.box<User>(hiveUserName);

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context, listen: false);
    int characterIndex = widget.characterIndex;
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: userProvider.charactersProvider.characters[characterIndex].weeklyContents.length,
      itemBuilder: (context, index) {
        if (userProvider.charactersProvider.characters[characterIndex].weeklyContents[index].isChecked == true) {
          return Padding(
            padding: const EdgeInsets.only(left: 10, right: 10,bottom: 10),
            child: InkWell(
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                  side: BorderSide(color: Colors.grey, width: 0.8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                          child: Image.asset('${userProvider.charactersProvider.characters[characterIndex].weeklyContents[index].iconName}',
                              width: 25, height: 25),
                        ),
                        Text(
                          userProvider.charactersProvider.characters[characterIndex].weeklyContents[index].name,
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                      ],
                    ),
                    Container(
                      width: 40,
                      height: 40,
                      child: Checkbox(
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        value: userProvider.charactersProvider.characters[characterIndex].weeklyContents[index].clearChecked,
                        checkColor: Color.fromRGBO(119, 210, 112, 1),
                        activeColor: Colors.transparent,
                        side: BorderSide(color: Colors.grey, width: 1.5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(3),
                        ),
                        onChanged: (bool? value) {
                          userProvider.weeklyContentClearCheck(characterIndex, index, value);
                        },
                      ),
                    )
                  ],
                ),
              ),
              onTap: () {
                userProvider.weeklyContentClearCheck(characterIndex, index,
                    !userProvider.charactersProvider.characters[characterIndex].weeklyContents[index].clearChecked);
              },
            ),
          );
        } else {
          return Container();
        }
      },
    );

  }
}
