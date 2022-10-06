class subscriptionModel {
  String? startingDate;
  String? endDate;
  String? name;
  late int noOfOrders;
  int? noOfWash;
  int? noOfDryClean;
  int? noOfIron;
  bool? isPaid;

  subscriptionModel({
    required this.startingDate,
    required this.endDate,
    required this.name,
    required this.noOfOrders,
    required this.noOfWash,
    required this.noOfDryClean,
    required this.noOfIron,
    required this.isPaid,
  });

  subscriptionModel.fromJson(Map<String, dynamic> json)
  {
    noOfOrders = json['noOfOrders'];
    startingDate = json['startingDate'];
    endDate = json['endDate'];
    name = json['name'];
    noOfWash = json['noOfWash'];
    noOfDryClean = json['noOfDryClean'];
    noOfIron = json['noOfIron'];
    isPaid = json['isPaid'];
  }

  Map<String, dynamic> toMap()
  {
    return {
      'noOfOrders' :noOfOrders,
      'startingDate':startingDate,
      'endDate':endDate,
      'name':name,
      'noOfWash':noOfWash,
      'noOfDryClean':noOfDryClean,
      'noOfIron':noOfIron,
      'isPaid':isPaid,
    };
  }
}