import 'dart:async';
import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'service.dart';
import 'user_model.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final ApiService apiService;

  UserBloc(this.apiService) : super(UserInitial());

  @override
  Stream<UserState> mapEventToState(
    UserEvent event,
  ) async* {
    if (event is FetchUsers) {
      yield* _mapFetchUsersToState(event);
    } else if (event is FetchUserDetails) {
      yield* _mapFetchUserDetailsToState(event);
    }
  }

  Stream<UserState> _mapFetchUsersToState(FetchUsers event) async* {
    try {
      final response = await apiService.getUsers(event.page);
      if (response.statusCode == 200) {
        final userData = response.body;
        final users =
            parseUsers(userData); // Parse the response using the model
        yield UserLoaded(users);
      } else {
        yield UserError('Failed to load users');
      }
    } catch (e) {
      yield UserError('Failed to load users');
    }
  }

  Stream<UserState> _mapFetchUserDetailsToState(FetchUserDetails event) async* {
    final response = await apiService.getUserDetails(event.userId);
    if (response.statusCode == 200) {
      final userDetailsData = response.body;
      final userDetails = parseUserDetails(
          userDetailsData); // Parse the response using the model
      yield UserDetailsLoaded(userDetails);
    } else {
      yield UserDetailsError('Failed to load user details');
    }
  }

  List<User> parseUsers(String responseBody) {
    final parsed = jsonDecode(responseBody)['data'];
    return List<User>.from(parsed.map((userJson) => User.fromJson(userJson)));
  }

  UserDetails parseUserDetails(String responseBody) {
    final parsed = jsonDecode(responseBody);
    return UserDetails.fromJson(parsed);

    /*  return UserDetails(
      id: 0,
      name: '',
      email: '',
      avatar: '',
    );*/
  }
}
