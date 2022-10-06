class orderModel {
  int? noOfWash;
  int? noOfDryClean;
  int? noOfIron;
  List<String>? comment;
  List<String>? imageUrls;
  String? user;
  String? address;
  String? pickupDate;
  String? pickupTime;
  String? dropdownDate;
  String? dropdownTime;
  int? orderNo;
  int? orderNoSubscription;
  bool? isPaid;
  bool? orderMade;
  bool? waitingForPickup;
  bool? deliveryOnTheWay;
  bool? deliveryArrived;
  bool? orderInProgress;
  bool? orderIsWashing;
  bool? orderIroning;
  bool? waitingForDroppingDown;
  bool? deliveryOnTheWayBack;
  bool? deliveryArrivedBack;
  bool? rateYourOrder;

  orderModel({
     this.noOfWash ,
     this.noOfDryClean ,
     this.noOfIron ,
     this.comment ,
     this.imageUrls ,
     this.user ,
     this.address ,
     this.pickupDate ,
     this.pickupTime ,
     this.dropdownDate ,
     this.dropdownTime ,
     this.orderNo ,
     this.orderNoSubscription = 0 ,
    this.isPaid ,
    this.orderMade ,
    this.waitingForPickup ,
    this.deliveryOnTheWay ,
    this.deliveryArrived ,
    this.orderInProgress ,
    this.orderIsWashing ,
    this.orderIroning ,
    this.waitingForDroppingDown ,
    this.deliveryOnTheWayBack ,
    this.deliveryArrivedBack ,
    this.rateYourOrder ,
  });

  orderModel.fromJson(Map<String, dynamic> json)
  {
    noOfWash = json['noOfWash'];
    noOfDryClean = json['noOfDryClean'];
    noOfIron = json['noOfIron'];
    comment = json['comment'];
    imageUrls = json['imageUrls'];
    user = json['user'];
    address = json['address'];
    pickupDate = json['pickupDate'];
    pickupTime = json['pickupTime'];
    dropdownDate = json['dropdownDate'];
    dropdownTime = json['dropdownTime'];
    orderNo = json['orderNo'];
    orderNoSubscription = json['orderNoSubscription'];
    isPaid = json['isPaid'];
    orderMade = json['orderMade'];
    waitingForPickup = json['waitingForPickup'];
    deliveryOnTheWay = json['deliveryOnTheWay'];
    deliveryArrived = json['deliveryArrived'];
    orderInProgress = json['orderInProgress'];
    orderIsWashing = json['orderIsWashing'];
    orderIroning = json['orderIroning'];
    waitingForDroppingDown = json['waitingForDroppingDown'];
    deliveryOnTheWayBack = json['deliveryOnTheWayBack'];
    deliveryArrivedBack = json['deliveryArrivedBack'];
    rateYourOrder = json['rateYourOrder'];

  }

  Map<String, dynamic> toMap()
  {
    return {
      'noOfWash' :noOfWash,
      'noOfDryClean':noOfDryClean,
      'noOfIron':noOfIron,
      'comment':comment,
      'imageUrls':imageUrls,
      'user':user,
      'address':address,
      'pickupDate':pickupDate,
      'pickupTime':pickupTime,
      'dropdownDate':dropdownDate,
      'dropdownTime':dropdownTime,
      'orderNo':orderNo,
      'orderNoSubscription':orderNoSubscription,
      'isPaid':isPaid,
      'orderMade':orderMade,
      'waitingForPickup' :waitingForPickup,
      'deliveryOnTheWay' :deliveryOnTheWay,
      'deliveryArrived' :deliveryArrived,
      'orderInProgress' :orderInProgress,
      'orderIsWashing' :orderIsWashing,
      'orderIroning' :orderIroning,
      'waitingForDroppingDown' :waitingForDroppingDown,
      'deliveryOnTheWayBack' :deliveryOnTheWayBack,
      'deliveryArrivedBack' :deliveryArrivedBack,
      'rateYourOrder' :rateYourOrder,
    };
  }
}