part of 'storage_cubit.dart';

@immutable
abstract class StorageState {}

class StorageLoading extends StorageState {}

class StorageError extends StorageState {}

class StorageValue extends StorageState {
  final int counterValue;
  final String date;

  StorageValue({required this.counterValue, required this.date});
}
