import 'package:fast_location/src/shared/colors/colors.dart';
import 'package:flutter/material.dart';
import 'src/modules/initial/page/loading_page.dart';
import 'src/modules/home/page/home_page.dart';
import 'src/routes/app_routes.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'src/modules/home/model/address_model.dart';
import 'src/modules/home/controller/address_controller.dart';  // Importa o controller
import 'src/modules/home/page/history_page.dart';  // Importa a página de histórico

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(AddressModelAdapter());

  final AddressController addressController = AddressController();  // Instância do AddressController

  runApp(MyApp(addressController: addressController));  // Passa o controller para o MyApp
}

class MyApp extends StatelessWidget {
  final AddressController addressController;

  // O AddressController é passado via construtor
  const MyApp({super.key, required this.addressController});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fast Location',
      initialRoute: '/',
      routes: {
        '/': (context) => SplashPage(nextPage: HomePage(controller: addressController)),  // Passa o controller para HomePage
        AppRoutes.searchLocation: (context) => HomePage(controller: addressController),  // Passa o controller para HomePage
        AppRoutes.history: (context) => HistoryPage(controller: addressController),  // Passa o controller para HistoryPage
      },
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
        useMaterial3: true,
        scaffoldBackgroundColor: AppColors.secondary,
      ),
    );
  }
}
