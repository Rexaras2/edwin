part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class FetchUsers extends UserEvent {
  final int page;

  FetchUsers(this.page);

  @override
  List<Object> get props => [page];
}

class FetchUserDetails extends UserEvent {
  final int userId;

  FetchUserDetails(this.userId);

  @override
  List<Object> get props => [userId];
}
