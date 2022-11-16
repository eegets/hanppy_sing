import 'package:flutter/material.dart';
import 'package:happy_sing/pages/components/PageContentItem.dart';

class HomePageContent extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomePageContentState();
}

class _HomePageContentState extends State<HomePageContent> {
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
                    width: 150,
                    height: 250,
                    child: HomePageContentItemWidget.PageContentItem(
                        context, "assets/images/content_bg_1.webp", "首页",
                        onTap: (BuildContext context, int index) {
                      onTap(context, 0);
                    })),
                Container(
                  margin: EdgeInsets.only(right: 5),
                  color: Colors.brown,
                  width: 150,
                  height: 250,
                  child: HomePageContentItemWidget.PageContentItem(
                      context, "assets/images/content_bg_2.webp", "排行",
                      onTap: (BuildContext context, int index) {
                    onTap(context, 1);
                  }),
                ),
              ],
            ),
            Container(
              color: Colors.brown,
              width: 305,
              height: 150,
              child: HomePageContentItemWidget.PageContentItem(
                  context, "assets/images/content_bg.webp", "热门",
                  onTap: (BuildContext context, int index) {
                onTap(context, 2);
              }),
            ),
          ],
        ),
        Container(
          margin: EdgeInsets.only(top: 5),
          color: Colors.brown,
          width: 250,
          height: 405,
          child: HomePageContentItemWidget.PageContentItem(
              context, "assets/images/content_bg_2.webp", "歌星",
              onTap: (BuildContext context, int index) {
            onTap(context, 3);
          }),
        ),
        Column(
          children: [
            Container(
              margin: EdgeInsets.only(left: 5, top: 5),
              color: Colors.brown,
              width: 180,
              height: 132,
              child: HomePageContentItemWidget.PageContentItem(
                  context, "assets/images/content_bg.webp", "分类",
                  onTap: (BuildContext context, int index) {
                onTap(context, 4);
              }),
            ),
            Container(
              margin: EdgeInsets.only(left: 5, top: 5),
              color: Colors.brown,
              width: 180,
              height: 131,
              child: HomePageContentItemWidget.PageContentItem(
                  context, "assets/images/content_bg.webp", "舞曲",
                  onTap: (BuildContext context, int index) {
                onTap(context, 5);
              }),
            ),
            Container(
              margin: EdgeInsets.only(left: 5, top: 5),
              color: Colors.brown,
              width: 180,
              height: 132,
              child: HomePageContentItemWidget.PageContentItem(
                  context, "assets/images/content_bg.webp", "云端",
                  onTap: (BuildContext context, int index) {
                onTap(context, 6);
              }),
            ),
          ],
        ),
        Column(
          children: [
            Container(
              margin: EdgeInsets.only(left: 5, top: 5),
              color: Colors.brown,
              width: 180,
              height: 200,
              child: HomePageContentItemWidget.PageContentItem(
                  context, "assets/images/content_bg_2.webp", "新歌",
                  onTap: (BuildContext context, int index) {
                onTap(context, 7);
              }),
            ),
            Container(
              margin: EdgeInsets.only(left: 5, top: 5),
              color: Colors.brown,
              width: 180,
              height: 200,
              child: HomePageContentItemWidget.PageContentItem(
                  context, "assets/images/content_bg_2.webp", "高清",
                  onTap: (BuildContext context, int index) {
                onTap(context, 8);
              }),
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
        Navigator.pushNamed(context, "/songNameList");
        print("onTap id 111: $position");
      }
      break;
    case 1:  //排行
      {
        print("onTap id 111: $position");
      }
      break;
    case 2:  //热门
      {
        print("onTap id 22: $position");
      }
      break;
    case 3:  //歌星
      {
        print("onTap id: $position");
      }
      break;
    case 4:  //分类
      {
        print("onTap id: $position");
      }
      break;
    case 5:  //舞曲
      {
        print("onTap id: $position");
      }
      break;
    case 6:  //云端
      {
        print("onTap id: $position");
      }
      break;
    case 7:  //新歌
      {
        print("onTap id: $position");
      }
      break;
    case 8:  //高清
      {
        print("onTap id: $position");
      }
      break;
  }
}
