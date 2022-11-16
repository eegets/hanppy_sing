import 'package:flutter/material.dart';

class FloatingButtons {

    List<Widget> getLeftContent(List<String> titles, List<String> icons, Function(int index) onPressed) {
      List<Widget> listView = [];

      for (var i = 0; i < titles.length; i++) {
        listView.add( ElevatedButton.icon(
          icon: Icon(Icons.send),
          label: Text(titles[i]),
          onPressed: () {
            onPressed(i);
          },
        ),);
      }
      return listView;
    }
}
