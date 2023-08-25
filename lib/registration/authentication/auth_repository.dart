import 'dart:io';

import 'package:dio/dio.dart';
import 'package:my_smartstore/constants.dart';

class AuthRepository {
  final Dio dio = Dio();
  Future<Response> getUserDate({required String token}) async {
    var response = await dio.get("$BASE_URL/userdata/",
        options: Options(headers: {HttpHeaders.authorizationHeader: token}));
    return response;
  }
}
