import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:ddd_flutter_app/domain/auth/auth_failure.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/auth/i_auth_facade.dart';
import '../../../domain/auth/value_object.dart';

part 'sign_in_form_event.dart';
part 'sign_in_form_state.dart';
part 'sign_in_form_bloc.freezed.dart';

class SignInFormBloc extends Bloc<SignInFormEvent, SignInFormState> {
  final IAuthFacade _authFacade;

  SignInFormBloc(this._authFacade) : super(SignInFormState.initial()) {
    on<EmailChanged>(_onEmailChanged);
    on<PasswordChanged>(_onPasswordChanged);
    on<RegisterWithEmail>(
      (event, emit) => _performEmailAndPasswordLogic(
          event, emit, _authFacade.registerWithEmailAndPassword),
    );
    on<SignInWithEmail>(
      (event, emit) => _performEmailAndPasswordLogic(
          event, emit, _authFacade.signInWithEmailAndPassword),
    );
    on<SignInWithGmail>(_onSignInWithGmail);
  }

  FutureOr<void> _onEmailChanged(
      EmailChanged event, Emitter<SignInFormState> emit) {
    emit(state.copyWith(
      emailAddress: EmailAddress(event.email),
      authFailureOrSuccess: none(),
    ));
  }

  FutureOr<void> _onPasswordChanged(
      PasswordChanged event, Emitter<SignInFormState> emit) {
    emit(state.copyWith(
      password: Password(event.password),
      authFailureOrSuccess: none(),
    ));
  }

  FutureOr<void> _onSignInWithGmail(
      SignInWithGmail event, Emitter<SignInFormState> emit) async {
    emit(state.copyWith(
      isSubmitting: true,
      authFailureOrSuccess: none(),
    ));
    final Either<AuthFailure, Unit> signInResponse =
        await _authFacade.signInWithGoogle();
    emit(state.copyWith(
      isSubmitting: false,
      authFailureOrSuccess: some(signInResponse),
    ));
  }

  FutureOr<void> _performEmailAndPasswordLogic(
    SignInFormEvent event,
    Emitter<SignInFormState> emit,
    Future<Either<AuthFailure, Unit>> Function(
            {required EmailAddress emailAddress, required Password password})
        forwardedCall,
  ) async {
    late Either<AuthFailure, Unit> requestResponse;
    final bool isEmailValid = state.emailAddress.isValid();
    final bool isPasswordValid = state.password.isValid();

    if (isEmailValid && isPasswordValid) {
      emit(state.copyWith(
        isSubmitting: true,
        authFailureOrSuccess: none(),
      ));

      requestResponse = await forwardedCall(
        emailAddress: state.emailAddress,
        password: state.password,
      );
    }
    emit(state.copyWith(
      isSubmitting: false,
      showErrorMessage: true,
      authFailureOrSuccess: optionOf(requestResponse),
    ));
  }
}
