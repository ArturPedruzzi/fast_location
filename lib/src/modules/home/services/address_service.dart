import '../repositories/address_repository.dart';
import '../model/address_model.dart';

class AddressService {
  final AddressRepository _addressRepository = AddressRepository();

  Future<AddressModel> getAddress(String cep) {
    return _addressRepository.fetchAddress(cep);
  }
}
