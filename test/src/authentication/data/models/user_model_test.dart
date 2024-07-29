import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:tdd_tutorial/core/utils/typedef.dart';
import 'package:tdd_tutorial/src/authentication/data/models/user_model.dart';
import 'package:tdd_tutorial/src/authentication/domain/entities/user.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  const tModel = UserModel.empty();

  final tJson = fixture('user.json');
  final tMap = jsonDecode(tJson) as DataMap;

  test('Should be a subclass of [User] entity', () {
    expect(tModel, isA<User>());
  });

  group('fromMap', () {
    test('Should return a [UserModel] with the right data', () {
      // Arrange
      final result = UserModel.fromMap(tMap);
      expect(result, equals(tModel));
    });
  });

  group('fromJson', () {
    test('Should return a [UserModel] with the right data', () {
      // Arrange
      final result = UserModel.fromJson(tJson);
      expect(result, equals(tModel));
    });
  });

  group('toMap', () {
    test('Should return a [Map] with the right data', () {
      final result = tModel.toMap();
      expect(result, equals(tMap));
    });
  });

  group('toJson', () {
    test('Should return a [Json] with the right data', () {
      final result = tModel.toJson();

      final tJson = jsonEncode({"id": "1", "avatar": "_empty.avatar", "createdAt": "_empty.createdAt", "name": "_empty.name"});

      expect(result, equals(tJson));
    });
  });

  group('copyWith', () {
    test('Should return a [UserModel] with different data', () {
      final result = tModel.copyWith(name: 'Bruno');

      expect(result.name, equals('Bruno'));
      expect(result.name, equals('Bruno'));
    });
  });
}
