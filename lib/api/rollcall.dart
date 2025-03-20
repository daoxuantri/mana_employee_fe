import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:mana_employee_fe/model/rollcall/rollcall_respone.dart';
class ApiServiceRollCall {
  static const String baseUrl = 'http://192.168.1.21:4000';

  Future<RollCallRespone> checkIn (String employeeId , double longitude, double latitude) async {
  var url = Uri.parse('$baseUrl/checkins/checkin');

    var headers = {
      'accept': 'application/json',
    };

    var response = await http.post(url, headers: headers);
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

    var response = await http.post(url, headers: headers);
    var responseData = json.decode(response.body);
    if (response.statusCode == 200) {
      
      var respone = RollCallRespone.fromJson(responseData);
      return respone;
 
    } else {
      throw Exception('Fail to call API');
    }
}


  
  

}
