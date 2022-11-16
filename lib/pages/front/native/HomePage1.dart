import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:happy_sing/pages/admin/AdminPage.dart';
import 'package:happy_sing/pages/front/native/HomePageStatusBar1.dart';
import 'package:happy_sing/pages/front/native/OwnedPage.dart';
import 'package:happy_sing/pages/front/video/FullScreenVideoPage.dart';
import 'package:happy_sing/pages/front/widget/FloatingButtons.dart';
import 'package:video_player/video_player.dart';

import 'NameListGridPage.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Remove the debug banner
      debugShowCheckedModeBanner: false,
      title: '大前端之旅',
      home: const HomePage1(),
      initialRoute: "/",
      //名为"/"的路由作为应用的home(首页)
      routes: {
        "/adminPage": (context) => AdaminPage(), //后台首页
        "/fullScreenVideo": (context) => FullScreenVideoPage(), //全屏播放
      },
    );
  }
}

class HomePage1 extends StatefulWidget {
  const HomePage1({Key? key}) : super(key: key);

  @override
  State<HomePage1> createState() => _HomePage1State();
}

class _HomePage1State extends State<HomePage1> {
  final List<Widget> _mainContents = [
    // Content for Home tab
    NameListGridPage(),
    // Content for Feed tab
    Container(
      color: Colors.purple.shade100,
      alignment: Alignment.center,
      child: const Text(
        'Feed',
        style: TextStyle(fontSize: 40),
      ),
    ),
    // Content for Favorites tab
    Container(
      color: Colors.red.shade100,
      alignment: Alignment.center,
      child: const Text(
        '搜索',
        style: TextStyle(fontSize: 40),
      ),
    ),
    // Content for Settings tab
    Container(
      color: Colors.pink.shade300,
      alignment: Alignment.center,
      child: const Text(
        'Settings',
        style: TextStyle(fontSize: 40),
      ),
    )
  ];

  int _selectedIndex = 0;

  var floatingButton = ["已点", "暂停", "重唱", "原唱", "切歌"];

  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network("https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4");

    _initializeVideoPlayerFuture = _controller.initialize();
  }

  @override
  Widget build(BuildContext context) {
    final key = GlobalObjectKey<ExpandableFabState>(context);

    return Scaffold(
      floatingActionButtonLocation: ExpandableFab.location,
      floatingActionButton: ExpandableFab(
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
                  })),
      appBar: HomePageStatusBar1(
        height: 60,
        onTap: () {
          OwnedPage.showModalBottomSheet1(context);

        },
        onTap1: () {
          Navigator.pushNamed(context, "/adminPage");
        },
      ),
      bottomNavigationBar: MediaQuery.of(context).size.width < 640
          ? BottomNavigationBar(
              currentIndex: _selectedIndex,
              unselectedItemColor: Colors.red,
              selectedItemColor: Colors.indigoAccent,
              // called when one tab is selected
              onTap: (int index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
              // bottom tab items，竖向屏幕的底部tab
              items: const [
                  BottomNavigationBarItem(icon: Icon(Icons.home), label: '歌名点歌'),
                  BottomNavigationBarItem(icon: Icon(Icons.feed), label: '歌星点歌'),
                  BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favorites'),
                  BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings')
                ])
          : null,
      body: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          // Show the navigation rail if screen width >= 640
          if (MediaQuery.of(context).size.width >= 640)
            NavigationRail(
                backgroundColor: Colors.white,
                minWidth: 55.0,
                selectedIndex: _selectedIndex,
                // Called when one tab is selected
                onDestinationSelected: (int index) {
                  setState(() {
                    _selectedIndex = index;
                  });
                },
                labelType: NavigationRailLabelType.all,
                selectedLabelTextStyle: const TextStyle(
                  color: Colors.amber,
                ),
                leading: Column(
                  children: const [ 
                    SizedBox(
                      height: 8,
                    ),
                    CircleAvatar(
                      radius: 20,
                      child: Icon(Icons.person),
                    ),
                  ],
                ),
                unselectedLabelTextStyle: const TextStyle(),
                // navigation rail items，横向屏幕的tab
                destinations: const [
                  NavigationRailDestination(icon: Icon(Icons.home), label: Text('歌名点歌')),
                  NavigationRailDestination(icon: Icon(Icons.feed), label: Text('歌星点歌')),
                  NavigationRailDestination(icon: Icon(Icons.favorite), label: Text('Favorites')),
                  NavigationRailDestination(icon: Icon(Icons.settings), label: Text('11')),
                ],
                trailing: Stack(alignment: AlignmentDirectional.center, children: [
                  Container(
                      width: 70,
                      color: Colors.deepOrange,
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
                        Navigator.pushNamed(context, "/fullScreenVideo");
                      },
                      icon: Icon(
                          _controller.value.isPlaying ? Icons.pause : Icons.play_arrow)),
                  ])
            ),

          // Main content
          // This part is always shown
          // You will see it on both small and wide screen
          Expanded(child: _mainContents[_selectedIndex]),
        ],
      ),
    );
  }
  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
