import 'dart:math';
import 'package:flutter/material.dart';
import 'package:mobile_project/screens/api_page.dart';

import '../models/playerInfo.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
    required this.playerName,
  });

  final String playerName;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final random = Random(); // สร้างตัวแปรสำหรับสุ่ม
  int level = 0;
  String answer = "0";
  List<int> topNumbers = [];


  void generateAndShowRandomNumber() {
    setState(() {
      //answer = generateRandomNumber().toString();
      // สุ่มเลขด้านบนใหม่
      topNumbers = List.generate(4, (index) => generateRandomNumber());
      answer = "0"; // เริ่มคำนวณใหม่เมื่อมีเลขใหม่เข้ามา
    });
  }

  int generateRandomNumber() {
    // สุ่มตัวเลขจากระหว่าง 1 ถึง 9
    return random.nextInt(9) + 1;
  }

  @override
  void initState() {
    answer = "0";
    generateRandomNumbers();
    super.initState();
  }

  void generateRandomNumbers() {
    setState(() {
      // สร้างเลขสุ่มใหม่ทั้งหมดที่แสดงบนหน้าจอ
      topNumbers = List.generate(4, (index) => generateRandomNumber());
    });

    if (calculate_Sum(topNumbers) != 24) {
      generateAndShowRandomNumber();
    }
  }

  int calculate_Sum(List<int> numbers) {
    return numbers.reduce((value, element) => value + element);
  }

  void incrementLevel() async {
    setState(() {
      level += 1;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background4.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Stack(
            children: [
              // เพิ่มชื่อผู้เล่นและระดับที่เริ่มต้น
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        'Player : ${widget.playerName}',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        'Level : $level',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(8.0, 50.0, 8.0, 420.0),
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16.0),
                      child: Container(
                        color: Color(0xECEDAFFF),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              for (int number in topNumbers)
                                Expanded(
                                  child: Card(
                                    elevation: 8.0,
                                    child: Container(
                                      height: 180.0,
                                      child: Center(
                                        child: Text(
                                          number.toString(),
                                          style: TextStyle(
                                            fontSize: 40.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 8.0,
                left: 8.0,
                right: 8.0,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16.0),
                  child: Container(
                    height: 350.0,
                    // ความสูงของกล่องสี่เหลี่ยม
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        buildAnswerWidget(),
                        buildNumPadWidget(),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildAnswerWidget() {
    return Container(
      padding: EdgeInsets.all(16),
      color: Color(0xffecf0f1),
      child: Align(
        alignment: Alignment.bottomRight,
        child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
          Text(
            '$answer', // แสดงผลคำตอบและผลรวม
            style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
            textAlign: TextAlign.right,
          ),
        ]),
      ),
    );
  }

  Widget buildNumPadWidget() {
    return Container(
      color: Color(0xffecf0f1),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Row(children: <Widget>[
            buildNumberButton("7", onTap: () {
              addNumberToAnswer(7);
            }),
            buildNumberButton("8", onTap: () {
              addNumberToAnswer(8);
            }),
            buildNumberButton("9", onTap: () {
              addNumberToAnswer(9);
            }),
            buildNumberButton("÷", numberButton: false, onTap: () {
              addNumberToAnswer("÷");
            }),
          ]),
          Row(children: <Widget>[
            buildNumberButton("4", onTap: () {
              addNumberToAnswer(4);
            }),
            buildNumberButton("5", onTap: () {
              addNumberToAnswer(5);
            }),
            buildNumberButton("6", onTap: () {
              addNumberToAnswer(6);
            }),
            buildNumberButton("×", numberButton: false, onTap: () {
              addNumberToAnswer("×");
            }),
          ]),
          Row(children: <Widget>[
            buildNumberButton("1", onTap: () {
              addNumberToAnswer(1);
            }),
            buildNumberButton("2", onTap: () {
              addNumberToAnswer(2);
            }),
            buildNumberButton("3", onTap: () {
              addNumberToAnswer(3);
            }),
            buildNumberButton("-", numberButton: false, onTap: () {
              addNumberToAnswer("-");
            }),
          ]),
          Row(children: <Widget>[
            Expanded(
              child: GestureDetector(
                onTap: () async {
                  List<int> result = calculateSum(answer);
                  int sum = result.fold<int>(0, (a, b) => a + b);
                  setState(() {
                    answer = sum.toString();
                  });
                  if (sum == 24) {
                    generateAndShowRandomNumber();
                    incrementLevel();
                  } else {
                    // นำทางไปที่ API_page และรับค่าที่ถูกส่งกลับมา
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => API_page(
                          playerInfo: PlayerInfo(
                            playerName: widget.playerName,
                            gameLevel: level,
                            score: level*200,
                          ),
                        ),
                      ),
                    );

                    if (result != null) {
                      // ประมวลผลข้อมูลที่ได้จาก API_page
                      print("Result from API_page: $result");
                    }
                  }
                },
                child: Container(
                  margin: EdgeInsets.all(1),
                  color: Colors.green,
                  height: 60,
                  child: Center(
                    child: Text(
                      "Send",
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            buildNumberButton("0", onTap: () {
              addNumberToAnswer(0);
            }),
            buildNumberButton("Delete", numberButton: false, onTap: () {
              removeAnswerLast();
            }),
            buildNumberButton("+", numberButton: false, onTap: () {
              addNumberToAnswer("+");
            }),
          ]),
        ],
      ),
    );
  }

  Expanded buildNumberButton(String str,
      {required Function() onTap, bool numberButton = true}) {
    Widget widget;
    if (numberButton) {
      widget = GestureDetector(
        onTap: onTap,
        child: Container(
          margin: EdgeInsets.all(1),
          color: Colors.white,
          height: 60,
          child: Center(
            child: Text(
              str,
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      );
    } else {
      widget = GestureDetector(
        onTap: onTap,
        child: Container(
          margin: EdgeInsets.all(1),
          color: Color(0xffecf0f1),
          height: 60,
          child: Center(
            child: Text(
              str,
              style: TextStyle(fontSize: 28),
            ),
          ),
        ),
      );
    }
    return Expanded(child: widget);
  }

  void addNumberToAnswer(dynamic value) {
    setState(() {
      if (value is int) {
        if (value == 0 && answer == "0") {
          // Not do anything.
        } else if (value != 0 && answer == "0") {
          answer = value.toString();
        } else {
          answer += value.toString();
        }
      } else if (value is String) {
        answer += value;
      }
    });
  }

  void removeAnswerLast() {
    if (answer == "0") {
      // Not do anything.
    } else {
      setState(() {
        if (answer.length > 1) {
          answer = answer.substring(0, answer.length - 1);
        } else {
          answer = "0";
        }
      });
    }
  }

  List<int> calculateSum(String expression) {
    final List<String> operators = expression
        .split(RegExp(r'\d+')) // แยกตัวดำเนินการออกมาจากตัวเลข
        .where((element) => element.isNotEmpty)
        .toList();
    final List<int> numbers = expression
        .split(RegExp(r'[+\-*/]')) // แยกตัวเลขออกมาจากตัวดำเนินการ
        .where((element) => element.isNotEmpty)
        .map((e) => int.parse(e))
        .toList();

    int sum = numbers[0];
    for (int i = 1; i < numbers.length; i++) {
      if (operators[i - 1] == '+') {
        sum += numbers[i];
      } else if (operators[i - 1] == '-') {
        sum -= numbers[i];
      } else if (operators[i - 1] == '×') {
        sum *= numbers[i];
      } else if (operators[i - 1] == '÷') {
        if (numbers[i] != 0) {
          sum ~/= numbers[i];
        } else {
          // ให้คืนค่า 0 เมื่อมีการหารด้วย 0
          sum = 0;
        }
      }
    }

    return [sum];
  }

  void calculateAnswer() {
    if (answer.length > 0) {
      List<int> result = calculateSum(answer);
      setState(() {
        answer = result[0].toString();
      });
    }
  }
}