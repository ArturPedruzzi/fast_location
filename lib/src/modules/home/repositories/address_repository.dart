import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/address_model.dart';
import 'package:hive/hive.dart';

class AddressRepository {
  final String apiUrl = 'https://viacep.com.br/ws';

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

      // Salvando endereço no Hive
      final Box<AddressModel> box =
          await Hive.openBox<AddressModel>('addressBox');
      await box.put(address.cep, address); // Usando o CEP como chave

      return address;
    } else {
      throw Exception(
          'Erro ao carregar o endereço. Código de status: ${response.statusCode}');
    }
  }

  Future<AddressModel?> getStoredAddress(String cep) async {
    final Box<AddressModel> box =
        await Hive.openBox<AddressModel>('addressBox');
    return box.get(cep);
  }

  Future<List<AddressModel>> getStoredAddresses() async {
    final Box<AddressModel> box =
        await Hive.openBox<AddressModel>('addressBox');
    return box.values.toList();
  }

  Future<void> saveAddress(AddressModel address) async {
    final Box<AddressModel> box =
        await Hive.openBox<AddressModel>('addressBox');

    // Verifica se o endereço já está salvo antes de adicionar novamente
    if (!box.containsKey(address.cep)) {
      await box.put(address.cep, address);
    }
  }
}
