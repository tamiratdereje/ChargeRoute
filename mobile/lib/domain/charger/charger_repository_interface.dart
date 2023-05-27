import 'dart:ffi';

import 'package:charge_station_finder/common/failure.dart';
import 'package:charge_station_finder/domain/charger/charger.dart';
import 'package:charge_station_finder/domain/charger/charger_form.dart';
import 'package:dartz/dartz.dart';

import 'charger_detail.dart';

abstract class ChargerRepositoryInterface {
  Future<Either<Failure, List<Charger>>> fetchChargers(String address);

  Future<Either<Failure, List<Charger>>> getChargersByAddress(String address);

  Future<Either<Failure, ChargerDetail>> getChargerDetail(String id);

  Future<Either<Failure, void>> addCharger(ChargerForm form);

  Future<Either<Failure, void>> editCharger(ChargerForm form, String id);

  Future<Either<Failure, void>> deleteCharger(String id);
}
