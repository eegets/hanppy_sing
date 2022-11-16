import 'dart:io';

import 'package:flutter/material.dart';
import '../../../badge/BadgeUtils.dart';
import '../../../db/owner_database_provider.dart';
import '../../../model/song_model.dart';

///已点歌曲
class OwnedPage {
// 弹出底部菜单列表模态对话框
  static Future<int?> showModalBottomSheet1(BuildContext context) {
    ///查询
    Future<List<SongModel>> queryOwnSongs() async {
      final songs = await OwnDatabaseProvider.db.queryOwnerSongs(0, 10);
      return songs;
    }

    return showModalBottomSheet<int>(
        elevation: 0,
        backgroundColor: Colors.transparent,
        barrierColor: Colors.transparent,
        context: context,
        builder: (context) => StatefulBuilder(
            builder: (context, setState) => BottomSheet(
                onClosing: () {},
                builder: (BuildContext context) {
                  return Container(
                      height: 300,
                      margin: const EdgeInsets.only(left: 260.0),
                      decoration: const BoxDecoration(color: Colors.white54),
                      child: FutureBuilder<List<SongModel>>(
                          future: queryOwnSongs(),
                          builder: (BuildContext context, AsyncSnapshot songData) {
                            switch (songData.connectionState) {
                              case ConnectionState.waiting:
                                {
                                  return const Center(child: CircularProgressIndicator());
                                }
                              case ConnectionState.done:
                                {
                                  if (songData.data == null || songData.data?.length == 0) {
                                    return const Center(
                                      child: Text(style: TextStyle(fontSize: 22), "暂无歌曲，请先添加"),
                                    );
                                  } else {
                                    return ListView.builder(
                                        itemCount: songData.data?.length,
                                        itemBuilder: (BuildContext context, int index) {
                                          String title = songData.data?[index].title;
                                          String filePath = songData.data?[index].thumbNail;
                                          DateTime creationDate = songData.data?[index].creationDate;
                                          String author = songData.data?[index].author;
                                          return Container(
                                              padding: const EdgeInsets.all(10),
                                              decoration: const BoxDecoration(border: Border(bottom: BorderSide(width: 1, color: Color(0xEFEFEFFF)))),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Row(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Image(
                                                        image: FileImage(File(filePath)),
                                                        width: 50,
                                                        height: 50,
                                                        fit: BoxFit.fill,
                                                      ),
                                                      const Padding(padding: EdgeInsets.only(right: 10)),
                                                      Column(
                                                        children: [
                                                          Text(title, style: const TextStyle(color: Colors.black, fontSize: 16, fontFamily: "Courier")),
                                                          const Padding(padding: EdgeInsets.only(top: 10)),
                                                          Text(
                                                            author,
                                                            style: const TextStyle(color: Colors.black26, fontSize: 12),
                                                          ),
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Material(
                                                        color: Colors.transparent,
                                                        shape: const CircleBorder(),
                                                        child: IconButton(
                                                          icon: const Image(
                                                            image: AssetImage("assets/icons/icon_run_top.png"),
                                                          ),
                                                          onPressed: () {
                                                            print("点击了置顶");
                                                            //先删除待置顶的那条，然后再添加到最高位
                                                            OwnDatabaseProvider.db.updateOwnerSong(songData.data?[index].id);
                                                            setState(() =>
                                                            {
                                                              queryOwnSongs(),
                                                            });
                                                          },
                                                        ),
                                                      ),
                                                      Material(
                                                        color: Colors.transparent,
                                                        shape: const CircleBorder(),
                                                        child: IconButton(
                                                          icon: const Image(
                                                            image: AssetImage("assets/icons/icon_run_delete.png"),
                                                          ),
                                                          onPressed: () {
                                                            print("点击了删除");
                                                            OwnDatabaseProvider.db.deleteOwnerSong(songData.data?[index].id);
                                                            setState(() =>
                                                            {
                                                              queryOwnSongs(),
                                                              BadgeUtils.instance.refreshBadge(),
                                                            });
                                                          },
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ));
                                        });
                                  }
                                }
                              default:
                                {
                                  return const Center(child: CircularProgressIndicator());
                                }
                            }
                          }));
                })));
  }
}
