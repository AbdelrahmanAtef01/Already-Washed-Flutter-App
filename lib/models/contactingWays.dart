class contactingWays {
  String? phoneNumber;
  String? email;
  String? receiverId;

  contactingWays({
    this.phoneNumber,
    this.email,
    this.receiverId,
  });

  contactingWays.fromJson(Map<String, dynamic> json)
  {
    phoneNumber = json['phoneNumber'];
    email = json['email'];
    receiverId = json['receiverId'];
  }

  Map<String, dynamic> toMap()
  {
    return {
      'phoneNumber' :phoneNumber,
      'email' :email,
      'receiverId' :receiverId,
    };
  }
}