import 'package:dio/dio.dart';

import '../../constants.dart';

class SignUpRepository{
  final Dio dio = Dio();
  Future<Response> requestotp(email,phone) async{
    final response = await dio.post(BASE_URL+"/request_otp/",data: {'email':email,
    'phone':phone,});
    return response;
  }

}