import 'package:flutter/material.dart';

class HomePageContentItemWidget {
  static Widget PageContentItem(context, iconUrl, title,
      {required Function(BuildContext context, int index) onTap}) {
    return Center(
        child: GestureDetector(
          onTap: () {
            onTap(context, 0);
          },
          child: Stack(
            alignment: AlignmentDirectional.center,
            children: [
              Image(
                  image: AssetImage(iconUrl),
                  height: MediaQuery
                      .of(context)
                      .size
                      .height,
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  fit: BoxFit.cover),
              Text(title,
                  style: const TextStyle(
                      color: Colors.deepOrange,
                      fontSize: 30,
                      fontWeight: FontWeight.bold)),
            ],
          ),
        ));
  }
}
