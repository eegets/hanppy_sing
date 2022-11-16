//now let make the db provider class

import 'package:happy_sing/model/song_model.dart';
import 'package:lpinyin/lpinyin.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseProvider {
  DatabaseProvider._();

  static final DatabaseProvider db = DatabaseProvider._();

  static dynamic _database;

  //creating the getter the database
  Future<Database> get database async {
    //first Let`s check that we don`t already have a db
    if (_database != null) {
      return _database;
    }
    _database = await initDB();
    return _database;
  }

  int id = 0;

  /// 文件大小
  double fileSize = 0;

  /// 作者
  String author = "";

  ///文件
  String filePath = "";

  ///中文对应的英文首字母
  String english = "";

  ///名称
  String title = "";

  ///width
  int width = 0;

  ///height
  int height = 0;

  ///导入时间
  late DateTime creationDate;

  initDB() async {
    return await openDatabase(join(await getDatabasesPath(), "song_app.db"),
        onCreate: (db, version) async {
      //Let`s create out first table
      await db.execute(
          "CREATE TABLE songs (id INTEGER PRIMARY KEY AUTOINCREMENT, fileSize TEXT, thumbNail TEXT, author TEXT,filePath TEXT, title TEXT, english TEXT, width TEXT, height TEXT, creationDate DATE)");
    }, version: 1);
  }

  //Now Let`s create a function that will add a new song to out variable
  addSong(SongModel songs) async {
    final db = await database;
    db.insert("songs", songs.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  ///搜索筛选，根据歌名
  queryByKeyWords(keyWord) async {
    print("querySongs start page queryByKeyWords");
    final db = await database;
  }

  //Create the function that will fetch our database and return all the element
  //inside the songs table

  Future<List<SongModel>> querySongs(page, limit) async {
    print("querySongs start page: ${page * limit}; page+limit: ${(page * limit + 46)}");
    final db = await database;

    List<Map<String, dynamic>> maps = await db.query("songs", limit: limit, where: "id>? and id<?", whereArgs: [page * limit, page * limit + 46]);
    if (maps.isEmpty) {
      return <SongModel>[];
    } else {
      var list = List.generate(maps.length, (i) {
        return SongModel(
            // id: maps[i]["id"],
            fileSize: maps[i]["fileSize"],
            thumbNail: maps[i]["thumbNail"],
            author: maps[i]["author"],
            filePath: maps[i]["filePath"],
            english: PinyinHelper.getShortPinyin(maps[i]["title"]),
            title: maps[i]["title"],
            width: maps[i]["width"],
            height: maps[i]["height"],
            creationDate: DateTime.parse(maps[i]["creationDate"])
        );
      });
      for (var element in list) {
        print("querySongs element: id: ${element.id}, title: ${element.title}");
      }
      return list;
    }
  }
}
