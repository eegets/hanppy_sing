
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:video_compress/video_compress.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    setPermission();
  }

  File videoFilePath = File("");
  String videoFilePath111 = "";

  getVideoInfo() async {
    final info = await VideoCompress.getMediaInfo(
        "/storage/emulated/0/zhihu/shijiannihao.mkv");
    setState(() {
      videoFilePath111 = "duration: ${info.duration}; author: ${info.author}; file: ${info.file}; title:${info.title}; width: ${info.width}";
      print("info------11----:${videoFilePath111}");
    });
    // videoFilePath111 = "duration: ${info.duration}; author: ${info.author}; file: ${info.file}; title:${info.title}; width: ${info.width}";
    // print("info------11----:${videoFilePath111}");

    final aaa = await VideoCompress.getFileThumbnail("/storage/emulated/0/zhihu/shijiannihao.mkv");
    videoFilePath = aaa;

  }

  setPermission() async {
    if (await Permission.storage.request().isGranted) {
      //判断是否授权,没有授权会发起授权
      print("获得了授权");
      setState(() {
      });
    } else {
      print("没有获得授权");
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton.extended(
            backgroundColor: Colors.white,
            label: Text(
              "Get Info",
              style: TextStyle(color: Colors.black),
            ),
            icon: Icon(
              Icons.video_call_outlined,
              color: Colors.purple,
            ),
            onPressed: () {
              getVideoInfo();
            }),
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.purple,
          title: const Text('Video Info'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(1.0),
          child: Column(
            children: [
              Text(
                videoFilePath111,
                style: TextStyle(fontSize: 10),
              ),
              Image.file(videoFilePath, width: 10, height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
