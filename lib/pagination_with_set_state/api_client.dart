import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:pagination_example/pagination_with_set_state/user_model.dart';

class ApiClient {
  ApiClient();
  Future<dynamic> callApi(int pageNumber) async {
    final response = await Dio()
        .get('https://randomuser.me/api/?page=$pageNumber&results=15&seed=abc');
    try {
      if (response.statusCode == 200) {
        final responseData = response.data;
        //print(responseData);
        final model = UserModel.fromJson(responseData);
        return model.results;
        //print(model.results.runtimeType);
        //return model.results;
      } else {
        print('Error occurred !!!!');
      }
    } catch (e) {
      print('!!!! Exception Occurred $e ');
    }
  }
}
