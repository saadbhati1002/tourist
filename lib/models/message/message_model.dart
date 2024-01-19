import 'package:tourist/models/user/user_model.dart';

class MessageRes {
  int? receivedUsersCount;
  List<UserData>? chatUsers;

  MessageRes({this.receivedUsersCount, this.chatUsers});

  MessageRes.fromJson(Map<String, dynamic> json) {
    receivedUsersCount = json['received_users_count'];
    if (json['received_users_details'] != null) {
      chatUsers = <UserData>[];
      json['received_users_details'].forEach((v) {
        chatUsers!.add(UserData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['received_users_count'] = receivedUsersCount;
    if (chatUsers != null) {
      data['received_users_details'] =
          chatUsers!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ChatHistory {
  String? id;
  String? senderId;
  String? receiverId;
  String? message;
  String? timestamp;

  ChatHistory(
      {this.id, this.senderId, this.receiverId, this.message, this.timestamp});

  ChatHistory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    senderId = json['sender_id'];
    receiverId = json['receiver_id'];
    message = json['message'];
    timestamp = json['timestamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['sender_id'] = senderId;
    data['receiver_id'] = receiverId;
    data['message'] = message;
    data['timestamp'] = timestamp;
    return data;
  }
}
