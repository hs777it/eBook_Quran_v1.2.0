import 'dart:convert';

import 'package:http/http.dart';

import 'api_constant.dart';

class ApiClient{

  final Client _client;

  ApiClient(this._client);

  dynamic get(String path) async{
    final response = await _client.get('${ApiConstant.BASE_URL+ApiConstant.API}$path');
    if (response.statusCode == 200) {
      return json.decode(response.body);
    }  else {
      throw Exception(response.reasonPhrase);
    }
  }
}