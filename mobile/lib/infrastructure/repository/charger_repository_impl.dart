import 'package:charge_station_finder/common/exceptions/ApiException.dart';
import 'package:charge_station_finder/common/exceptions/ServerException.dart';
import 'package:charge_station_finder/common/failure.dart';
import 'package:charge_station_finder/domain/charger/charger.dart';
import 'package:charge_station_finder/domain/charger/charger_detail.dart';
import 'package:charge_station_finder/domain/charger/charger_form.dart';
import 'package:charge_station_finder/domain/charger/charger_repository_interface.dart';
import 'package:charge_station_finder/domain/review/review_repository_interface.dart';
import 'package:charge_station_finder/infrastructure/data-source/local/database.dart';
import 'package:charge_station_finder/infrastructure/dto/charger_dto.dart';
import 'package:charge_station_finder/utils/custom_http_client.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/widgets.dart';

import '../data-source/remote/charger_service.dart';

class ChargerRepositoryImpl extends ChargerRepositoryInterface {
  late final RemoteChargerSource remoteChargerSource;
  final ReviewRepositoryInterface reviewRepository;

  ChargerRepositoryImpl(
      {required CustomHttpClient httpClient, required this.reviewRepository}) {
    remoteChargerSource = RemoteChargerSource(httpClient);
  }

  @override
  Future<Either<Failure, void>> addCharger(ChargerForm form) async {
    try {
      await remoteChargerSource.addCharger(
        ChargerDto(
          null,
          form.name,
          form.description,
          form.address,
          form.phone,
          form.wattage,
          null,
        ),
      );
      return right(null);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    } on ApiException catch (e) {
      return left(Failure(e.message));
    } on Exception catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteCharger(String id) async {
    try {
      await remoteChargerSource.deleteCharger(id);
      return right(null);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    } on ApiException catch (e) {
      return left(Failure(e.message));
    } on Exception catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> editCharger(ChargerForm form, String id) async {
    try {
      await remoteChargerSource.editCharger(ChargerDto(id, form.name,
          form.description, form.address, form.phone, form.wattage, null));
      return right(null);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    } on ApiException catch (e) {
      return left(Failure(e.message));
    } on Exception catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, ChargerDetail>> getChargerDetail(String id) async {
    try {
      return await remoteChargerSource.getCharger(id).then((value) async {
        return right(ChargerDetail(
          id: value.id!,
          description: value.description,
          phone: value.phone,
          name: value.name,
          address: value.address,
          rating: value.rating!,
          wattage: value.wattage,
          reviews: [],
        ));
      });
    } on ServerException catch (e) {
      return left(Failure(e.message));
    } on ApiException catch (e) {
      return left(Failure(e.message));
    } on Exception catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Charger>>> fetchChargers(String address) async {
    try {
      var res = await remoteChargerSource.getChargersByAddress(address);
      await CRDatabase.deleteChargers();
      debugPrint("Deleting chargers");
      await CRDatabase.insertChargers(res.map((e) => e.toJson()).toList());
      var local_result = await CRDatabase.getChargers(address);
      return right(local_result);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    } on ApiException catch (e) {
      return left(Failure(e.message));
    } on Exception catch (e) {
      debugPrint(e.toString());
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Charger>>> getChargersByAddress(
      String address) async {
    try {
      var res = await CRDatabase.getChargers(address);
      debugPrint(res.toString());
      return right(res);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    } on ApiException catch (e) {
      return left(Failure(e.message));
    } on Exception catch (e) {
      debugPrint(e.toString());
      return left(Failure(e.toString()));
    }
  }
}
