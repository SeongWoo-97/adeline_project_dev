import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../model/user/user_provider.dart';
class WeeklyContentsWidget extends StatefulWidget {
  final int characterIndex;
  const WeeklyContentsWidget(this.characterIndex);

  @override
  State<WeeklyContentsWidget> createState() => _WeeklyContentsWidgetState();
}

class _WeeklyContentsWidgetState extends State<WeeklyContentsWidget> {
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
          return InkWell(
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
                            width: 22, height: 22),
                      ),
                      Container(
                        child: Text(
                          userProvider.charactersProvider.characters[characterIndex].weeklyContents[index].name,
                          style: Theme.of(context).textTheme.bodyText1?.copyWith(fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                  Checkbox(
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    value: userProvider.charactersProvider.characters[characterIndex].weeklyContents[index].clearChecked,
                    checkColor: Color.fromRGBO(119, 210, 112, 1),
                    activeColor: Colors.transparent,
                    side: BorderSide(color: Colors.grey, width: 1.5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(3),
                    ),
                    onChanged: (bool? value) {
                      setState(() {
                        userProvider.charactersProvider.characters[characterIndex].weeklyContents[index].clearChecked =
                        !userProvider.charactersProvider.characters[characterIndex].weeklyContents[index].clearChecked;
                      });
                    },
                  )
                ],
              ),
            ),
            onTap: () {
              setState(() {
                userProvider.charactersProvider.characters[characterIndex].weeklyContents[index].clearChecked =
                !userProvider.charactersProvider.characters[characterIndex].weeklyContents[index].clearChecked;
              });
            },
          );
        } else {
          return Container();
        }
      },
    );

  }
}
