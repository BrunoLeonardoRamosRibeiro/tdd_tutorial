import 'dart:convert';

import 'package:tdd_tutorial/core/errors/exceptions.dart';
import 'package:tdd_tutorial/core/utils/constants.dart';
import 'package:tdd_tutorial/src/authentication/data/models/user_model.dart';
import 'package:http/http.dart' as http;

abstract class AuthenticationRemoteDatasource {
  Future<void> createUser({
    required String createdAt,
    required String name,
    required String avatar,
  });
  Future<List<UserModel>> getUsers();
}

const kCreateUserEndpoint = '/users';
const kGetUsersEndpoint = '/user';

class AuthRemoteDataSrcImpl implements AuthenticationRemoteDatasource {
  final http.Client _client;

  AuthRemoteDataSrcImpl(this._client);

  @override
  Future<void> createUser({
    required String createdAt,
    required String name,
    required String avatar,
  }) async {
    final response = await _client.post(
      Uri.parse('$kBaseUrl$kCreateUserEndpoint'),
      body: jsonEncode({
        'createdAt': createdAt,
        'name': name,
        'avatar': avatar,
      }),
    );

    if (response.statusCode != 200 && response.statusCode != 201 ){
      throw APIException(message: response.body, statusCode: response.statusCode);
    }


  }

  @override
  Future<List<UserModel>> getUsers() async {
    // TODO: implement getUsers
    throw UnimplementedError();
  }
}
