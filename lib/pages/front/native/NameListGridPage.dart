import 'package:flutter/material.dart';
import 'package:happy_sing/pages/front/native/NameListItemPage.dart';
import 'SearchGridWidget.dart';

///歌名点歌item
class NameListGridPage extends StatefulWidget {
  const NameListGridPage({super.key});

  @override
  State<StatefulWidget> createState() => _NameListGridPageState();
}

class _NameListGridPageState extends State<NameListGridPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          body: Container(
        padding: const EdgeInsets.all(5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Expanded(
              flex: 4,
              child: NameListItemPage(),
            ),
            Expanded(
              flex: 2,
              child: SearchGridViewWidget(
                textFieldInputCallBack: (keyWords) {
                  print("TextFiledCallBack 回调 keyWords: $keyWords");
                },
              ),
            ),
          ],
        ),
      )),
    );
  }
}
