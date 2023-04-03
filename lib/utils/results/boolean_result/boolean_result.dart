import 'package:freezed_annotation/freezed_annotation.dart';
part 'boolean_result.freezed.dart';

@freezed
abstract class BooleanResult<T> with _$BooleanResult<T> {
  const factory BooleanResult.success({required T data}) = Success<T>;
  const factory BooleanResult.failure({required String error}) = Failure<T>;
}
