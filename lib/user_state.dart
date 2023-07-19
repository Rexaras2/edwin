part of 'user_bloc.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

class UserInitial extends UserState {}

class UserLoaded extends UserState {
  final List<User> data;

  UserLoaded(this.data);

  @override
  List<Object> get props => [data];
}

class UserError extends UserState {
  final String message;

  UserError(this.message);

  @override
  List<Object> get props => [message];
}

class UserDetailsLoaded extends UserState {
  final UserDetails data;

  UserDetailsLoaded(this.data);

  @override
  List<Object> get props => [data];
}

class UserDetailsError extends UserState {
  final String message;

  UserDetailsError(this.message);

  @override
  List<Object> get props => [message];
}
