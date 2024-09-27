import 'package:flutter/material.dart';
import '../../modules/initial/page/loading_page.dart';
import '../../modules/home/page/location_detail_page.dart';
import '../../modules/home/model/address_model.dart';

void navigateToLocationDetail(BuildContext context, AddressModel? address) {
  if (address != null) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => SplashPage(
          nextPage: LocationDetailPage(address: address), 
        ),
      ),
    );
  }
}
