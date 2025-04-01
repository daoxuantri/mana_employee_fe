class InfoUserDataModel {
  String? fullname;
  String? contact;
  Null? department;
  String? role;
  String? email;
  String? images;

  InfoUserDataModel(
      {this.fullname,
      this.contact,
      this.department,
      this.role,
      this.email,
      this.images});

  InfoUserDataModel.fromJson(Map<String, dynamic> json) {
    fullname = json['fullname'];
    contact = json['contact'];
    department = json['department'];
    role = json['role'];
    email = json['email'];
    images = json['images'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fullname'] = this.fullname;
    data['contact'] = this.contact;
    data['department'] = this.department;
    data['role'] = this.role;
    data['email'] = this.email;
    data['images'] = this.images;
    return data;
  }
}