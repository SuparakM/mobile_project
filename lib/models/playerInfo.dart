class PlayerInfo {
  final String playerName;
  final int gameLevel;
  final int score;

  PlayerInfo({
    required this.playerName,
    required this.gameLevel,
    required this.score,
  });

  factory PlayerInfo.fromJson(Map<String, dynamic> json) {
    return PlayerInfo(
      playerName: json['player_name'],
      gameLevel: json['game_level'],
      score: json['score'],
    );
  }
}

