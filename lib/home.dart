import "dart:math";
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';

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

  var strVal = "";  //輸入的字串
  var strNum = 0;  //次數
  var lines = <String>[]; //總字串
  String resList = "";  //結果
  bool _igBtnVis = false;
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
                            numVal();
                            WidgetsBinding.instance?.focusManager.primaryFocus?.unfocus(); //鍵盤退出
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
                Visibility(
                  visible: _igBtnVis, // bool
                  child:
                  SizedBox(
                      height: 50,
                      width: 150,
                      child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              serachByIG();
                            });
                          },
                          child: const Text("IG查詢標籤", style: const TextStyle(fontSize:20, fontWeight: FontWeight.bold),))),

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

  //字串轉數字
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
    lines = strVal.split('\n');   //切割字串後放入list
    final list = List.from(lines);
    print('List：$list');
    _strNUmText();
    if(strNum <= list.length ){
      list.shuffle(); // 隨機排序
      final allList = list.take(count).toList();
      resList = allList.join(', ');
    }
    else{
      showWinnerToast();
    }
    return resList; // 從0 - count 獲取元素
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

  //判斷字串否只有一個
  bool numVal(){
    if(strNum == 1){
      _igBtnVis = true;
    }
    else{
      _igBtnVis = false;
    }
    return _igBtnVis;
  }

  //判斷字串來顯示按鈕
  void serachByIG(){
    if(strNum == 1){
      _launch();
      print('傳送的字串：'+resList);
    }
    else{
      showWinnerToast();
    }
  }

  //IG URL
  _launch() async {
    Uri url = Uri.parse('https://www.instagram.com/explore/tags/'+resList);
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }

}
