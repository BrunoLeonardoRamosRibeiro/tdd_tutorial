
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tdd_tutorial/src/authentication/domain/usecases/create_user.dart';
import 'package:tdd_tutorial/src/authentication/domain/usecases/get_users.dart';
import 'package:tdd_tutorial/src/authentication/presentation/bloc/authentication_state.dart';

import 'authentication_event.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc({
    required CreateUser createUser,
    required GetUsers getUsers,
  }) : _createUser = createUser,
        _getUsers = getUsers,
        super(const AuthenticationInitial()) {
    on<CreateUserEvent>(_createUserHandler);
    on<GetUsersEvent>(_getUsersHandler);
  }

  final CreateUser _createUser;
  final GetUsers _getUsers;

  Future<void> _createUserHandler(
      CreateUserEvent event,
      Emitter<AuthenticationState> emit,
      ) async {
    emit(const CreatingUser());

    final result = await _createUser(CreateUserParams(
      createdAt: event.createdAt,
      name: event.name,
      avatar: event.avatar,
    ));

    result.fold(
          (failure) => emit(AuthenticationError(failure.message)),
          (_) => emit(const UserCreated()),
    );
  }

  Future<void> _getUsersHandler(
      GetUsersEvent event,
      Emitter<AuthenticationState> emit,
      ) async {
    emit(const GettingUsers());
    final result = await _getUsers();

    result.fold((failure) => emit(AuthenticationError(failure.message)),
          (users) => emit(UsersLoaded(users)),);
  }
}
