import 'package:flutter/material.dart';

import '../admin/AdminPage.dart';
import 'video/FullScreenVideoPage.dart';
import 'native/HomePagePageView.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Remove the debug banner
      debugShowCheckedModeBanner: false,
      title: '大前端之旅',
      home: const HomePagePageView(),
      initialRoute: "/",
      //名为"/"的路由作为应用的home(首页)
      routes: {
        "/adminPage": (context) => AdaminPage(), //后台首页
        "/fullScreenVideo": (context) => FullScreenVideoPage(), //全屏播放
      },
    );
  }
}