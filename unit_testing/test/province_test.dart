import 'package:unit_testing/province.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Province? province;

  group('Test Province', () {
    test('constructor', () {
      province = Province(
        id: "01",
        name: "Hà Nội",
        level: "Thành phố Trung ương",
      );
      expect(province?.id, equals('01'));
      expect(province?.name, equals('Hà Nội'));
      expect(province?.level, equals('Thành phố Trung ương'));
    });

    test('fromMap', () {
      var province = {
        'id': '01',
        'name': 'Hà Nội',
        'level': 'Thành phố Trung ương',
      };

      var province_fromMap = Province.fromMap(province);
      expect(province_fromMap.id, equals('01'));
      expect(province_fromMap.name, equals('Hà Nội'));
      expect(province_fromMap.level, equals('Thành phố Trung ương'));
    });

    test('toMap', () {
      var province = Province(
        id: "01",
        name: "Hà Nội",
        level: "Thành phố Trung ương",
      );
      var province_toMap = province.toMap();
      expect(province_toMap['id'], equals('01'));
      expect(province_toMap['name'], equals('Hà Nội'));
      expect(province_toMap['level'], equals('Thành phố Trung ương'));
    });
  });
}
