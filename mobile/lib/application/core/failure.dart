import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  @override
  List<Object?> get props => [];
}


class ServerFailure extends Failure {
  final String message;
  ServerFailure({required this.message});
  @override
  List<Object?> get props => [message];
}

class CacheFailure extends Failure {
  final String message;
  CacheFailure({required this.message});
  @override
  List<Object?> get props => [message];
}

class NetworkFailure extends Failure {
  final String message;
  NetworkFailure({required this.message});
  @override
  List<Object?> get props => [message];
}