import 'package:tourist/api/network/leaderboard/leaderboard.dart';

class LeaderBoardRepository {
  Future<dynamic> getLeaderboardApiCall() async {
    return await LeaderBoardNetwork.getLeaderBoard();
  }
}
