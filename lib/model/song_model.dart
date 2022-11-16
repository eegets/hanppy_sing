class SongModel {
  /// id
  int? id;

  /// 文件大小
  String fileSize = "";

  /// 封面图
  String thumbNail = "";

  /// 作者
  String author = "";

  ///文件
  String filePath = "";

  ///中文对应的英文首字母
  String english = "";

  ///名称
  String title = "";

  ///width
  String width = "";

  ///height
  String height = "";

  ///导入时间
  late DateTime creationDate;

  SongModel(
      {this.id,
      required this.fileSize,
      required this.thumbNail,
      required this.author,
      required this.filePath,
      required this.english,
      required this.title,
      required this.width,
      required this.height,
      required this.creationDate});

  //create a function to convert our item into a map
  Map<String, dynamic> toMap() {
    return ({
      "id": id,
      "fileSize": fileSize,
      "thumbNail": thumbNail,
      "author": author,
      "filePath": filePath,
      "english": english,
      "title": title,
      "width": width,
      "height": height,
      "creationDate": creationDate.toString(),
    });
  }
}
