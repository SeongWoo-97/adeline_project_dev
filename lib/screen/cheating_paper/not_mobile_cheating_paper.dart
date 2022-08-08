import 'package:flutter/material.dart';

class NotMobileCheatingPaperScreen extends StatefulWidget {
  const NotMobileCheatingPaperScreen({Key? key}) : super(key: key);

  @override
  State<NotMobileCheatingPaperScreen> createState() => _NotMobileCheatingPaperScreenState();
}

class _NotMobileCheatingPaperScreenState extends State<NotMobileCheatingPaperScreen> {
  List<String> raidList = ['발탄', '비아키스', '쿠크세이튼', '아브렐슈드(노말)', '아브렐슈드(하드)', '카양겔'];
  String selectedRaid = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('레이드 커닝페이퍼'),
      ),
      body: Row(
        children: [
          Flexible(
            flex: 2,
            child: ListView.builder(
              itemCount: raidList.length,
              itemBuilder: (context, index) {
                return InkWell(
                  child: ListTile(
                    title: Text(
                      '${raidList[index]}',
                      style: selectedRaid == raidList[index] ? TextStyle(fontWeight: FontWeight.bold) : null,
                    ),
                    selected: selectedRaid == raidList[index] ? true : false,
                    enabled: selectedRaid == raidList[index] ? true : false,
                    selectedColor: Colors.white,
                  ),
                  onTap: () {
                    setState(() {
                      selectedRaid = raidList[index];
                    });
                  },
                );
              },
            ),
          ),
          Flexible(
            flex: 9,
            child: Center(child: Image.asset('assets/cheating_paper/${selectedRaid}.png')),
          )
        ],
      ),
    );
  }
}
