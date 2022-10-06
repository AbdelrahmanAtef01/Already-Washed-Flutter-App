class userMemberShipModel {
  String? name;
  String? type;
  int? noOfOrders;
  int? noOfWash;
  int? noOfDryClean;
  int? noOfIron;
  int? price;
  bool? isSubscribed;

  userMemberShipModel({
    required this.name,
    required this.type,
    required this.price,
    required this.noOfOrders,
    required this.noOfWash,
    required this.noOfDryClean,
    required this.noOfIron,
     this.isSubscribed = false,
  });

  userMemberShipModel.fromJson(Map<String, dynamic> json)
  {
    noOfOrders = json['noOfOrders'];
    name = json['name'];
    type = json['type'];
    price = json['price'];
    noOfWash = json['noOfWash'];
    noOfDryClean = json['noOfDryClean'];
    noOfIron = json['noOfIron'];
    isSubscribed = json['isSubscribed'];
  }

  Map<String, dynamic> toMap()
  {
    return {
      'noOfOrders' :noOfOrders,
      'name':name,
      'type':type,
      'price':price,
      'noOfWash':noOfWash,
      'noOfDryClean':noOfDryClean,
      'noOfIron':noOfIron,
      'isSubscribed':isSubscribed != null ? isSubscribed : false,
    };
  }
}