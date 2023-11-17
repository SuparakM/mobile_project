import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_project/screens/home_page.dart';

class StartGamePage extends StatefulWidget {
  const StartGamePage({super.key});

  @override
  _StartGamePageState createState() => _StartGamePageState();
}

class _StartGamePageState extends State<StartGamePage> {
  Set<String> uniqueData = Set<String>(); // เก็บข้อมูลที่ไม่ซ้ำ
  TextEditingController _textEditingController = TextEditingController();

  @override
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'TWENTY-FOUR',
                style: TextStyle(
                  fontSize: 60.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  shadows: [
                    Shadow(
                      offset: Offset(2.0, 2.0), // ปรับตำแหน่งเงา
                      color: Colors.black, // สีของเงา
                      blurRadius: 4.0, // ขนาดของเงา
                    ),
                  ],
                ),
              ),
              SizedBox(height: 40.0),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: _textEditingController,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(10),
                      ],
                      decoration: InputDecoration(labelText: 'Name'),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 40.0),
              ElevatedButton(
                onPressed: () {
                  // เมื่อกดปุ่ม "เริ่มเกม" นี่คือส่วนที่คุณสามารถเพิ่มโค้ดเพื่อลิงค์ไปหน้าถัดไป
                  String playerName = _textEditingController.text.trim();

                  if (playerName.isNotEmpty &&
                      !uniqueData.contains(playerName)) {
                    // ถ้าข้อมูลไม่ซ้ำกับที่มีอยู่
                    setState(() {
                      uniqueData.add(playerName); // เพิ่มข้อมูลเข้า Set
                    });
                    // นำทางไปยังหน้าถัดไป
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MyHomePage(
                          playerName: playerName,
                        ),
                      ),
                    );

                    // ล้างข้อมูลใน TextField
                    _textEditingController.clear();
                  }
                },
                child: Text(
                  'START',
                  style: TextStyle(
                    fontSize: 24.0,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(200.0, 50.0),
                  elevation: 10.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
