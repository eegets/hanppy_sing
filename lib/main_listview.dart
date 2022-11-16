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
      child: ListView(
        children: const <Widget>[
          ListTile(
            leading: Icon(Icons.phone),
            title: Text("这是标题"),
            subtitle: Text("这是一个副标题"),
            trailing: Icon(Icons.arrow_right),
          ),
          ListTile(
            leading: Icon(Icons.phone),
            title: Text("这是标题"),
            subtitle: Text("这是一个副标题"),
            trailing: Icon(Icons.arrow_right),
          ),
          ListTile(
            leading: Icon(Icons.phone),
            title: Text("这是标题"),
            subtitle: Text("这是一个副标题"),
            trailing: Icon(Icons.arrow_right),
          ),
          ListTile(
            leading: Icon(Icons.phone),
            title: Text("这是标题"),
            subtitle: Text("这是一个副标题"),
            trailing: Icon(Icons.arrow_right),
          ),
          ListTile(
            leading: Icon(Icons.phone),
            title: Text("这是标题"),
            subtitle: Text("这是一个副标题"),
            trailing: Icon(Icons.arrow_right),
          ),
          ListTile(
            leading: Icon(Icons.phone),
            title: Text("这是标题"),
            subtitle: Text("这是一个副标题"),
            trailing: Icon(Icons.arrow_right),
          ),
          ListTile(
            leading: Icon(Icons.phone),
            title: Text("这是标题"),
            subtitle: Text("这是一个副标题"),
            trailing: Icon(Icons.arrow_right),
          ),
        ],
      )
    ));
  }
}
