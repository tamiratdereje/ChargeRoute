import 'dart:convert';

import '../../../utils/custom_http_client.dart';
import '../../dto/charger_dto.dart';

class RemoteChargerSource {
  final CustomHttpClient httpClient;

  RemoteChargerSource(this.httpClient);

  Future<void> addCharger(ChargerDto form) async {
    httpClient.post('/chargeStation', body: json.encode(form.toJson()));
  }

  Future<void> deleteCharger(String id) async {
    httpClient.delete('/chargeStation/$id');
  }

  Future<void> editCharger(ChargerDto form) async {
    httpClient.put('/chargeStation/${form.id!}',
        body: json.encode(form.toJson()));
  }

  Future<ChargerDto> getCharger(String id) async {
    final response = await httpClient.get('/chargeStation/$id');
    return ChargerDto.fromJson(json.decode(response.body));
  }

  Future<List<ChargerDto>> getChargersByAddress(String address) {
    final response = httpClient.post('/chargeStation/search',
        body: json.encode({
          'address': address,
        }));
    return response.then((value) => (json.decode(value.body)["data"] as List)
        .map((e) => ChargerDto.fromJson(e))
        .toList());
  }
}
