// user_list_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'service.dart';
import 'user_bloc.dart';
import 'user_detail_sceen.dart';
import 'user_model.dart';

class UserListScreen extends StatefulWidget {
  @override
  _UserListScreenState createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  final UserBloc _userBloc = UserBloc(ApiService());
  final ScrollController _scrollController = ScrollController();
  int _currentPage = 1;

  @override
  void initState() {
    super.initState();
    _userBloc.add(FetchUsers(_currentPage));

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _currentPage++;
        _userBloc.add(FetchUsers(_currentPage));
      }
    });
  }

  @override
  void dispose() {
    _userBloc.close();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('User List'),
      ),
      body: BlocBuilder<UserBloc, UserState>(
        bloc: _userBloc,
        builder: (context, state) {
          if (state is UserLoaded) {
            final List<User> users = state.data;
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.separated(
                controller: _scrollController,
                itemCount: users.length,
                itemBuilder: (context, index) {
                  return Container(
                    color: const Color(0xFF706CFF),
                    child: ListTile(
                      title: Text(
                        users[index].name,
                        style: const TextStyle(color: Colors.white),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                UserDetailsScreen(userId: users[index].id),
                          ),
                        );
                      },
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const SizedBox(
                    height: 15,
                  );
                },
              ),
            );
          } else if (state is UserError) {
            return Center(
              child: Text(state.message),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
