import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:happy_sing/pages/front/native/OwnedPage.dart';
import 'package:happy_sing/pages/front/video/FullScreenVideoPage.dart';
import 'package:happy_sing/pages/front/widget/FloatingButtons.dart';
import 'package:happy_sing/res/cons/cons.dart';
import 'package:video_player/video_player.dart';

import 'HomePageStatusBar1.dart';
import 'NameListGridPage.dart';

///使用`NavigationRail`实现导航自适应
class HomePagePageView extends StatefulWidget {
  const HomePagePageView({Key? key}) : super(key: key);

  @override
  State<HomePagePageView> createState() => _HomePage1State();
}

class _HomePage1State extends State<HomePagePageView> {
  var floatingButton = ["已点", "暂停", "重唱", "原唱", "切歌"];

  late VideoPlayerController _controller;
  late PageController _pageController;
  late Future<void> _initializeVideoPlayerFuture;

  var _position = 0;

  @override
  void initState() {
    super.initState();

    _pageController = PageController();

    _controller = VideoPlayerController.network("https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4");
    // _controller = VideoPlayerController.file(File("/Users/wangkai/Downloads/mkv/701 无心伤害 - 杜德伟.mp4"));

    _initializeVideoPlayerFuture = _controller.initialize();
  }

  @override
  Widget build(BuildContext context) {
    final key = GlobalObjectKey<ExpandableFabState>(context);
    return Scaffold(
      floatingActionButtonLocation: ExpandableFab.location,
      floatingActionButton: expandFloatingActionButton(key),
      appBar: HomePageStatusBar1(
        height: 60,
        onTap: () {
          OwnedPage.showModalBottomSheet1(context);
        },
        onTap1: () {
          Navigator.pushNamed(context, "/adminPage");
        },
      ),
      body: Row(
        children: [
          leftNav(onTap: (index) {
            setState(() {
              _position = index;
            });
            _pageController.jumpToPage(index);
          }),
          contentPage(),
        ],
      ),
    );
  }

  Widget expandFloatingActionButton(Key key) {
    return ExpandableFab(
        key: key,
        distance: 120,
        childrenOffset: const Offset(14, 14),
        type: ExpandableFabType.left,
        onOpen: () {
          debugPrint('onOpen');
        },
        afterOpen: () {
          debugPrint('afterOpen');
        },
        onClose: () {
          debugPrint('onClose');
        },
        afterClose: () {
          debugPrint('afterClose');
        },
        children: FloatingButtons().getLeftContent(
            floatingButton,
            floatingButton,
                (int index) => {
              if (0 == index)
                {
                  OwnedPage.showModalBottomSheet1(context),
                }
              else if (1 == index)
                {}
              else if (2 == index)
                  {},
              print("点击了ExpandableFab的下标为: $index"),
            }));
  }

  Widget leftNav({required Function(int index) onTap}) {
    _onTapNav(int index) {
      _pageController.jumpToPage(index);
    }

    return Container(
      color: Colors.white70,
      child: Column(
        children: [
          Expanded(
            flex: 1,
            child: Container(),
          ),
          const CircleAvatar(
            radius: 20,
            child: Icon(Icons.person),
          ),
          const Padding(padding: EdgeInsets.only(top: 50)),
          LeftMenuNav(
            itemData: Cons.leftMenuMap,
            onItemClick: _onTapNav,
            color: Colors.blue,
          ),
          Expanded(
            flex: 6,
            child: Container(),
          ),
          Expanded(
              child: Stack(alignment: AlignmentDirectional.center, children: [
                Container(
                    alignment: Alignment.bottomCenter,
                    child: FutureBuilder(
                      future: _initializeVideoPlayerFuture,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          return AspectRatio(aspectRatio: _controller.value.aspectRatio, child: VideoPlayer(_controller));
                        } else {
                          return const Center(child: CircularProgressIndicator());
                        }
                      },
                    )),
                IconButton(
                    onPressed: () {
                      // setState(() {
                      //   _controller.value.isPlaying
                      //       ? _controller.pause()
                      //       : _controller.play();
                      // });
                      // Navigator.pushNamed(context, "/fullScreenVideo");
                      onTap(2);
                    },
                    icon: Icon(_controller.value.isPlaying ? Icons.pause : Icons.play_arrow)),
              ])),
        ],
      ),
    );
  }

  Widget contentPage() {
    return Expanded(
      child: Container(
        child: PageView(
          physics: const NeverScrollableScrollPhysics(),
          //使用PageView实现页面的切换
          controller: _pageController,
          allowImplicitScrolling: true,
          children: <Widget>[
            const NameListGridPage(),
            Container(
              color: Colors.purple.shade100,
              alignment: Alignment.center,
              child: const Text(
                'Feed',
                style: TextStyle(fontSize: 40),
              ),
            ),
            const FullScreenVideoPage(),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    _pageController.dispose();
  }
}

///左侧菜单
class LeftMenuNav extends StatefulWidget {
  final Map<String, IconData> itemData;

  final Function(int) onItemClick;

  final Color color;

  const LeftMenuNav({Key? key, required this.itemData, required this.onItemClick, required this.color}) : super(key: key);

  @override
  State<LeftMenuNav> createState() => _LeftMenuNavState();
}

class _LeftMenuNavState extends State<LeftMenuNav> {
  int _position = 0;

  List<String> get info => widget.itemData.keys.toList();

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisSize: MainAxisSize.min,
        children: info.map((e) => _buildChild(context, info.indexOf(e), widget.color)).toList());
  }

  Widget _buildChild(BuildContext context, int i, Color color) {

    var active = i == _position;

    return InkWell(
        child: Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
            child: Column(children: [
              Icon(widget.itemData[info[i]], color: active ? Colors.blue : Colors.black),
              Text(info[i], style: TextStyle(fontSize: 16, color: active ? Colors.blue : Colors.black)),
            ])),
        onTap: () => _menuOnTap(i)
    );
  }

  _menuOnTap(int index) {
    print("_menuOnTap index: $index");
    setState(() {
      _position = index;
      widget.onItemClick(_position);
    });
  }
}
