import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:happy_sing/event/EventBus.dart';
import 'package:happy_sing/event/EventKey.dart';

class HomePageStatusBar1 extends StatefulWidget implements PreferredSizeWidget {
  HomePageStatusBar1({
    Key? key,
    this.height = 60,
    required this.onTap,
    required this.onTap1,
  }) : super(key: key);

  // 点击回调
  VoidCallback? onTap;
  VoidCallback? onTap1;
  // Function(int index) onTap;
  // Function(BuildContext context, int index) onTap;

  // 输入框高度 默认60
  final double height;

  @override
  State<StatefulWidget> createState() => _HomePageStatusBarState1();

  @override
  Size get preferredSize => Size.fromHeight(height);
}

class _HomePageStatusBarState1 extends State<HomePageStatusBar1> {

  var _count = 0;

  @override
  Widget build(BuildContext context) {
    bus.on(REFRESH_BADGE, (arg) {
      setState(() {
        _count = arg;
      });
      print("queryOwnerSongsCount bus on count: $arg");
    });

    return Row(mainAxisAlignment: MainAxisAlignment.end, children: [
      Container(
        padding: const EdgeInsets.only(right: 20),
        child: GestureDetector(
          onTap: widget.onTap,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Badge(
            // position: BadgePosition.topEnd(top: 0, end: -10),
                animationType: BadgeAnimationType.scale,  //动画效果
                badgeContent: Text(_count.toString(), style: const TextStyle(color: Colors.white, fontSize: 12)),
                child: const Image(
                width: 25,
                height: 25,
                image: AssetImage("assets/icons/icon_cart.png"),
              ),),
              const Text("已点歌曲", style: TextStyle(fontSize: 15, color: Colors.black))
            ],
          ),
        ),
      ),
      Container(
        padding: const EdgeInsets.only(right: 20),
        child: GestureDetector(
          onTap: widget.onTap1,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Image(
                width: 25,
                height: 25,
                image: AssetImage("assets/icons/icon_cart.png"),
              ),
              Text("歌曲管理", style: TextStyle(fontSize: 15, color: Colors.black))
            ],
          ),
        ),
      ),
    ]);
  }
}
