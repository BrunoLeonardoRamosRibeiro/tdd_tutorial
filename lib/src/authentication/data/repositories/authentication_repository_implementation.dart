import 'package:dartz/dartz.dart';
import 'package:tdd_tutorial/core/errors/exceptions.dart';
import 'package:tdd_tutorial/core/errors/failure.dart';
import 'package:tdd_tutorial/core/utils/typedef.dart';
import 'package:tdd_tutorial/src/authentication/data/datasources/authentication_remote_datasource.dart';
import 'package:tdd_tutorial/src/authentication/domain/entities/user.dart';
import 'package:tdd_tutorial/src/authentication/domain/repositories/authentication_repository.dart';

class AuthenticationRepositoryImplementation implements AuthenticationRepository {
  final AuthenticationRemoteDatasource _datasource;

  AuthenticationRepositoryImplementation(this._datasource);

  @override
  ResultVoid createUser({
    required String createdAt,
    required String name,
    required String avatar,
  }) async {
    try {
      await _datasource.createUser(createdAt: createdAt, name: name, avatar: avatar);

      return const Right(null);
    } on APIException catch (e) {
      return Left(
        ApiFailure.fromException(e),
      );
    }
  }

  @override
  ResultFuture<List<User>> getUsers() async {
    try {
      final result = await _datasource.getUsers();
      return (Right(result));
    } on APIException catch (e) {
      return Left(
        ApiFailure.fromException(e),
      );
    }
  }
}
