import 'package:mana_employee_fe/model/home/banners/banners.dart';

class ResponeBannerDataModel {
  bool? success;
  String? message;
  List<BannerDataModel>? data;

  ResponeBannerDataModel({this.success, this.message, this.data});

  ResponeBannerDataModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <BannerDataModel>[];
      json['data'].forEach((v) {
        data!.add(new BannerDataModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}