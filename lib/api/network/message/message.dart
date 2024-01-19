import 'dart:convert';

import 'package:tourist/api/http_manager.dart';
import 'package:tourist/models/common.dart';
import 'package:tourist/models/message/message_model.dart';
import 'package:tourist/utility/constant.dart';

class MessageNetwork {
  static const String messageListUrl = "auth-api.php/ChatAPI?user_id=";
  static const String sendMessageUrl = "auth-api.php/sendMessage";
  static Future<dynamic> getMessages() async {
    final result = await httpManager.get(
      url: "$messageListUrl${AppConstant.userData!.id}",
    );
    MessageRes loginRes = MessageRes.fromJson(jsonDecode(result));
    return loginRes;
  }

  static Future<dynamic> sendMessage(prams) async {
    final result = await httpManager.post(url: sendMessageUrl, data: prams);

    Common loginRes = Common.fromJson(result);
    return loginRes;
  }
}
