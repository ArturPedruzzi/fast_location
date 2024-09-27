import 'package:mobx/mobx.dart';
import '../services/address_service.dart';
import '../model/address_model.dart';
part 'address_controller.g.dart';

// ignore: library_private_types_in_public_api
class AddressController = _AddressController with _$AddressController;

abstract class _AddressController with Store {
  final AddressService _addressService = AddressService();

  @observable
  AddressModel? address;

  @observable
  String errorMessage = '';

  @observable
  ObservableList<AddressModel> addresses = ObservableList<AddressModel>();

  @action
  Future<void> fetchAddress(String cep) async {
    if (cep.length != 8 || !RegExp(r'^[0-9]+$').hasMatch(cep)) {
      errorMessage = 'CEP inválido.';
      return;
    }

    errorMessage = '';

    try {
      final addressResult = await _addressService.getAddress(cep);

      if (addressResult.erro == true) {
        errorMessage = 'CEP não encontrado.';

      } else {
        address = addressResult;
        addresses.add(address!);
      }
    } catch (e) {
      errorMessage = 'Erro ao buscar o endereço. Verifique o CEP e tente novamente.';

    }
  }
}
