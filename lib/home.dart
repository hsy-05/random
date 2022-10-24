import "dart:math";
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'home_num.dart';
class RandomHomePage extends StatefulWidget {
  const RandomHomePage({Key? key}) : super(key: key);

  @override
  State<RandomHomePage> createState() => _RandomHomePageState();
}

class _RandomHomePageState extends State<RandomHomePage> {
  final TextEditingController randomController = TextEditingController();//輸入的字串
  final TextEditingController strNumController = TextEditingController();//輸入字串的個數
  final TextEditingController strSecNum1Controller = TextEditingController();//輸入字串的個數
  final TextEditingController strSecNum2Controller = TextEditingController();//輸入字串的個數

  var strVal = "";
  var strNum = 0;
  var lines = <String>[]; //總字串
  String resultList = "";

  //final _randomText = Random();
  //String resultText = "";
  //var resultArray = <String>[];

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
            actions: <Widget>[
              //清除
              IconButton(
                icon: const Icon(Icons.next_plan),
                onPressed: () {
                  setState(() {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const RandomNumHomePage()),
                    );
                  });
                },
              ),
            ]),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(15, 50, 15, 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                TextField(
                  decoration: const InputDecoration(
                    isDense: true,
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.brown, width: 3.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.orange, width: 3.0),
                    ),
                    contentPadding: EdgeInsets.all(10),
                  ),
                  keyboardType: TextInputType.multiline,
                  maxLines: 5,
                  controller: randomController,
                  style: const TextStyle(
                      fontSize: 26, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                //間格
                const SizedBox(
                  height: 30,
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "選取",
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
                          controller: strNumController,
                          style: const TextStyle(
                              fontSize: 26, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const Text(
                        "個字串",
                        style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ]),
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
                            strVal = randomController.text;
                            //randomList();
                            pickRandomItems(strNum);  //結果
                            logResult();    //debug
                            WidgetsBinding.instance?.focusManager.primaryFocus?.unfocus(); //鍵盤退出
                          });
                        },
                        child: const Text("確定"))),
                //間格
                const SizedBox(
                  height: 40,
                ),
                Text(
                  "亂數結果 : $resultList",
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
    print('送出的文字: $lines');
    print('結果：'+ pickRandomItems(strNum));
    print('strNum：$strNum');
    print('檢查strNumController.text是否為 INT：' + strNumController.text is int);
  }

  void _strNUmText() {
    if(strNumController.text.isNotEmpty){
      strNum = int.parse(strNumController.text);
    }
    else{
      showWinnerToast();
    }
  }

  //選取字串的次數
  String pickRandomItems(int count) {
    lines = strVal.split('\n');
    final list = List.from(lines);
    _strNUmText();
    if(strNum <= list.length ){
      list.shuffle(); // 隨機排序
      final allList = list.take(count).toList();
      resultList = allList.join(', ');
    }
    else{
      showWinnerToast();
    }
    return resultList; // 從0 - count 獲取元素
  }
  // 提示框
  void showWinnerToast() {
    Fluttertoast.showToast(
        msg: "請輸入正確數字",
        toastLength: Toast.LENGTH_SHORT,  //顯示時間長短
        gravity: ToastGravity.CENTER,     //顯示位置
        timeInSecForIosWeb: 1,            //顯示秒數
        backgroundColor: const Color.fromRGBO(255, 225, 31, 1),  //背景
        textColor: Colors.black,
        fontSize: 16.0);
  }

}
