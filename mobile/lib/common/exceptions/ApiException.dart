import 'package:charge_station_finder/common/exceptions/HttpException.dart';

class ApiException extends HttpException {
  ApiException(super.message, super.statusCode);

  @override
  String toString() {
    return "ApiException: $message, statusCode: $statusCode";
  }
}
