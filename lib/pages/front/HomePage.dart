import 'package:flutter/material.dart';
import 'package:happy_sing/pages/front/HomePageContent.dart';
import 'package:happy_sing/pages/front/HomePageStatusBar.dart';
import 'package:happy_sing/pages/front/detail/NameListPage.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../front/HomePageNavigationBar.dart';
import '../admin/SongStarListPage.dart';
import '../admin/AddSongPage.dart';
import '../admin/AdminPage.dart';
class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setPermission();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          body: Container(
              decoration: const BoxDecoration(
                color: Colors.black87,
              ),
              child: Column(
                children: [
                  HomePageStatusBar(),
                  HomePageContent(),
                ],
              )),
          bottomNavigationBar: Container(
            height: 125,
            color: Colors.black45,
            child: HomePageNavigationBar(),
          )),
      initialRoute: "/", //名为"/"的路由作为应用的home(首页)
      routes: {
        "/adminPage" : (context) => AdaminPage(), //后台首页
        "/songNameList": (context) => NameListPage(), //前端歌名列表页面
        "/SongStarList": (context) => SongStarListPage(),  //歌星查询列表
        "/addSong": (context) => AddSongPage(),  //添加歌曲
      },
    );
  }

  setPermission() async {
    if (await Permission.storage.request().isGranted) {
      //判断是否授权,没有授权会发起授权
      print("获得了授权");
    } else {
      print("没有获得授权");
    }
  }
}