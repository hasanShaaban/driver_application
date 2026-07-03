import 'package:dio/dio.dart';

abstract class Failure {
  final String message;

  const Failure(this.message);
}

class ServerFailure extends Failure {
  ServerFailure(super.message);

  factory ServerFailure.fromDioException(DioException dioException) {
    switch (dioException.type) {
      case DioExceptionType.connectionTimeout:
        return ServerFailure('Connection timeout with server. Please try again.');
      case DioExceptionType.sendTimeout:
        return ServerFailure('Send timeout in connection with server. Please try again.');
      case DioExceptionType.receiveTimeout:
        return ServerFailure('Receive timeout in connection with server. Please try again.');
      case DioExceptionType.badCertificate:
        return ServerFailure('Bad certificate. Please check your connection.');
      case DioExceptionType.badResponse:
        return ServerFailure.fromResponse(
          dioException.response?.statusCode,
          dioException.response?.data,
        );
      case DioExceptionType.cancel:
        return ServerFailure('Request to server was canceled.');
      case DioExceptionType.connectionError:
        return ServerFailure('No Internet Connection. Please check your network.');
      case DioExceptionType.unknown:
        if (dioException.message != null && dioException.message!.contains('SocketException')) {
          return ServerFailure('No Internet Connection');
        }
        return ServerFailure('Unexpected Error, Please try again!');
    }
  }

  factory ServerFailure.fromResponse(int? statusCode, dynamic response) {
    // Custom logic to extract message from response
    // Adjust the key ('message', 'error', etc.) based on your API response structure
    String customMessage = 'Oops! There was an error, please try again.';
    
    if (response is Map<String, dynamic>) {
      if (response.containsKey('message')) {
        customMessage = response['message'];
      } else if (response.containsKey('error')) {
        if (response['error'] is String) {
          customMessage = response['error'];
        } else if (response['error'] is Map && response['error'].containsKey('message')) {
          customMessage = response['error']['message'];
        }
      }
    } else if (response is String) {
      customMessage = response;
    }

    if (customMessage == "There is no driver associated with the phone_number you provided.") {
      customMessage = 'لا يوجد حساب سائق مرتبط برقم الهاتف هذا.';
    } else if (customMessage == "Invalid credentials.") {
      customMessage = 'بيانات الدخول غير صحيحة.';
    }

    if (statusCode == 400 || statusCode == 401 || statusCode == 403) {
      return ServerFailure(customMessage);
    } else if (statusCode == 404) {
      return ServerFailure('Your request was not found, Please try later!');
    } else if (statusCode == 500) {
      return ServerFailure('Internal Server Error, Please try later!');
    } else {
      return ServerFailure(customMessage);
    }
  }
}
