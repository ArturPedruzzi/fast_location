import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../controller/address_controller.dart';
import '../model/address_model.dart';
import '../../../shared/colors/colors.dart';

class QueriedAddressesList extends StatelessWidget {
  final AddressController controller;

  QueriedAddressesList({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        if (controller.addresses.isEmpty) {
          return const Center(
            child: Text(
              'Nenhum endereço consultado.',
              style: TextStyle(color: AppColors.primary, fontSize: 18),
            ),
          );
        }

        return ListView.builder(
          itemCount: controller.addresses.length,
          itemBuilder: (context, index) {
            final AddressModel address = controller.addresses[index];

            return Card(
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: ListTile(
                title: Text(
                  address.logradouro.isEmpty ? 'Endereço desconhecido' : address.logradouro,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, color: AppColors.black),
                ),
                subtitle: Text(
                  '${address.bairro}, ${address.cidade}, ${address.uf}',
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
      },
    );
  }
}
