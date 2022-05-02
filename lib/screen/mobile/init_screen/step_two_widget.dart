import 'package:chips_choice_null_safety/chips_choice_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'controller/initSettings_controller.dart';


class StepTwo extends StatefulWidget {
  @override
  State<StepTwo> createState() => _StepTwoState();
}

class _StepTwoState extends State<StepTwo> {
  @override
  Widget build(BuildContext context) {
    InitSettingsController controller = Provider.of<InitSettingsController>(context);
    List<String> server = controller.servers.keys.toList(); // 서버 목록 (유저가 가지고있는 캐릭터의 서버)
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ChipsChoice<int>.single(
            value: controller.tag,
            onChanged: (val) => controller.tagChange(val),
            choiceItems: C2Choice.listFrom<int, String>(
              source: server,
              value: (i, v) => i,
              label: (i, v) => v,
            ),
            choiceStyle: C2ChoiceStyle(
              showCheckmark: false,
              color: Colors.grey,
              backgroundColor: Colors.white,
              borderColor: Colors.grey,
              borderRadius: BorderRadius.all(Radius.circular(15)),
            ),
            choiceActiveStyle: C2ChoiceStyle(
              color: Colors.black,
              backgroundColor: Colors.white,
              borderColor: Colors.grey,
              borderRadius: BorderRadius.all(Radius.circular(15)),
            ),
          ),
          controller.servers.isNotEmpty == true
              ? Container(
                  height: MediaQuery.of(context).size.height * .72,
                  child: ListView.builder(
                    itemCount: controller.servers[server[controller.tag]]!.length,
                    itemBuilder: (context, index) {
                      return Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7),
                          side: BorderSide(color: Colors.grey, width: 0.8),
                        ),
                        child: ListTile(
                          // title: Text(index.toString()),
                          title: Text(controller.servers[server[controller.tag]]![index].nickName),
                        ),
                      );
                    },
                    shrinkWrap: true,
                  ),
                )
              : Container()
        ],
      ),
    );
  }
}
