part of 'admin_bloc.dart';

abstract class AdminEvent extends Equatable {
  const AdminEvent();
  
  @override
  List<Object> get props => [];
}

class AdminGetUsersEvent extends AdminEvent {
  AdminGetUsersEvent();

  
  @override
  List<Object> get props => [];
}



class AdminDeleteUserEvent extends AdminEvent {
  List<AdminDomain> adminDomains = [];


  String id;
  AdminDeleteUserEvent({required this.id, required this.adminDomains});

  
  @override
  List<Object> get props => [];
}



class AdminCreateUserEvent extends AdminEvent {

  final AdminDomain adminDomain;
  AdminCreateUserEvent({required this.adminDomain});

  @override
  List<Object> get props => [];
}


class AdminUpdateUserEvent extends AdminEvent {
  List<AdminDomain> adminDomains = [];

  final AdminDomain adminDomain;
  AdminUpdateUserEvent({required this.adminDomain, required this.adminDomains});

  @override
  List<Object> get props => [];
}


class AdminUserDetailEvent extends AdminEvent {

  final AdminDomain adminDomain;
  AdminUserDetailEvent({required this.adminDomain});

  @override
  List<Object> get props => [];
}


