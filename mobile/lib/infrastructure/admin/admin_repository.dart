import 'package:charge_station_finder/domain/admin/admin_model.dart';
import 'package:charge_station_finder/infrastructure/admin/admin_dto.dart';
import 'package:charge_station_finder/infrastructure/admin/admin_provider.dart';

class AdminRepository {
  AdminProvider adminProvider = AdminProvider();

  Future<void> createUser(AdminDomain adminDomain) async {
    AdminModel adminModel = AdminModel(
      id: adminDomain.id,
      name: adminDomain.name,
      email: adminDomain.email,
      role: adminDomain.role,
      password: adminDomain.password,
    );

    await adminProvider.createUser(adminModel);
  }

  Future<void> editUser(AdminDomain adminDomain) async {
    AdminModel adminModel = AdminModel(
        id: adminDomain.id,
        email: adminDomain.email,
        name: adminDomain.name,
        role: adminDomain.role,
        password: adminDomain.password

        );

    await adminProvider.editUser(adminModel);
  }

  Future<void> deleteUser(String id) async {
    await adminProvider.deleteUser(id);
  }

  Future<List<AdminDomain>> getUsers() async {
    // write a code to get all users
    List<AdminModel> adminModel = await adminProvider.getUsers();

    List<AdminDomain> adminDomain = adminModel
        .map((e) => AdminDomain(
              id: e.id ?? '',
              name: e.name,
              email: e.email,
              role: e.role,
              password: e.password ?? '',
            ))
        .toList();
        
    return adminDomain;
  }

  Future<AdminDomain> getUser(String id) async {
    AdminModel adminModel = await adminProvider.getUser(id);

    AdminDomain adminDomain = AdminDomain(
      id: adminModel.id ?? '',
      name: adminModel.name,
      email: adminModel.email,
      role: adminModel.role,
      password: adminModel.password ?? '',
    );
    return adminDomain;
  }
}
