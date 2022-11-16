import 'package:flutter/material.dart';
import 'package:happy_sing/pages/components/PageContentItem.dart';

class AdminPageContent extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AdminPageContentState();
}

class _AdminPageContentState extends State<AdminPageContent> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Column(
          children: [
            Row(
              children: [
                Container(
                    margin: EdgeInsets.all(5),
                    color: Colors.brown,
                    width: 250,
                    height: 250,
                    child: HomePageContentItemWidget.PageContentItem(
                        context, "assets/images/content_bg_1.webp", "添加歌曲",
                        onTap: (BuildContext context, int index) {
                          onTap(context, 0);
                        })),
                Padding(padding: EdgeInsets.all(80)),
                Container(
                  margin: EdgeInsets.only(right: 5),
                  color: Colors.brown,
                  width: 250,
                  height: 250,
                  child: HomePageContentItemWidget.PageContentItem(
                      context, "assets/images/content_bg_2.webp", "添加歌星",
                      onTap: (BuildContext context, int index) {
                        onTap(context, 1);
                      }),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

onTap(BuildContext context, int position) async {
  switch (position) {
    case 0:  //首页
      {
        Navigator.pushNamed(context, "/addSong");
        print("onTap id 111: $position");
      }
      break;
    case 1:  //排行
      {
        print("onTap id 111: $position");
      }
      break;
  }
}
