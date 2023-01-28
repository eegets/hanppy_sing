//now let make the db provider class


import 'package:happy_sing/model/song_model.dart';
import 'package:lpinyin/lpinyin.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

//已点歌曲
class OwnDatabaseProvider {
  OwnDatabaseProvider._();

  static final OwnDatabaseProvider db = OwnDatabaseProvider._();

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
    return await openDatabase(join(await getDatabasesPath(), "owner_db.db"), onCreate: (db, version) async {
      //Let`s create out first table
      await db.execute(
          "CREATE TABLE songs (id INTEGER PRIMARY KEY AUTOINCREMENT, fileSize TEXT, thumbNail TEXT, author TEXT,filePath TEXT, english TEXT, title TEXT, width TEXT, height TEXT, creationDate DATE)");
    }, version: 1);
  }

  //Now Let`s create a function that will add a new song to out variable
  addOwnerSong(SongModel songs) async {
    final db = await database;
    db.insert("songs", songs.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }
  ///查询已点歌曲的条数
  Future<dynamic> queryOwnerSongsCount() async {
    final db = await database;
    print("queryOwnerSongsCount start");
    List<Map<String, dynamic>> maps = await db.query("songs");
    if (maps.isEmpty) {
      print("queryOwnerSongsCount count: 0");
      return 0;
    } else {
      print("queryOwnerSongsCount count: ${maps.length}");
      return maps.length;
    }
  }

  //Create the function that will fetch our database and return all the element
  //inside the songs table
  Future<List<SongModel>> queryOwnerSongs(page, limit) async {
    print("querySongs start page: ${page * limit}; page+limit: ${(page * limit + 10)}");
    final db = await database;

    List<Map<String, dynamic>> maps = await db.query("songs", orderBy: "id desc");

    // List<Map<String, dynamic>> maps = await db.query("songs", limit: limit, where: "id>? and id<?", orderBy: "id desc", whereArgs: [page * limit, page * limit + 10]);
    if (maps.isEmpty) {
      return <SongModel>[];
    } else {
      var list = List.generate(maps.length, (i) {
        return SongModel(
            id: maps[i]["id"],
            fileSize: maps[i]["fileSize"],
            thumbNail: maps[i]["thumbNail"],
            author: maps[i]["author"],
            filePath: maps[i]["filePath"],
            english: PinyinHelper.getShortPinyin(maps[i]["title"]),
            title: maps[i]["title"],
            width: maps[i]["width"],
            height: maps[i]["height"],
            creationDate: DateTime.parse(maps[i]["creationDate"]));
      });
      for (var element in list) {
        print("querySongs element: id: ${element.id}, title: ${element.title}; filePath: ${element.filePath}");
      }
      return list;
    }
  }

  ///根据ID删除
  deleteOwnerSong(int id) async {
    final db = await database;
    db.delete("songs", where: "id = ?", whereArgs: [id]);
    rearrangeOwnSongs();
  }

  ///更新
  updateOwnerSong(int newId) async {
    final db = await database;
    db.rawUpdate("UPDATE songs SET id=? WHERE id=?", [10000000, newId]);
    print("querySongs update");
    rearrangeOwnSongs();
  }

  /// 重新排序列表
  rearrangeOwnSongs() async {
    final db = await database;

    List<Map<String, dynamic>> maps = await db.query("songs");
    if (maps.isEmpty) {
      return <SongModel>[];
    } else {
      var list = List.generate(maps.length, (i) {
        return SongModel(
            id: maps[i]["id"],
            fileSize: maps[i]["fileSize"],
            thumbNail: maps[i]["thumbNail"],
            author: maps[i]["author"],
            filePath: maps[i]["filePath"],
            english: PinyinHelper.getShortPinyin(maps[i]["title"]),
            title: maps[i]["title"],
            width: maps[i]["width"],
            height: maps[i]["height"],
            creationDate: DateTime.parse(maps[i]["creationDate"]));
      });
      for (var i = 0; i < list.length; i++) {
          var newId = list.length - (list.length - i);
          rearrangeUpdateOwnSongs(newId, list[i].id!);
          print("querySongs element: id: ${list[i].id}, title: ${list[i].title}; newIndex: $newId");
      }
    }
  }

  ///重新排序完之后更新
  rearrangeUpdateOwnSongs(int newId, int whereId) async {
    final db = await database;
    db.rawUpdate("UPDATE songs SET id=? WHERE id=?", [newId, whereId]);
    print("querySongs update");
  }


}
