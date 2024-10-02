import 'package:flutter/material.dart';
import '../components/queried_addresses_list.dart';
import '../controller/address_controller.dart';
import '../../../shared/colors/colors.dart';

class HistoryPage extends StatefulWidget {
  final AddressController controller;

  HistoryPage({Key? key, required this.controller}) : super(key: key);

  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  void initState() {
    super.initState();
    widget.controller.loadStoredAddresses(); // Carrega os endereços do Hive
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Histórico de Consultas',
          style: TextStyle(color: AppColors.white),
        ),
        backgroundColor: AppColors.primary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: QueriedAddressesList(controller: widget.controller),
      ),
    );
  }
}
