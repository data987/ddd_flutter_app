import 'package:dartz/dartz.dart';
import 'package:ddd_flutter_app/domain/auth/auth_failure.dart';
import 'package:ddd_flutter_app/domain/auth/user.dart';
import 'package:ddd_flutter_app/domain/auth/value_object.dart';

abstract class IAuthFacade {
  Option<User> getSignedInUser();
  Future<Either<AuthFailure, Unit>> registerWithEmailAndPassword({
    required EmailAddress emailAddress,
    required Password password,
  });
  Future<Either<AuthFailure, Unit>> signInWithEmailAndPassword({
    required EmailAddress emailAddress,
    required Password password,
  });
  Future<Either<AuthFailure, Unit>> signInWithGoogle();
  Future<void> signOut();
}
