import 'package:charge_station_finder/common/exceptions/HttpException.dart';

class ServerException extends HttpException {
  ServerException(super.message, super.statusCode);

  @override
  String toString() {
    return "ServerException: $message, statusCode: $statusCode";
  }
}
