import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fast_location/main.dart';
import 'package:fast_location/src/modules/home/controller/address_controller.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Instancie o AddressController antes de passar para o MyApp
    final AddressController addressController = AddressController();

    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp(addressController: addressController));

    // Verify that our counter starts at 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
}
