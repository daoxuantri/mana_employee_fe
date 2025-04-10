import 'package:http/http.dart' as http;
import 'package:mana_employee_fe/model/home/banners/banners.dart';
import 'dart:convert';
import 'package:mana_employee_fe/model/home/banners/respone_banner_model.dart';
class ApiServiceBanner {
  static const String baseUrl = 'http://192.168.1.17:4000';

  Future<List<BannerDataModel>> getBanner () async {
  var url = Uri.parse('$baseUrl/banners');

    var headers = {
      'accept': 'application/json',
    };

    var response = await http.get(url, headers: headers);
    var responseData = json.decode(response.body);
    if (response.statusCode == 200) {
      
      var respone = ResponeBannerDataModel.fromJson(responseData);
      return respone.data!;
 
    } else {
      throw Exception('Fail to call API getlist');
    }
}


  
  

}
