import 'package:mobx/mobx.dart';
import '../repositories/address_repository.dart';
import '../model/address_model.dart';

part 'address_controller.g.dart';

// ignore: library_private_types_in_public_api
class AddressController = _AddressController with _$AddressController;

abstract class _AddressController with Store {
  final AddressRepository _addressRepository = AddressRepository();

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
      final addressResult = await _addressRepository.fetchAddress(cep);

      if (addressResult.erro == true) {
        errorMessage = 'CEP não encontrado.';
      } else {
        address = addressResult;

        // Verifica se o endereço já existe na lista
        final alreadyExists = addresses.any((a) => a.cep == address!.cep);

        if (!alreadyExists) {
          addresses.add(address!);
          await _addressRepository.saveAddress(address!); // Salva o endereço no repositório
        }
      }
    } catch (e) {
      errorMessage = 'Erro ao buscar o endereço. Verifique o CEP e tente novamente.';
    }
  }

  @action
  Future<void> loadStoredAddresses() async {
    try {
      final storedAddresses = await _addressRepository.getStoredAddresses();

      // Verificar se os endereços armazenados já estão na lista
      for (var storedAddress in storedAddresses) {
        final alreadyExists = addresses.any((a) => a.cep == storedAddress.cep);
        if (!alreadyExists) {
          addresses.add(storedAddress);
        }
      }
    } catch (e) {
      errorMessage = 'Erro ao carregar endereços armazenados.';
    }
  }

  // Método auxiliar para retornar o último endereço pesquisado
  @computed
  AddressModel? getLastQueriedAddress() {
    return addresses.isNotEmpty ? addresses.last : null;
  }
}
