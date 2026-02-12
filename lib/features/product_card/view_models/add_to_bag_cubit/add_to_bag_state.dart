part of 'add_to_bag_cubit.dart';

sealed class AddToBagState {}

final class AddToBagInitial extends AddToBagState {}

final class AddToBagSuccess extends AddToBagState {}

final class AddToBagError extends AddToBagState {
  final String message;
  AddToBagError(this.message);
}

final class AddToBagLoading extends AddToBagState {}
