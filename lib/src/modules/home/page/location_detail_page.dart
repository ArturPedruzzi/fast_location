import 'package:fast_location/src/modules/home/controller/address_controller.dart';
import 'package:fast_location/src/shared/colors/colors.dart';
import 'package:fast_location/src/shared/components/custom_button.dart';
import 'package:fast_location/src/shared/components/navigation_circle.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:map_launcher/map_launcher.dart';
import '../model/address_model.dart';
import '../components/empty_search.dart';

class LocationDetailPage extends StatelessWidget {
  final AddressController controller = AddressController();
  final AddressModel address;

  LocationDetailPage({super.key, required this.address});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Observer(
        builder: (_) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.multiple_stop,
                          size: 40, color: AppColors.primary),
                      SizedBox(width: 10),
                      Text(
                        'Fast Location',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(183, 222, 222, 222),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Observer(
                      builder: (_) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: double.infinity,
                              child: const Text(
                                'Dados da Localização',
                                style: TextStyle(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            const SizedBox(height: 10),
                            _buildRow('Logradouro/Rua:', address.logradouro),
                            _buildRow('Bairro/Distrito:', address.bairro),
                            _buildRow('Complemento:', address.complemento),
                            _buildRow('Cidade/UF:',
                                '${address.cidade}/${address.uf}'),
                            _buildRow('CEP:', address.cep),
                          ],
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 30),
                  CustomButton(
                    label: 'Localizar endereço',
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          final TextEditingController cepController =
                              TextEditingController();
                          return StatefulBuilder(
                            builder: (context, setState) {
                              return Dialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Container(
                                  width: 400,
                                  padding: const EdgeInsets.all(30),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      TextField(
                                        controller: cepController,
                                        decoration: const InputDecoration(
                                          labelText: 'Digite o CEP',
                                          counterText: "",
                                        ),
                                        keyboardType: TextInputType.number,
                                        maxLength: 8,
                                        inputFormatters: <TextInputFormatter>[
                                          FilteringTextInputFormatter
                                              .digitsOnly,
                                        ],
                                      ),
                                      const SizedBox(height: 20),
                                      Observer(
                                        builder: (_) {
                                          if (controller
                                              .errorMessage.isNotEmpty) {
                                            return Column(
                                              children: [
                                                Text(
                                                  controller.errorMessage,
                                                  style: const TextStyle(
                                                      color: AppColors.red,
                                                      fontSize: 14),
                                                  textAlign: TextAlign.center,
                                                ),
                                                const SizedBox(height: 20),
                                              ],
                                            );
                                          }
                                          return const SizedBox();
                                        },
                                      ),
                                      CustomButton(
                                        label: 'Buscar',
                                        onPressed: () async {
                                          final String cep = cepController.text;
                                          await controller.fetchAddress(cep);

                                          if (controller.address != null) {
                                            navigateToLocationDetail(
                                                context, controller.address);
                                          }
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      );
                    },
                  ),
                  const SizedBox(height: 40),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(Icons.location_on,
                          size: 25, color: AppColors.primary),
                      Text(
                        'Últimos endereços localizados',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Observer(
                    builder: (_) {
                      return const EmptySearchWidget();
                    },
                  ),
                  const SizedBox(height: 20),
                  CustomButton(
                    label: 'Histórico de endereços',
                    onPressed: () {
                      Navigator.pushNamed(context, '/history');
                    },
                  ),
                  const SizedBox(height: 60),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary,
        onPressed: () async {
          final String query =
              '${address.logradouro}, ${address.bairro}, ${address.cidade}, ${address.uf}';

          final availableMaps = await MapLauncher.installedMaps;

          await availableMaps
              .firstWhere((map) => map.mapName == "Google Maps")
              .showMarker(
                coords: Coords(0, 0),
                title: query,
              );
        },
        shape: const CircleBorder(),
        child: const Icon(Icons.fork_right, color: AppColors.white, size: 40),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: const SizedBox(
        height: 40,
        child: BottomAppBar(
          color: AppColors.white,
          shape: CircularNotchedRectangle(),
        ),
      ),
    );
  }

  Widget _buildRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
              color: AppColors.primary, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 30, width: 8),
        Expanded(
          child: Text(
            value.isEmpty ? "N/A" : value,
            style: const TextStyle(color: AppColors.black),
          ),
        ),
      ],
    );
  }
}
