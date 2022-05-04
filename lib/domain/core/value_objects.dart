import 'package:dartz/dartz.dart';
import 'package:ddd_flutter_app/domain/core/errors.dart';
import 'package:ddd_flutter_app/domain/core/failures.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class ValueObject<T> extends Equatable {
  const ValueObject();
  Either<ValueFailure<T>, T> get value;

  T getOrCrash() {
    return value.fold((f) => throw UnexpectedValueError(f), id);
  }

  bool isValid() => value.isRight();

  @override
  List<Object?> get props => [value];

  @override
  String toString() => 'Value($value)';
}
