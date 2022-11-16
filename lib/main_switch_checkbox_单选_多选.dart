import 'package:flutter/material.dart';

///命名路由跳转
void main() {
  WidgetsFlutterBinding.ensureInitialized(); //不加这个强制横/竖屏会报错
  runApp(SwitchAndCheckBoxTestRoute());
}

class SwitchAndCheckBoxTestRoute extends StatefulWidget {
  const SwitchAndCheckBoxTestRoute({super.key});

  @override
  State<StatefulWidget> createState() => _SwitchAndCheckBoxTestRouteState();
  
}

class _SwitchAndCheckBoxTestRouteState extends State<SwitchAndCheckBoxTestRoute> {

  var _switchSelected = true; //维护单选开关状态

  var _checkboxMaleSelected = true; // 选择男
  var _checkboxFeMaleSelected = false; // 选择女

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          children: [
            Switch(value: _switchSelected, onChanged: (value) {
              setState(() {  //重新构建界面
                _switchSelected = value;
                print("切换状态： $_switchSelected");
              });
            }),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Text("男"),
                    Checkbox(
                        value: _checkboxMaleSelected,
                        activeColor: Colors.blue,  //选中时的颜色
                        onChanged: (isMan) {
                          setState(() {
                            if (isMan = true) {
                              _checkboxMaleSelected = isMan!;
                              _checkboxFeMaleSelected = false;
                            }
                            print("切换状态： $_checkboxFeMaleSelected; $_checkboxMaleSelected");
                          });
                        })
                  ],
                ),
                Row(
                  children: [
                    Text("女"),
                    Checkbox(
                        value: _checkboxFeMaleSelected,
                        activeColor: Colors.red,  //选中时的颜色
                        onChanged: (isFemale) {
                          setState(() {
                            if (isFemale = true) {
                              _checkboxFeMaleSelected = isFemale!;
                              _checkboxMaleSelected = false;
                            }
                            print("切换状态： $_checkboxFeMaleSelected; $_checkboxMaleSelected");
                          });
                        })
                  ],
                )
              ],
            )

          ],
        ),
      )
    );
  }
}