class promoCodes {
  String? promoCode;
  String? startingDate;
  String? endDate;
  double? percentage;

  promoCodes({
    this.promoCode,
    this.startingDate,
    this.endDate,
    this.percentage,

  });

  promoCodes.fromJson(Map<String, dynamic> json)
  {
    promoCode = json['promoCode'];
    startingDate = json['startingDate'];
    endDate = json['endDate'];
    percentage = json['percentage'];
  }

  Map<String, dynamic> toMap()
  {
    return {
      'promoCode' :promoCode,
      'startingDate' :startingDate,
      'endDate' :endDate,
      'percentage' :percentage,
    };
  }
}