
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class HomePageNavigationBar extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomePageNavigationBarState();
}

class _HomePageNavigationBarState extends State<HomePageNavigationBar> {
  var leftList, rightList = [""];
  var leftIcons, rightIcons = [""];

  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    leftList = ["首页", "遥控", "气氛", "录音", "静音"];
    leftIcons = [
      "assets/icons/icon_search.png",
      "assets/icons/icon_search.png",
      "assets/icons/icon_search.png",
      "assets/icons/icon_search.png",
      "assets/icons/icon_search.png"
    ];

    rightList = ["暂停", "切歌", "重唱", "原唱", "已点"];
    rightIcons = [
      "assets/icons/icon_search.png",
      "assets/icons/icon_search.png",
      "assets/icons/icon_search.png",
      "assets/icons/icon_search.png",
      "assets/icons/icon_search.png"
    ];
    _controller = VideoPlayerController.network(
        "https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4");

    _initializeVideoPlayerFuture = _controller.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(alignment: AlignmentDirectional.center, children: [
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Container(
          color: Colors.green,
          padding: const EdgeInsets.only(left: 30),
          width: MediaQuery.of(context).size.width / 2,
          child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [getLeftContent(leftList, leftIcons)]),
        ),
        Container(
          color: Colors.blue,
          width: MediaQuery.of(context).size.width / 2,
          padding: const EdgeInsets.only(right: 40),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [getLeftContent(rightList, rightIcons)]),
        ),
      ]),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Image(
              width: 30,
              height: 30,
              image: AssetImage("assets/icons/icon_minus.png")),
          Container(
              width: 130,
              color: Colors.deepOrange,
              child: FutureBuilder(
                future: _initializeVideoPlayerFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return AspectRatio(
                        aspectRatio: _controller.value.aspectRatio,
                        child: VideoPlayer(_controller));
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              )),
          const Image(
              width: 30,
              height: 30,
              image: AssetImage("assets/icons/icon_plus.png"))
        ],
      ),
      ElevatedButton(
          onPressed: () {
            _controller.value.isPlaying
                ? _controller.pause()
                : _controller.play();
          },
          child: Icon(
              _controller.value.isPlaying ? Icons.pause : Icons.play_arrow)),
    ]);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}

Widget getLeftContent(List<String> titles, List<String> icons) {
  List<Widget> listView = [];

  for (var i = 0; i < titles.length; i++) {
    listView.add(Container(
      padding: const EdgeInsets.all(26),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Image(
            width: 30,
            height: 30,
            image: AssetImage("assets/icons/icon_search.png"),
          ),
          const Padding(padding: EdgeInsets.only(bottom: 6)),
          Text(titles[i],
              style: const TextStyle(fontSize: 16, color: Colors.white))
        ],
      ),
    ));
  }
  Widget content = Row(
    children: listView,
  );
  return content;
}
