import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:mana_employee_fe/model/rollcall/rollcall_respone.dart';
import 'package:mana_employee_fe/model/rollcall/rollcall_status_respone.dart'; 
class ApiServiceRollCall {
  static const String baseUrl = 'http://192.168.1.15:4000';

  Future<RollCallRespone> checkIn (String employeeId , double longitude, double latitude) async {
  var url = Uri.parse('$baseUrl/checkins/checkin');

    var headers = {
      'accept': 'application/json',
    };
    var body = json.encode({
      'employeeId': employeeId,
      'latitude': latitude,
      'longitude': longitude
    });
    print('Thông tin checkin');
    print(employeeId);
    print(longitude);print(latitude);

    var response = await http.post(url, headers: headers, body: body);
    var responseData = json.decode(response.body);
    if (response.statusCode == 200) { 
      var respone = RollCallRespone.fromJson(responseData);
      return respone;
 
    } else {
      throw Exception('Fail to call API');
    }
}

Future<RollCallRespone> checkOut (String employeeId , double longitude, double latitude) async {
  var url = Uri.parse('$baseUrl/checkins/checkout');

    var headers = {
      'accept': 'application/json',
    };
    var body = json.encode({
      'employeeId': employeeId,
      'latitude': latitude,
      'longitude': longitude
    });

    var response = await http.post(url, headers: headers, body : body);
    var responseData = json.decode(response.body);
    if (response.statusCode == 200) {
      
      var respone = RollCallRespone.fromJson(responseData);
      return respone;
 
    } else {
      throw Exception('Fail to call API');
    }
}

Future<RollCallStatusRespone> getTodayStatus(String employeeId) async {
  var url = Uri.parse('$baseUrl/checkins/getStatus/$employeeId');
  var headers = {'accept': 'application/json'};
  
  var response = await http.get(url, headers: headers);
  var responseData = json.decode(response.body);
  
  if (response.statusCode == 200) {
    return RollCallStatusRespone.fromJson(responseData);
  } else {
    throw Exception('Fail to call API');
  }
} 
  

}
