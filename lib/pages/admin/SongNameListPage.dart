import 'dart:io';

import 'package:flutter/material.dart';
import 'package:happy_sing/db/database_provider.dart';
import 'package:happy_sing/model/song_model.dart';

class SongNameListPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SongNameListPageState();
}

class _SongNameListPageState extends State<SongNameListPage> {
  //getting all songs
  Future<List<SongModel>> querySongs() async {
    final songs = await DatabaseProvider.db.querySongs(0, 10);
    return songs;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Your Songs"),
        ),
        body: FutureBuilder<List<SongModel>>(
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
                  if (songData.data == null) {
                    return const Center(
                      child: Text("You don`t have any song yet, create one"),
                    );
                  } else {
                    return Padding(
                      padding: EdgeInsets.all(8),
                      child: ListView.builder(
                          itemCount: songData.data?.length,
                          itemBuilder: (context, index) {
                            //setting the different items
                            String title = songData.data?[index].title;
                            String filePath = songData.data?[index].thumbNail;
                            DateTime creationDate =
                                songData.data?[index].creationDate;
                            return Card(
                              child: Container(
                                child: Row(
                                  children: [
                                    Image(
                                      image: FileImage(File(filePath)),
                                      width: 50,
                                      height: 50,
                                    ),

                                    Column(
                                      children: [
                                        Text(title,
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 16,
                                                fontFamily: "Courier")),
                                        Text(
                                          creationDate.toString(),
                                          style: const TextStyle(
                                              color: Colors.black26,
                                              fontSize: 12),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            );
                            return Card(
                              child: ListTile(
                                title: Text(title ?? ""),
                                subtitle: Text(creationDate.toString() ?? ""),
                              ),
                            );
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
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            //Let`s navigate to the song creation screen
            Navigator.pushNamed(context, "/addSong");
          },
          child: Icon(Icons.note_add),
        ),
      ),
    );
  }
}
