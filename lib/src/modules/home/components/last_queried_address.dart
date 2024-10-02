import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../controller/address_controller.dart';
import '../model/address_model.dart';
import '../../../shared/colors/colors.dart';

class LastQueriedAddress extends StatelessWidget {
  final AddressController controller;

  LastQueriedAddress({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        final AddressModel? lastAddress = controller.getLastQueriedAddress();

        if (lastAddress == null) {
          return const Center(
            child: Text(
              'Nenhum endereço consultado.',
              style: TextStyle(color: AppColors.primary, fontSize: 18),
            ),
          );
        }

        return Card(
          margin: const EdgeInsets.symmetric(vertical: 8),
          child: ListTile(
            title: Text(
              lastAddress.logradouro ?? 'Endereço desconhecido',
              style: const TextStyle(
                  fontWeight: FontWeight.bold, color: AppColors.black),
            ),
            subtitle: Text(
              '${lastAddress.bairro}, ${lastAddress.cidade}, ${lastAddress.uf}',
              style: const TextStyle(color: AppColors.black),
            ),
            trailing: const Icon(Icons.location_on, color: AppColors.primary),
            onTap: () {
              // Ação quando o item for tocado (se necessário)
            },
          ),
        );
      },
    );
  }
}
