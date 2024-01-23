import 'package:tourist/api/http_manager.dart';
import 'package:tourist/models/leaderboard/leaderboard_model.dart';

class LeaderBoardNetwork {
  static const String leaderBoardUrl = "auth-api.php/Scoreboard";
  static Future<dynamic> getLeaderBoard() async {
    final result = await httpManager.post(
      url: leaderBoardUrl,
    );
    LeaderboardRes loginRes = LeaderboardRes.fromJson(result);
    return loginRes;
  }
}
