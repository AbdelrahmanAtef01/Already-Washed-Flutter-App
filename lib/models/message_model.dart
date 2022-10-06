class MessageDataModel {
  MessageDataModel({
    required this.senderId,
    required this.receiverId,
    required this.message,
    required this.time,
  });

   String? senderId;
   String? receiverId;
   String? message;
   String? time;

  MessageDataModel.fromJson(Map<String, dynamic> json) {
    senderId = json['senderId'] ?? '';
    receiverId = json['receiverId'] ?? '';
    message = json['message'] ?? '';
    time = json['time'] ?? '';
  }

  Map<String, dynamic> toJson() {
    return {
      'senderId': senderId,
      'receiverId': receiverId,
      'message': message,
      'time': time,
    };
  }
}