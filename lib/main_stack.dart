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

  const HomeContent({super.key});
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
      //设置四周间距
      padding: const EdgeInsets.all(20),
      height: 400,
      color: Colors.black12,
      child: Stack(
        children: [
          Container(
            width: 140,
            height: 140,
            color: Colors.green,
          ),
          Container(
            width: 120,
            height: 120,
            color: Colors.red,
          ),
          Container(
            width: 100,
            height: 100,
            color: Colors.blue,
          ),
        ],
      ),
    ));
  }
}
