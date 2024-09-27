import 'package:hive/hive.dart';
import '../../modules/home/model/address_model.dart';

class AddressStorage {
  final String _boxName = 'addressBox';

  Future<void> saveAddress(AddressModel address) async {
    var box = await Hive.openBox<AddressModel>(_boxName);
    await box.put(address.cep, address); 
  }

  Future<AddressModel?> getAddress(String cep) async {
    var box = await Hive.openBox<AddressModel>(_boxName);
    return box.get(cep); 
  }

  Future<List<AddressModel>> getAllAddresses() async {
    var box = await Hive.openBox<AddressModel>(_boxName);
    return box.values.toList();
  }

  Future<void> clearAddresses() async {
    var box = await Hive.openBox<AddressModel>(_boxName);
    await box.clear();
  }
}
