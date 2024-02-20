import 'package:unit_testing/ward.dart';
import 'package:flutter_test/flutter_test.dart';

void  main(){
  Ward? ward;

  group('Test Ward', () {
    test('constructor', () {
      ward = Ward(
        id: "00602",
        name: "Phường Đức Thắng",
        level: "Phường",
        districtId: "021",
        provinceId: "01",
      );
      expect(ward?.id, equals('00602'));
      expect(ward?.name, equals('Phường Đức Thắng'));
      expect(ward?.level, equals('Phường'));
      expect(ward?.districtId, equals('021'));
      expect(ward?.provinceId, equals('01'));
    });

    test('fromMap', () {
      var ward = {
        'id': '00602',
        'name': 'Phường Đức Thắng',
        'level': 'Phường',
        'districtId': '021',
        'provinceId': '01',
      };

      var ward_fromMap = Ward.fromMap(ward);
      expect(ward_fromMap.id, equals('00602'));
      expect(ward_fromMap.name, equals('Phường Đức Thắng'));
      expect(ward_fromMap.level, equals('Phường'));
      expect(ward_fromMap.districtId, equals('021'));
      expect(ward_fromMap.provinceId, equals('01'));
    });

    test('toMap', () {
      var ward = Ward(
        id: "00602",
        name: "Phường Đức Thắng",
        level: "Phường",
        districtId: "021",
        provinceId: "01",
      );
      var ward_toMap = ward.toMap();
      expect(ward_toMap['id'], equals('00602'));
      expect(ward_toMap['name'], equals('Phường Đức Thắng'));
      expect(ward_toMap['level'], equals('Phường'));
      expect(ward_toMap['districtId'], equals('021'));
      expect(ward_toMap['provinceId'], equals('01'));
    });
  });
}