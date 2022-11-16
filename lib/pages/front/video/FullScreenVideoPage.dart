import 'dart:io';

import 'package:flutter/material.dart';
import 'package:happy_sing/db/owner_database_provider.dart';
import 'package:video_player/video_player.dart';

import '../../../model/song_model.dart';

class FullScreenVideoPage extends StatefulWidget {
  const FullScreenVideoPage({Key? key}) : super(key: key);

  @override
  State<FullScreenVideoPage> createState() => _FullScreenVideoPageState();
}

class _FullScreenVideoPageState extends State<FullScreenVideoPage> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;

  var curIndex = 0;

  late Future<List<SongModel>> songs;

  @override
  void initState() {
    super.initState();

    songs = querySongs();

    OwnDatabaseProvider.db.queryOwnerSongs(0, 10000).then((value) => {
      if (value.isNotEmpty) {
        videoPlayerLoad(File(value[0].filePath))
      }
    });
  }

  Future<List<SongModel>> querySongs() async {
    return await OwnDatabaseProvider.db.queryOwnerSongs(0, 10);
  }

  videoPlayerLoad(filePath) {
    _controller = VideoPlayerController.file(filePath)..initialize().then((value) => {
      _controller.play()
    });
  }

  //监听的方法
  void _videoListener() {
    setState(() {
      var curPosition = _controller.value.position;
      var totalPosition = _controller.value.duration;

      var curPos = curPosition.toString().substring(2, 7);
      var totalPos = totalPosition.toString().substring(2, 7);
      print("当前位置$curPos，全部$totalPos");
      //如果当前位置是最后的位置就跳转到下一首歌曲
      if (curPosition.toString() != "0:00:00.000000" && curPosition == totalPosition) {
        // setState(() {
        //   curIndex++;
        //   if (curIndex >= widget.videoList.length) {
        //     //循环回到第一首
        //     curIndex = 0;
        //   }
        //   curId = widget.idList[curIndex];
        // });
      }
    });
  }

  @override
  Widget build(BuildContext context) {


    return MaterialApp(
        home: Scaffold(
            body: Container(
                child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                        alignment: Alignment.bottomCenter,
                        decoration: BoxDecoration(color: Colors.red),
                        child: FutureBuilder(
                          future: songs,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.done) {
                              return AspectRatio(aspectRatio: _controller.value.aspectRatio, child: VideoPlayer(_controller));
                            } else {
                              return const Center(child: CircularProgressIndicator());
                            }
                          },
                        ))))));
  }
}

