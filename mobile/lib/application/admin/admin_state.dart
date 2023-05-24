part of 'admin_bloc.dart';

abstract class AdminState extends Equatable{
const AdminState();

@override
  List<Object> get props => [];

  void maybeMap({required Null Function() orElse, required Null Function(dynamic state) addUserSuccess, required Null Function(dynamic state) addUserFailure}) {}
}


class AdminLoadingState extends AdminState {}

class AdminSuccessState extends AdminState {
  
  List<AdminDomain> adminDomains;

  AdminSuccessState({required this.adminDomains});

  @override
  List<Object> get props => [adminDomains];
}


class AdminFailureState extends AdminState{
  final Object error ;

  AdminFailureState({required this.error});

  @override
  List<Object> get props => [error];
}