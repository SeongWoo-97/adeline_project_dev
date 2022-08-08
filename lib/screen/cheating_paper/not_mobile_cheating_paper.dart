import 'package:flutter/material.dart';

class NotMobileCheatingPaperScreen extends StatefulWidget {
  const NotMobileCheatingPaperScreen({Key? key}) : super(key: key);

  @override
  State<NotMobileCheatingPaperScreen> createState() => _NotMobileCheatingPaperScreenState();
}

class _NotMobileCheatingPaperScreenState extends State<NotMobileCheatingPaperScreen> {
  List<String> raidList = ['발탄', '비아키스', '쿠크세이튼', '아브렐슈드(노말)', '아브렐슈드(하드)', '카양겔'];
  Map<String, List<String>> raidMap = {
    '발탄': ['1관문', '2관문'],
    '비아키스': ['1관문', '2관문', '3관문'],
    '쿠크세이튼': ['1관문', '2관문', '3관문'],
    '아브렐슈드(노말)': ['1관문', '2관문', '3관문', '4관문', '5관문', '6관문'],
    '아브렐슈드(하드)': ['1관문', '2관문', '3관문', '4관문', '5관문', '6관문'],
    '카양겔': ['영원한 빛의 요람'],
  };
  String selectedRaid = '';
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('레이드 공략 요약본'),
        actions: [
          InkWell(
            child: Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(right: 10),
              child: Text('제작자 - 덕진 (블로그 이동)'),
            ),
          ),
        ],
      ),
      body: Row(
        children: [
          Flexible(
            flex: 2,
            child: ListView.builder(
              itemCount: raidMap.length,
              itemBuilder: (context, index) {
                return InkWell(
                  child: ListTile(
                    title: Text(
                      '${raidMap.keys.toList()[index]}',
                      style: selectedRaid == raidMap[index] ? TextStyle(fontWeight: FontWeight.bold) : null,
                    ),
                    selected: selectedRaid == raidMap.keys.toList()[index] ? true : false,
                    enabled: selectedRaid == raidMap.keys.toList()[index] ? true : false,
                    selectedColor: Colors.white,
                  ),
                  onTap: () {
                    setState(() {
                      selectedIndex = 0;
                      selectedRaid = raidMap.keys.toList()[index];
                    });
                  },
                );
              },
            ),
          ),
          Flexible(
            flex: 2,
            child: selectedRaid.length != 0
                ? ListView.builder(
                    itemCount: raidMap[selectedRaid]?.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        child: ListTile(
                          title: Text(
                            '${raidMap[selectedRaid]![index]}',
                          ),
                          selected: selectedIndex == index ? true : false,
                          enabled: selectedIndex == index ? true : false,
                          selectedColor: Colors.white,
                        ),
                        onTap: () {
                          setState(() {
                            selectedIndex = index;
                          });
                        },
                      );
                    },
                  )
                : Container(),
          ),
          Flexible(
            flex: 11,
            child: selectedRaid.length != 0
                ? Center(
                    child: Image.asset(
                    'assets/cheating_paper/${selectedRaid}/${raidMap[selectedRaid]![selectedIndex]}.png',
                      fit: BoxFit.contain,
                      height: double.infinity,
                      width: double.infinity,
                  ))
                : Container(),
          )
        ],
      ),
    );
  }
}
