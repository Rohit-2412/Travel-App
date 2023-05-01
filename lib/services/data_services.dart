import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/data_model.dart';

class DataServices {
  String baseURL = "http://mark.bslmeiyu.com/api";

  Future<List<DataModel>> getInfo() async {
    var apiURL = "/getplaces";

    http.Response res = await http.get(Uri.parse(baseURL + apiURL));

    try {
      if (res.statusCode == 200) {
        // decoding the json response
        List<dynamic> list = json.decode(res.body);

        return list.map((e) => DataModel.fromJson(e)).toList();
      } else {
        return <DataModel>[];
      }
    } catch (e) {
      return <DataModel>[];
    }
  }
}
