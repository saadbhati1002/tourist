import 'package:tourist/api/network/message/message.dart';
import 'package:tourist/utility/constant.dart';

class MessageRepository {
  Future<dynamic> getMessageApiCall() async {
    return await MessageNetwork.getMessages();
  }

  Future<dynamic> sendMessageMessageApiCall(
      {String? message, String? receiverID}) async {
    final param = {
      "sender_id": AppConstant.userData!.id.toString(),
      "receiver_id": receiverID,
      "message": message
    };
    return await MessageNetwork.sendMessage(param);
  }
}
