class RollCallStatusRespone {
  bool? success;
  String? message;
  String? status;
  String? checkinTime;
  String? checkoutTime;

  RollCallStatusRespone(
      {this.success,
      this.message,
      this.status,
      this.checkinTime,
      this.checkoutTime});

  RollCallStatusRespone.fromJson(Map<String, dynamic> json) {
  success = json['success'] as bool?;
  message = json['message'] as String?;
  status = json['status'] as String?;
  checkinTime = json['checkin_time'] != null ? json['checkin_time'].toString() : null;
  checkoutTime = json['checkout_time'] != null ? json['checkout_time'].toString() : null;
}

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    data['status'] = this.status;
    data['checkin_time'] = this.checkinTime;
    data['checkout_time'] = this.checkoutTime;
    return data;
  }
}