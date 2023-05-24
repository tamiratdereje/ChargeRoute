
import 'dart:async';

import 'package:charge_station_finder/infrastructure/admin/admin_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:charge_station_finder/domain/admin/admin_model.dart';
import 'package:equatable/equatable.dart';

part 'admin_event.dart';
part 'admin_state.dart';

class AdminBloc extends Bloc<AdminEvent, AdminState> {
  AdminRepository adminRepository = AdminRepository();

  AdminBloc() : super(AdminLoadingState()) {


    on<AdminCreateUserEvent>(((event, emit) async{
      
      try {
        emit(AdminLoadingState());
        await adminRepository.createUser(event.adminDomain);
        emit(AdminSuccessState(adminDomains: [event.adminDomain]));
        
      } catch (e) {

        emit(AdminFailureState(error: e.toString())); 
        
      }

    }));

    on<AdminDeleteUserEvent>(((event, emit) async {
      
      try {
        emit(AdminLoadingState());
        List<AdminDomain> adminDomain =  AdminDomain(email: "dummy", name: "yeab", role: "provider") as List<AdminDomain>;
        await adminRepository.deleteUser(event.id);
        emit(AdminSuccessState(adminDomains: adminDomain));

      } catch (e) {
        emit(AdminFailureState(error: e)); 
      }

    }));

    on<AdminGetUsersEvent>(((event, emit) async {
      
      try {
        emit(AdminLoadingState());
        List<AdminDomain> adminDomains = await adminRepository.getUsers();
        emit(AdminSuccessState(adminDomains: adminDomains));
        
      } catch (e) {
         emit(AdminFailureState(error: e)); 
      }

    }));


    on<AdminUpdateUserEvent>(((event, emit) async {
      
      try {
        emit(AdminLoadingState());
        List<AdminDomain> adminDomains = event.adminDomain as List<AdminDomain>;
        await adminRepository.editUser(event.adminDomain);
        emit(AdminSuccessState(adminDomains: adminDomains));
        
      } catch (e) {
        emit(AdminFailureState(error: e)); 
      }

    }));

    on<AdminUserDetailEvent> (((event, emit) async {
      
      try {
        emit(AdminLoadingState());
        await Timer(Duration(seconds: 2), () => print('two seconds'));
        // AdminDomain adminDomain = await adminRepository.getUser(event.adminDomain.id!);
        emit(AdminSuccessState(adminDomains: [event.adminDomain]));
        
      } catch (e) {
        emit(AdminFailureState(error: e)); 
      }

    }));

  }
}
