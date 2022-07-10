import 'package:flutter_test/flutter_test.dart';
import 'package:yookassa_sdk_platform_interface/src/models/models.dart';

void main() {
  test('GooglePayCardNetwork should contain 7 options', () {
    const List<GooglePayCardNetwork> values = GooglePayCardNetwork.values;

    expect(values.length, 7);
  });

  test('GooglePayCardNetwork enum should have items in correct index', () {
    const List<GooglePayCardNetwork> values = GooglePayCardNetwork.values;

    expect(values[0], GooglePayCardNetwork.amex);
    expect(values[1], GooglePayCardNetwork.discover);
    expect(values[2], GooglePayCardNetwork.jcb);
    expect(values[3], GooglePayCardNetwork.mastercard);
    expect(values[4], GooglePayCardNetwork.visa);
    expect(values[5], GooglePayCardNetwork.interac);
    expect(values[6], GooglePayCardNetwork.other);
  });

  test('GooglePayCardNetwork should have correct values', () {
    const List<GooglePayCardNetwork> values = GooglePayCardNetwork.values;

    expect(values[0].name, 'amex');
    expect(values[1].name, 'discover');
    expect(values[2].name, 'jcb');
    expect(values[3].name, 'mastercard');
    expect(values[4].name, 'visa');
    expect(values[5].name, 'interac');
    expect(values[6].name, 'other');
  });
}
