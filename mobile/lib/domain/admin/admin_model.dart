

import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class AdminDomain extends Equatable {

  String? id;
  final String name;
  final String email;
  final String role;


  AdminDomain({
    this.id,
    required this.email,
    required this.name,
    required this.role
  });
  
  @override
  List<Object?> get props => [name, id, email, role];
  
}