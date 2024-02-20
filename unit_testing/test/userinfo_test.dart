
import 'package:flutter_test/flutter_test.dart';
import 'package:unit_testing/userinfo.dart';
import 'package:unit_testing/addressinfo.dart';
import 'package:unit_testing/province.dart';
import 'package:unit_testing/district.dart';
import 'package:unit_testing/ward.dart';

void main() {
  group('Test UserInfo', () {
    test('constructor', () {
      final userInfo = UserInfo(
        name: 'Mai Thị Diễm',
        email: 'maidiem1314@gmail.com',
        phoneNumber: '0372384772',
        birthDate: '29/10/2003',
      );

      final address = AddressInfo(
        province:
            Province(id: '01', name: 'Hà Nội', level: 'Thành phố Trung ương'),
        district: District(
            id: '021', name: 'Bắc Từ Liêm', level: 'Quận', provinceId: '01'),
        ward: Ward(
            id: '00602',
            name: 'Phường Đức Thắng',
            level: 'Phường',
            districtId: '012',
            provinceId: '01'),
        street: 'Lê Văn Hiến',
      );

      expect(userInfo.name, equals('Mai Thị Diễm'));
      expect(userInfo.email, equals('maidiem1314@gmail.com'));
      expect(userInfo.phoneNumber, equals('0372384772'));
      expect(userInfo.birthDate, equals('29/10/2003'));
      expect(address.province?.id, equals('01'));
      expect(address.district?.id, equals('021'));
      expect(address.ward?.id, equals('00602'));
      expect(address.street, equals('Lê Văn Hiến'));
    });

    test('fromMap', ()
    {
      final userInfoMap = {
        'name': 'Mai Thị Diễm',
        'email': 'maidiem1314@gmail.com',
        'phoneNumber': '0372384772',
        'birthDate': '29/10/2003',
        'address': {
          'province': {
            'id': '01',
            'name': 'Hà Nội',
            'level': 'Thành phố Trung ương'
          },
          'district': {
            'id': '021',
            'name': 'Bắc Từ Liêm',
            'level': 'Quận',
            'provinceId': '01'
          },
          'ward': {
            'id': '00602',
            'name': 'Phường Đức Thắng',
            'level': 'Phường',
            'districtId': '012',
            'provinceId': '01'
          },
          'street': 'Lê Văn Hiến',
        }
      };
      final userInfo = UserInfo.fromMap(userInfoMap);

      expect(userInfo.name, 'Mai Thị Diễm');
      expect(userInfo.email, 'maidiem1314@gmail.com');
      expect(userInfo.phoneNumber, '0372384772');
      expect(userInfo.birthDate, '29/10/2003');
      expect(userInfo.address!.province!.name, 'Hà Nội');
      expect(userInfo.address!.district!.name, 'Bắc Từ Liêm');
      expect(userInfo.address!.ward!.name, 'Phường Đức Thắng');
      expect(userInfo.address!.street, 'Lê Văn Hiến');
    });
  });
}
