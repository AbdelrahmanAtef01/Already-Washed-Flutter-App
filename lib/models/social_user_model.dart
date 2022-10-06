class SocialUserModel {
  String? name;
  String? email;
  String? phone;
  String? uId;
  String? password;
  late String address;
  bool? isEmailVerified;
  bool? whatsappPrivacy;

  SocialUserModel({
    required this.email,
    required this.name,
    required this.address,
    required this.phone,
    required this.uId,
    required this.password,
    required this.isEmailVerified,
    this.whatsappPrivacy,
  });

  SocialUserModel.fromJson(Map<String, dynamic> json)
  {
    email = json['email'];
    address = json['address'];
    name = json['name'];
    phone = json['phone'];
    uId = json['uId'];
    password = json['password'];
    isEmailVerified = json['isEmailVerified'];
    whatsappPrivacy = json['whatsappPrivacy'];
  }

  Map<String, dynamic> toMap()
  {
    return {
      'uId' :uId,
      'name':name,
      'email':email,
      'phone':phone,
      'address':address,
      'password':password,
      'isEmailVerified':isEmailVerified,
      'whatsappPrivacy' :whatsappPrivacy,
    };
  }
}