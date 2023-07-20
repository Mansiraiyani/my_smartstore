import 'package:dio/dio.dart';

import '../../constants.dart';

class SignUpRepository{
  final Dio dio = Dio();
  Future<dynamic> requestotp(email,phone) async{
    print(email);
    print(phone);
    final response = await dio.post("$BASE_URL/request_otp/",data: {'email':email,
    'phone':phone,});
    print("=====> ${response}");
    return response;


    // final response = await dio.post(BASE_URL+"/request_otp/",data: {'email':email,
    //   'phone':phone,});
    // print(response);
    // return response;
  }

}