import 'package:mana_employee_fe/model/user/get_infor_user_model.dart';
class InfoUserRespone {
  bool? success;
  String? message;
  InfoUserDataModel? data;

  InfoUserRespone({this.success, this.message, this.data});

  InfoUserRespone.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? new InfoUserDataModel.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}