class notificationModel {
  String? token ;
  Map<String, dynamic>? notification;
  Map<String, dynamic>? android;
  Map<String, dynamic>? data = {'order' : true};

  notificationModel({
    this.token,
    this.notification,
    this.android,
    this.data,
  });

  notificationModel.fromJson(Map<String, dynamic> json)
  {
    token = json['to'];
    notification = json['notification'];
    android = json['android'];
    data = json['data'];
  }

  Map<String, dynamic> toMap()
  {
    return {
      'to' :token,
      'notification' :notification,
      'android' :android,
      'data' :data,
    };
  }
}