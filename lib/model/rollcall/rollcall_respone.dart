// dùng để thông báo cho cả check in , check out!!
class RollCallRespone {
  bool? success;
  String? message;

  RollCallRespone({this.success, this.message});

  RollCallRespone.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    return data;
  }
}