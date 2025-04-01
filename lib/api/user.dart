import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:mana_employee_fe/model/user/get_infor_user_model.dart';
import 'package:mana_employee_fe/model/user/info_user_respone.dart';
import 'package:mana_employee_fe/security_user/secure_storage_user.dart';
class ApiServiceUsers {
  static const String baseUrl = 'http://192.168.1.15:4000';

  //POST
  Future<void> signUpMini(String email, String phone, String password,
      String username) async {
    var url = Uri.parse('$baseUrl/users/register');

    var headers = {
      'accept': 'application/json',
      'Content-Type': 'application/json',
    };

    var body = json.encode({
      'email': email,
      'contact': phone,
      'password': password,
      'username': username, 
    });

    var response = await http.post(url, headers: headers, body: body);
    var responseData = json.decode(response.body);
    if (response.statusCode == 200) {
      
      if (responseData['success'] == true) {
        
      } else {
        throw Exception(responseData['message']);
      }
    } else {
      throw Exception(responseData['message']);
    }
  }
  //GET
  Future<InfoUserDataModel> getDetailUser() async {
    String? userId = await UserSecurityStorage.getId();
    var url = Uri.parse('$baseUrl/users/getInformation/$userId');

    var headers = {
      'accept': 'application/json',
      'Content-Type': 'application/json',
    };

    var response = await http.get(url, headers: headers);
    var responseData = json.decode(response.body);
    if (response.statusCode == 200) {
      if (responseData['success'] == true) {
        var response = InfoUserRespone.fromJson(responseData);
        print("User Data:");
      print("Fullname: ${response.data?.fullname}");
      print("Contact: ${response.data?.contact}");
      print("Department: ${response.data?.department}");
      print("Role: ${response.data?.role}");
      print("Email: ${response.data?.email}");
      print("Images: ${response.data?.images}");
        return response.data!;
      } else {
        throw Exception(responseData['message']);
      }
    } else {
      throw Exception(responseData['message']);
    }
  }

  

}