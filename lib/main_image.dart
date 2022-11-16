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
        body: const HomeContent(),
      ),
    );
  }
}

/// 图片
class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
      color: Colors.amber,
      //设置四周间距
      padding: const EdgeInsets.all(20),
      width: 300,
      height: 400,
      // child: Image.network(
      //   //夹在网络图片
      //   "https://img0.baidu.com/it/u=4287157708,2952269621&fm=253&fmt=auto&app=138&f=JPEG?w=499&h=333",
      //   //设置图片的填充样式
      //   fit: BoxFit.fill,
      // ),
      child: Image.asset("../assets/images/image.jpeg"),
    ));
  }
}
