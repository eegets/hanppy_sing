import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

///图片
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
      home: Scaffold(
        appBar: AppBar(
          title: const Text("测试标题"),
        ),
        body: HomeContent(),
      ),
    );
  }
}

/// 图片
class HomeContent extends StatelessWidget {
  List list = [];

  HomeContent({super.key}) {
    for (var i = 0; i < 10; i++) {
      list.add("这是测试列表，position为$i");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
      color: Colors.amber,
      //设置四周间距
      padding: const EdgeInsets.all(20),
      child: ListView.builder(itemCount: list.length,
          itemBuilder: (context, index) {
        return ListTile(
          leading: const Icon(Icons.verified_user),
          title: Text("${list[index]}"),
        );
      }),
    ));
  }
}
