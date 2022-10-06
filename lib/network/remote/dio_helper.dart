import 'package:dio/dio.dart';

class DioHelper {
  static Dio? dio;

  static init()
  {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://fcm.googleapis.com/fcm/',
        receiveDataWhenStatusError: true,
      ),
    );
  }

  static Future<Response> postData({
    required Map<String, dynamic> data,
    Map<String, dynamic>? query,
  }) async
  {
    dio!.options.headers =
    {
      'Authorization': 'key=AAAAt6laR5g:APA91bHKRXNzC5olmsYdGa7fABTXbtHc8Kcpd6q7ywHFIuQlfj6JxWXF_ieMRMSqg0-wto_Xx9gUPECrip7xGZfTrUWDMFe9KaSM7d1U5K6m1tfgjoVFo-SnS9Kovld1EQm6Voocp4Kg',
      'Content-Type': 'application/json',
    };

    return dio!.post(
      'send',
      queryParameters: query,
      data: data,
    );
  }
}