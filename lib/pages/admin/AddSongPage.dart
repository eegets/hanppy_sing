import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:happy_sing/model/song_model.dart';
import 'package:lpinyin/lpinyin.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_compress/video_compress.dart';
import 'package:happy_sing/db/database_provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class AddSongPage extends StatefulWidget {
  const AddSongPage({Key? key}) : super(key: key);

  @override
  State<AddSongPage> createState() => _AddSongPageState();
}

class _AddSongPageState extends State<AddSongPage> {
  //当前是第几页，默认从0开始
  var page = 0;
  //每页显示多少条
  var limit = 2;

  var allSongs = <SongModel>[];
  late List<SongModel> songs;

  //getting all songs
  querySongs(page) async {
    songs = await DatabaseProvider.db.querySongs(page, limit);
  }

  final RefreshController _refreshController = RefreshController(initialRefresh: false);

  @override
  void initState() {
    super.initState();
    _onRefresh();  //初始化下拉加载
  }

  void _onRefresh() async {
    // await Future.delayed(const Duration(milliseconds: 1000));
    page = 0;

    allSongs.clear();
    songs = await DatabaseProvider.db.querySongs(page, limit);
    allSongs.addAll(songs.toList());
    setState(() {
      Future.delayed(const Duration(seconds: 2), () => allSongs); //延迟两秒Z
    });

    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    // await Future.delayed(const Duration(milliseconds: 1000));
    page ++;

    querySongs(page);
    allSongs.addAll(songs.toList());
    setState(() {
      Future.delayed(const Duration(seconds: 2), () => allSongs); //延迟两秒

    });
    if (songs.length < limit) {
      _refreshController.loadNoData();
    } else {
      _refreshController.loadComplete();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("歌曲列表"),
          leading: BackButton(
            color: Colors.white,
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body:  Padding(
          padding: EdgeInsets.all(8),
          child: SmartRefresher(
            enablePullDown: true,
            enablePullUp: true,
            header: WaterDropHeader(),
            footer: CustomFooter(
                builder: (context, mode) {
                  Widget body ;
                  if(mode==LoadStatus.idle){
                    body =  Text("上拉加载");
                  }
                  else if(mode==LoadStatus.loading){
                    body =  CupertinoActivityIndicator();
                  }
                  else if(mode == LoadStatus.failed){
                    body = Text("加载失败！点击重试！");
                  }
                  else if(mode == LoadStatus.canLoading){
                    body = Text("松手,加载更多!");
                  }
                  else{
                    body = Text("已经见底了~");
                  }
                  return Container(
                    height: 55.0,
                    child: Center(child:body),
                  );
                }
            ),
            controller: _refreshController,
            onRefresh: _onRefresh,
            onLoading: _onLoading,
            child: ListView.builder(
                itemCount: allSongs.length,
                itemBuilder: (context, index) {
                  //setting the different items
                  String author = allSongs[index].author;
                  String title = allSongs[index].title;
                  String filePath = allSongs[index].thumbNail;
                  DateTime creationDate = allSongs[index].creationDate;
                  return Card(
                    child: Container(
                      padding: EdgeInsets.all(6),
                      child: Row(
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
                        verticalDirection: VerticalDirection.up,
                        children: [
                          Image(
                            image: FileImage(File(filePath)),
                            width: 30,
                            height: 30,
                            fit: BoxFit.scaleDown,
                          ),
                          const Padding(
                              padding: EdgeInsets.only(right: 10)),
                          Text(
                            title,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                            ),
                          ),
                          const Padding(
                              padding: EdgeInsets.only(left: 20)),
                          Text(author,
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                  fontFamily: "Courier")),
                          const Padding(
                              padding: EdgeInsets.only(left: 20)),
                          Text(
                            creationDate.toString(),
                            style: const TextStyle(
                                color: Colors.black26,
                                fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            _dirList("mkv");
          },
          icon: Icon(Icons.search),
          label: Text("点击扫描文件夹歌曲"),
        ),
      ),
    );
  }

  /*
   * 遍历 `dirName` 文件夹下的文件
   * `Directory(path).list()` 可选参数recursive，默认值为false，表示只遍历当前目录；设置为true时表示遍历当前目录及子目录。
   */
  _dirList(String dirName) async {
    Directory? fileDirectory;
    if (Platform.isAndroid) {
      //Android下获取文件路径，eg：/storage/emulated/0/Android/data/com.eegets.sing.happy_sing/files
      fileDirectory = await getExternalStorageDirectory();
    } else if (Platform.isMacOS) {
      //获取应用文件目录类似于iOS的NSDocumentDirectory和Android上的 AppData目录
      fileDirectory = await getDownloadsDirectory();
    }
    String path = "${fileDirectory?.path}/$dirName";

    Stream<FileSystemEntity> fileList = Directory(path).list(recursive: true);

    await for (FileSystemEntity fileSystemEntity in fileList) {
      FileSystemEntityType type = FileSystemEntity.typeSync(fileSystemEntity
          .path); //判断文件的类型：file：文件; directory：文件夹; link：链接文件; notFound：未知
      if (type == FileSystemEntityType.file) {
        //是文件
        saveDB(fileSystemEntity.path);
      } else if (type == FileSystemEntityType.directory) {
        //是文件夹

      } else if (type == FileSystemEntityType.directory) {
        //是链接文件

      } else {
        //未知文件

      }
      _onRefresh();
      print('${fileSystemEntity.path}-------$type');
    }
  }

  //存储读取到的歌曲信息到数据库
  Future<List<SongModel>> getVideoInfo(String filePath) async {
    var songs = <SongModel>[];
    //通过 `VideoCompress.getMediaInfo()` 读取文件信息
    final info = await VideoCompress.getMediaInfo(filePath);
    //通过 `VideoCompress.getFileThumbnail()` 获取缩略图
    final thumbNail = await VideoCompress.getFileThumbnail(filePath);

    final fileSplit = filePath.split(" - ");
    String songName = fileSplit[0].split(" ")[1];
    String songAuthor = fileSplit[1].split(".")[0];

    setState(() {
      if (info != null) {
        var videoInfo =
            "duration: ${info.duration}; author: $songAuthor; file: ${info.file}; title:$songName; width: ${info.width}; thumbNail: $thumbNail}";
        var songModel = SongModel(
            fileSize: info.duration.toString(),
            thumbNail: thumbNail.path,
            author: songAuthor,
            filePath: filePath,
            english: PinyinHelper.getShortPinyin(songName),
            title: songName,
            width: info.width.toString(),
            height: info.height.toString(),
            creationDate: DateTime.now());
        songs.add(songModel);
        print("videoInfo-----: $videoInfo");
      }
    });
    return songs;
  }

  //保存到数据库
  saveDB(String filePath) async {
    Future<List<SongModel>> songList = getVideoInfo(filePath);
    songList.then((value) => {
          for (var element in value) {DatabaseProvider.db.addSong(element)}
        });
  }

  //初始化文件路径
  Future<File> getFile(String fileName) async {
    Directory? fileDirectory;
    if (Platform.isAndroid) {
      //Android下获取文件路径，eg：/storage/emulated/0/Android/data/com.eegets.sing.happy_sing/files
      fileDirectory = await getExternalStorageDirectory();
    } else if (Platform.isMacOS) {
      //获取应用文件目录类似于iOS的NSDocumentDirectory和Android上的 AppData目录
      fileDirectory = await getDownloadsDirectory();
    }
    //获取存储路径
    final filePath = fileDirectory?.path;
    //或者file对象（操作文件记得导入import 'dart:io'）
    return File("$filePath/$fileName");
  }

  //读取存在文件中的数据内容，比如读取`test.txt`文件中的内容
  Future getString() async {
    final file = await getFile('test.txt');
    var filePath = file.path;
    print('${filePath}');
    setState(() {
      file.readAsString().then((String value) {
        String _saveString = value + '\n文件存储路径：' + filePath;
        print("存储的值为：_saveString: " + _saveString);
      });
    });
  }
}
