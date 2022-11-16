import 'package:flutter/material.dart';

typedef TextFieldInputCallBack = void Function(String keyWords);

class SearchGridViewWidget extends StatefulWidget {
  final TextFieldInputCallBack textFieldInputCallBack;
  SearchGridViewWidget({Key? key, required this.textFieldInputCallBack}) : super(key: key);

  @override
  State<SearchGridViewWidget> createState() => _SearchGridViewWidgetState();
}

class _SearchGridViewWidgetState extends State<SearchGridViewWidget> {
  var list = [
    "A",
    "B",
    "C",
    "D",
    "E",
    "F",
    "G",
    "H",
    "I",
    "J",
    "K",
    "L",
    "M",
    "N",
    "O",
    "P",
    "Q",
    "R",
    "S",
    "T",
    "U",
    "V",
    "W",
    "X",
    "Y",
    "Z",
    "0",
    "1",
    "2",
    "3",
    "4",
    "5",
    "6",
    "7",
    "8",
    "9"
  ];

  final _useInputController = TextEditingController();

  final _pressWords = <String>[];

  @override
  Widget build(BuildContext context) {
    return Container(
      // decoration: BoxDecoration(
      //   color: Colors.red,
      // ),
      // padding: EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              height: 60,
              child: Expanded(
                  child: Row(
                children: [
                  Expanded(
                    flex: 4,
                    child: SizedBox(
                        height: 45,
                        child: TextField(
                          controller: _useInputController,
                          maxLines: 1,
                          textCapitalization: TextCapitalization.characters,
                          // decoration: const InputDecoration(
                          //   border: OutlineInputBorder(
                          //     ///设置边框四个角的弧度
                          //     borderRadius: BorderRadius.all(Radius.circular(10)),
                          //
                          //     ///用来配置边框的样式
                          //     borderSide: BorderSide(
                          //       ///设置边框的颜色
                          //       color: Colors.red,
                          //
                          //       ///设置边框的粗细
                          //       width: 3.0,
                          //     ),
                          //   ),
                          //
                          //   ///设置输入框可编辑时的边框样式
                          //   enabledBorder: OutlineInputBorder(
                          //     ///设置边框四个角的弧度
                          //     borderRadius: BorderRadius.all(Radius.circular(10)),
                          //
                          //     ///用来配置边框的样式
                          //     borderSide: BorderSide(
                          //       ///设置边框的颜色
                          //       color: Colors.blue,
                          //
                          //       ///设置边框的粗细
                          //       width: 3.0,
                          //     ),
                          //   ),
                          //   disabledBorder: OutlineInputBorder(
                          //     ///设置边框四个角的弧度
                          //     borderRadius: BorderRadius.all(Radius.circular(10)),
                          //
                          //     ///用来配置边框的样式
                          //     borderSide: BorderSide(
                          //       ///设置边框的颜色
                          //       color: Colors.red,
                          //
                          //       ///设置边框的粗细
                          //       width: 3.0,
                          //     ),
                          //   ),
                          //
                          //   ///用来配置输入框获取焦点时的颜色
                          //   focusedBorder: OutlineInputBorder(
                          //     ///设置边框四个角的弧度
                          //     borderRadius: BorderRadius.all(Radius.circular(20)),
                          //
                          //     ///用来配置边框的样式
                          //     borderSide: BorderSide(
                          //       ///设置边框的颜色
                          //       color: Colors.green,
                          //
                          //       ///设置边框的粗细
                          //       width: 3.0,
                          //     ),
                          //   ),
                          // ),
                          autofocus: false,
                          // decoration: InputDecoration(labelText: "点击搜索"),
                        )),
                  ),
                  Expanded(
                      flex: 1,
                      child: InkWell(
                          onTap: () {
                            updateInputController(false, _pressWords.length - 1);
                          },
                          child: Image(width: 30, height: 30, image: AssetImage("assets/icons/icon_search_clear.png"))))
                ],
              ))),
          Expanded(
              child: Container(
                  // decoration: BoxDecoration(color: Colors.white),
                  alignment: Alignment.topCenter,
                  child: Column(
                    children: [
                      Flex(direction: Axis.horizontal, children: [
                        Expanded(flex: 1, child: Container(height: 40, alignment: Alignment.center, decoration: const BoxDecoration(color: Colors.red), child: const Text("拼音"))),
                        Expanded(
                            flex: 1, child: Container(height: 40, alignment: Alignment.center, decoration: const BoxDecoration(color: Colors.lightBlue), child: const Text("手写"))),
                      ]),
                      Expanded(
                        child: GridView.builder(
                            itemCount: list.length,
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                //横轴元素个数
                                crossAxisCount: 6,
                                //纵轴间距
                                mainAxisSpacing: 0.0,
                                //横轴间距
                                crossAxisSpacing: 0.0,
                                //子组件宽高长度比例
                                childAspectRatio: 1),
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  updateInputController(true, index);
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  child: Text(list[index], style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                                ),
                              );
                            }),
                      )
                    ],
                  ))),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _useInputController.dispose();
    super.dispose();
  }

  /// 更新输入框内容
  void updateInputController(bool isAdd, int index) {
    if (index < 0) {
      return;
    }
    String keyWords = "";
    if (isAdd) {
      _pressWords.add(list[index]);
    } else {
      _pressWords.removeAt(index);
    }
    for (var element in _pressWords) {
      keyWords += element;
    }
    _useInputController.value = _useInputController.value.copyWith(text: keyWords.toString());
    print("updateInputController index: $index; _pressWords: ${_pressWords.length}; keyWords: $keyWords");

    widget.textFieldInputCallBack(keyWords);
  }
}
