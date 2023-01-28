import 'package:flutter/material.dart';
import 'package:happy_sing/badge/BadgeUtils.dart';
import 'dart:io';

import '../../../db/database_provider.dart';
import '../../../db/owner_database_provider.dart';
import '../../../model/song_model.dart';

class NameListItemPage extends StatefulWidget {
  const NameListItemPage({Key? key}) : super(key: key);

  @override
  State<NameListItemPage> createState() => _NameListItemPageState();
}

class _NameListItemPageState extends State<NameListItemPage> {
  //getting all songs
  Future<List<SongModel>> querySongs() async {
    final songs = await DatabaseProvider.db.querySongs(0, 40);
    return songs;
  }

  @override
  void initState() {
    super.initState();
    BadgeUtils.instance.refreshBadge();
  }

  //item的点击事件
  clickItem(SongModel model) {
    if (model == null) return;
    saveDB(model);
    BadgeUtils.instance.refreshBadge();
  }


  saveDB(SongModel model) async {
    model.id = null;
    OwnDatabaseProvider.db.addOwnerSong(model);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<SongModel>>(
      future: querySongs(),
      builder: (BuildContext context, AsyncSnapshot songData) {
        switch (songData.connectionState) {
          case ConnectionState.waiting:
            {
              return Center(child: CircularProgressIndicator());
            }
          case ConnectionState.done:
            {
              print("songData: ${songData.data?.length}");
              //let`s check that we didn`t get a null
              if (songData.data == null || songData.data?.length == 0) {
                return const Center(
                  child: Text(style: TextStyle(fontSize: 22), "暂无歌曲，请先添加"),
                );
              } else {
                return Padding(
                  padding: EdgeInsets.all(8),
                  child: GridView.builder(
                    //Container跟随GridView内容变化高度, shrinkWrap:true;
                      shrinkWrap: true,
                      //取消滚动效果physics: NeverScrollableScrollPhysics();
                      // physics: NeverScrollableScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        //横轴元素个数
                          crossAxisCount: 3,
                          //纵轴间距
                          mainAxisSpacing: 10.0,
                          //横轴间距
                          crossAxisSpacing: 10.0,
                          //子组件宽高长度比例
                          childAspectRatio: 2.5),
                      itemCount: songData.data?.length,
                      itemBuilder: (context, index) {
                        //setting the different items
                        String title = songData.data?[index].title;
                        String filePath = songData.data?[index].thumbNail;
                        DateTime creationDate = songData.data?[index].creationDate;
                        String author = songData.data?[index].author;
                        return InkWell(
                            onTap: () async {
                              clickItem(songData.data[index]);
                            },
                            child: Ink(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(Radius.circular(6.0)),
                              ),
                              padding: EdgeInsets.all(8),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image(
                                    image: FileImage(File(filePath)),
                                    width: 40,
                                    height: 40,
                                    fit: BoxFit.fill,
                                  ),
                                  Padding(padding: EdgeInsets.only(right: 8)),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: 110,
                                        child: Text(title, style: const TextStyle(color: Colors.black, fontSize: 14, fontFamily: "Courier")),
                                      ),
                                      Container(
                                        child: Text(
                                          author,
                                          style: const TextStyle(color: Colors.black26, fontSize: 12),
                                        ),
                                      ),

                                    ],
                                  )
                                ],
                              ),
                            ));
                      }),
                );
              }
            }
          default:
            {
              return Center(child: CircularProgressIndicator());
            }
        }
      },
    );
  }
}
