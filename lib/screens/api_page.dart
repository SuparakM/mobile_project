import 'dart:convert';
import 'package:flutter/material.dart';
import '../models/playerInfo.dart';

class API_page extends StatefulWidget {
  API_page({
    super.key,
    required this.playerInfo,
  });

  final PlayerInfo playerInfo;

  @override
  _API_pageState createState() => _API_pageState();
}

class _API_pageState extends State<API_page> {
  List<PlayerInfo> playerInfoList = [];

  @override
  void initState() {
    super.initState();
    loadPlayerInfo();
  }

  void loadPlayerInfo() async {
    final String data =
        await DefaultAssetBundle.of(context).loadString("assets/data.json");
    final List<dynamic> jsonList = json.decode(data);

    setState(() {
      playerInfoList =
          jsonList.map((json) => PlayerInfo.fromJson(json)).toList();
    });

    // ให้ใช้ JsonEncoder เพื่อจัดรูปแบบ JSON ก่อนพิมพ์
    final JsonEncoder encoder = JsonEncoder.withIndent('  ');
    final String prettyPrinted = encoder.convert(jsonList);

    // พิมพ์ JSON ที่ถูกจัดรูปแบบ
    print("Loaded and formatted JSON data:\n$prettyPrinted");
  }

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
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView(
                children: [
                  for (PlayerInfo info in playerInfoList)
                    Card(
                      child: Text(
                        '''
                  Player Name: ${info.playerName}
                  Game Level: ${info.gameLevel}
                  Score: ${info.score}
                  ''',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      color: Color(0xECEDAFFF),
                    ),
                  Card(
                    child: Text(
                      '''
                    Player Name: ${widget.playerInfo.playerName}
                    Game Level: ${widget.playerInfo.gameLevel}
                    Score: ${widget.playerInfo.score}
                    ''',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    color: Color(0xEC5EF18F),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
