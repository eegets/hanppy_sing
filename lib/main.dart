import 'package:flutter/material.dart';
import 'package:happy_sing/pages/front/MyApp.dart';

///命名路由跳转
void main() {
  WidgetsFlutterBinding.ensureInitialized(); //不加这个强制横/竖屏会报错
  runApp(MyApp());
}
