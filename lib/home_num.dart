import 'dart:ffi';
import "dart:math";
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RandomNumHomePage extends StatefulWidget {
  const RandomNumHomePage({Key? key}) : super(key: key);

  @override
  State<RandomNumHomePage> createState() => _RandomNumHomePageState();
}

class _RandomNumHomePageState extends State<RandomNumHomePage> {
  final TextEditingController randomController =
      TextEditingController(); //輸入的字串
  final TextEditingController strNumController =
      TextEditingController(); //輸入字串的個數
  final TextEditingController strFstNumController =
      TextEditingController(); //輸入字串的個數
  final TextEditingController strSecNumController =
      TextEditingController(); //輸入字串的個數

  var strNum = 0; //亂數次數
  var strFstNum = 0; //第一個數字
  var strSecNum = 0; //第二個數字
  Set<int> list = {}; //結果 Set<int> listz = {};
  var resList = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false, //防止鍵盤覆蓋內容
        appBar: AppBar(
          title: const Center(
            child: Text(
              "亂數",
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(15, 50, 15, 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  const Text(
                    "從",
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  //數字輸入框
                  SizedBox(
                    height: 50,
                    width: 100,
                    child: TextField(
                      decoration: const InputDecoration(
                        isDense: true, //輸入是否爲密集形式
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.brown, width: 3.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.orange, width: 3.0),
                        ),
                      ),
                      keyboardType: TextInputType.number,
                      controller: strFstNumController,
                      style: const TextStyle(
                          fontSize: 26, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const Text(
                    "到",
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  //數字輸入框
                  SizedBox(
                    height: 50,
                    width: 100,
                    child: TextField(
                      decoration: const InputDecoration(
                        isDense: true, //輸入是否爲密集形式
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.brown, width: 3.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.orange, width: 3.0),
                        ),
                      ),
                      keyboardType: TextInputType.number,
                      controller: strSecNumController,
                      style: const TextStyle(
                          fontSize: 26, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ]),
                const Text(
                  "之間選取",
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 50,
                  width: 100,
                  child: TextField(
                    decoration: const InputDecoration(
                      isDense: true, //輸入是否爲密集形式
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.brown, width: 3.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.orange, width: 3.0),
                      ),
                    ),
                    keyboardType: TextInputType.number,
                    controller: strNumController,
                    style: const TextStyle(
                        fontSize: 26, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
                const Text(
                  "個數字",
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                //間格
                const SizedBox(
                  height: 30,
                ),
                SizedBox(
                    height: 50,
                    width: 100,
                    child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            //randomList();
                            pickRandomNum(); //結果pickRandomItems
                            logResult(); //debug
                            WidgetsBinding.instance?.focusManager.primaryFocus
                                ?.unfocus(); //鍵盤退出
                          });
                        },
                        child: const Text("確定"))),
                //間格
                const SizedBox(
                  height: 40,
                ),
                Text(
                  "亂數結果 : $resList",
                  style: const TextStyle(
                      fontSize: 28, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ));
  }

  //全部的字串
  void logResult() {
    print('第一個數字： $strFstNum 和 第二個數字： $strSecNum');
    print('選取的次數：$strNum');
    print('結果：$resList');
  }

  //字串轉數字
  void _strNUmText() {
    if (strNumController.text.isNotEmpty &&
        strFstNumController.text.isNotEmpty &&
        strSecNumController.text.isNotEmpty) {
      strFstNum = int.parse(strFstNumController.text);
      strSecNum = int.parse(strSecNumController.text);
      strNum = int.parse(strNumController.text);
    } else {
      showWinnerToast();
    }
  }

  //
  String pickRandomNum() {
      _strNUmText();
      list.clear();
      if (strNum <= (strSecNum - strFstNum + 1) && strNum != 0) {
      var rdm = Random();
      while (list.length != strNum) {
        list.add(strFstNum + rdm.nextInt(strSecNum + 1 - strFstNum)); //亂數結果
        final allList = list.take(strNum).toList();
        resList = allList.join(', ');
      }
    } else {
      showWinnerToast();
      resList = "";
    }
    return resList;
  }

  // 提示框
  void showWinnerToast() {
    Fluttertoast.showToast(
        msg: "請輸入正確數字",
        toastLength: Toast.LENGTH_SHORT,
        //顯示時間長短
        gravity: ToastGravity.CENTER,
        //顯示位置
        timeInSecForIosWeb: 1,
        //顯示秒數
        backgroundColor: const Color.fromRGBO(255, 225, 31, 1),
        //背景
        textColor: Colors.black,
        fontSize: 16.0);
  }
}
