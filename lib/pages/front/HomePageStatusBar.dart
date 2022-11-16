import 'package:flutter/material.dart';

class HomePageStatusBar extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomePageStatusBarState();
}

class _HomePageStatusBarState extends State<HomePageStatusBar> {
  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.end, children: [
      Column(
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: const [
                    Image(
                      width:  30,
                      height: 30,
                      image: AssetImage("assets/icons/icon_search.png"),
                    ),
                    Padding(padding: EdgeInsets.only(bottom: 6)),
                    Text("搜索",
                        style: TextStyle(fontSize: 16, color: Colors.white))
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: const [
                    Image(
                      width: 30,
                      height: 30,
                      image: AssetImage("assets/icons/icon_shoucang.png"),
                    ),
                    Padding(padding: EdgeInsets.only(bottom: 6)),
                    Text("收藏",
                        style: TextStyle(fontSize: 16, color: Colors.white)),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: const [
                    Image(
                      width: 30,
                      height: 30,
                      image: AssetImage("assets/icons/icon_scan.png"),
                    ),
                    Padding(padding: EdgeInsets.only(bottom: 6)),
                    Text("扫一扫",
                        style: TextStyle(fontSize: 16, color: Colors.white)),
                  ],
                ),
              ),
              Container(
                  padding: const EdgeInsets.only(
                      left: 20, top: 20, right: 40, bottom: 20),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, "/adminPage");
                    },
                    child: Column(
                      children: const [
                        Image(
                          width: 30,
                          height: 30,
                          image: AssetImage("assets/icons/icon_manager.png"),
                        ),
                        Padding(padding: EdgeInsets.only(bottom: 6)),
                        Text("管理",
                            style:
                                TextStyle(fontSize: 16, color: Colors.white)),
                      ],
                    ),
                  )
              ),
            ],
          )
        ],
      ),
    ]);
  }
}
