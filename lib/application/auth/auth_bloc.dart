import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:ddd_flutter_app/domain/auth/i_auth_facade.dart';
import 'package:ddd_flutter_app/domain/auth/user.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'auth_event.dart';
part 'auth_state.dart';
part 'auth_bloc.freezed.dart';

@injectable
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final IAuthFacade _authFacade;

  AuthBloc(this._authFacade) : super(const AuthState.initial()) {
    on<AuthCheckRequested>(_authCheckRequested);
    on<SignOut>(_sighOut);
  }

  FutureOr<void> _authCheckRequested(
      AuthCheckRequested event, Emitter<AuthState> emit) {
    final Option<User> userOption = _authFacade.getSignedInUser();
    emit(
      userOption.fold(
        () => const AuthState.unauthenticated(),
        (_) => const AuthState.authenticated(),
      ),
    );
  }

  FutureOr<void> _sighOut(SignOut event, Emitter<AuthState> emit) {
    _authFacade.signOut();
    emit(const AuthState.unauthenticated());
  }
}
