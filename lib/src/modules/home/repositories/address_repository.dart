import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/address_model.dart';
import '../../../shared/storage/address_storage.dart';

class AddressRepository {
  final String apiUrl = 'https://viacep.com.br/ws';
  final AddressStorage localStorage = AddressStorage();

  Future<AddressModel> fetchAddress(String cep) async {
    if (cep.length != 8 || !RegExp(r'^[0-9]+$').hasMatch(cep)) {
      throw Exception('CEP inválido.');
    }

    final response = await http.get(Uri.parse('$apiUrl/$cep/json/'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      if (data['erro'] == true) {
        throw Exception('CEP não encontrado.');
      }

      final address = AddressModel.fromJson(data);
      await localStorage.saveAddress(address); 
      return address;
    } else {
      throw Exception('Erro ao carregar o endereço. Código de status: ${response.statusCode}');
    }
  }

  Future<AddressModel?> getStoredAddress(String cep) async {
    return await localStorage.getAddress(cep); 
  }
}
