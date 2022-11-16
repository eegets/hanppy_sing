import 'package:flutter/material.dart';
///文字Text
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

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Center(
        child: Container(
      width: 200,
      height: 300,
      decoration: BoxDecoration(
          color: Colors.cyanAccent,
          border: Border.all(
            color: Colors.blue,
            width: 2,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(10))),
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.fromLTRB(200, 50, 20, 10),
      // transform: Matrix4.rotationZ(1),
      alignment: Alignment.center,
      child: const Text(
        "Unsupported Android Studio version Unsupported Android Studio version Unsupported Android Studio version",
        textAlign: TextAlign.left,
        //left\center\right
        overflow: TextOverflow.ellipsis,
        textScaleFactor: 2,
        //设置文字现实倍率
        style: TextStyle(
          //设置文字颜色
          // color: Colors.red,
          //通过rgb设置颜色
          color: Color.fromARGB(255, 255, 255, 0),
          //设置字体大小
          fontSize: 12,
          //设置文字的粗细程度
          fontWeight: FontWeight.w900,
          //设置字体为斜体
          fontStyle: FontStyle.italic,
          //设置下划线
          decoration: TextDecoration.underline,
          //设置下划线颜色
          decorationColor: Colors.black38,
          //设置下划线为虚线
          decorationStyle: TextDecorationStyle.dashed, //设置下划线为虚线
        ),
        maxLines: 2, //最大行数为2行
      ),
    ));
  }
}
