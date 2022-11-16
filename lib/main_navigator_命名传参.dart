import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

///命名路由跳转
void main() {
  WidgetsFlutterBinding.ensureInitialized(); //不加这个强制横/竖屏会报错
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: "命名路由跳转",
      home: const HomePage(),
      initialRoute:"/", //名为"/"的路由作为应用的home(首页)
      routes: {
        "/search" : (context) => SearchPage(),
        "/about": (context) => AboutPage(),
      },
    );
  }
}

/// 命名路由跳转
class HomePage extends StatelessWidget {

  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("路由跳转测试页面")),
      body: ListView(children: [
        ElevatedButton(onPressed: () {
          Navigator.pushNamed(
            context,
           "/search",
            arguments: "给搜索页面传递的参数"
          );
        },
        child: const Text("进入搜索页面"),),
        ElevatedButton(onPressed: () {
          Map<String, String> map = {"key": "这是Map传递的参数"}; //传递map
          Navigator.pushNamed(
            context,
            "/about",
            arguments: map
          );
        },
          child: const Text("进入About页面"),)
      ],),
    );
  }
}

class SearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)?.settings.arguments;
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: const Text("跳转后的搜索页面")),
      body: Container(
        child: Text("这是传递过来的参数 msg： $args"),
      ),
    );
  }
}

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Map<String, String> args = ModalRoute.of(context)?.settings.arguments as Map<String, String>;
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: const Text("跳转后的搜索页面")),
      body: Container(
        child: Text("这是传递过来的参数 msg： ${args["key"]}"),
      ),
    );
  }
}
