import 'package:fast_location/src/shared/colors/colors.dart';
import 'package:flutter/material.dart';
import 'src/modules/initial/page/loading_page.dart';
import 'src/modules/home/page/home_page.dart';
import 'src/routes/app_routes.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'src/modules/home/model/address_model.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(AddressModelAdapter());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fast Location',
      initialRoute: '/',
      routes: {
        '/': (context) => SplashPage(nextPage: HomePage()),
        AppRoutes.searchLocation: (context) => HomePage(),
      },
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
        useMaterial3: true,
        scaffoldBackgroundColor: AppColors.secondary,
      ),
    );
  }
}
