/*
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'user_bloc.dart';

class UserDetailsScreen extends StatefulWidget {
  final int userId;

  UserDetailsScreen({required this.userId});

  @override
  _UserDetailsScreenState createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {
  final UserBloc _userBloc = UserBloc(ApiService());

  @override
  void initState() {
    super.initState();
    _userBloc.add(FetchUserDetails(widget.userId));
  }

  @override
  void dispose() {
    _userBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Details'),
      ),
      body: BlocBuilder<UserBloc, UserState>(
        bloc: _userBloc,
        builder: (context, state) {
          if (state is UserDetailsLoaded) {
            final userDetails = state.data;
            // Parse the userDetails and display the user details

            User user = parseUserDetails(userDetails);

            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    user.name,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  // Add more user details widgets here
                ],
              ),
            );
          } else if (state is UserDetailsError) {
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
*/

// user_details_screen.dart
import 'dart:async';

import 'package:edwin_task/user_bloc.dart';
import 'package:edwin_task/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'service.dart';

class UserDetailsScreen extends StatefulWidget {
  final int userId;

  UserDetailsScreen({super.key, required this.userId});

  @override
  _UserDetailsScreenState createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen>
    with SingleTickerProviderStateMixin {
  final UserBloc _userBloc = UserBloc(ApiService());
  double _containerWidth = 250.0;
  double _containerHeight = 350.0;
  Color _containerColor = Colors.blue;
  late AnimationController _controller;
  toggleContainer() {
    setState(() {
      // Toggle the width, height, and color of the container
      _containerWidth = _containerWidth == 250.0 ? 300.0 : 250.0;
      _containerHeight = _containerHeight == 300.0 ? 350.0 : 300.0;
      _containerColor =
          _containerColor == Colors.purple ? Colors.blueAccent : Colors.purple;
    });
  }

  @override
  void initState() {
    super.initState();
    _userBloc.add(FetchUserDetails(widget.userId));
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );
    _controller.forward(from: 0.0);
  }

  @override
  void dispose() {
    _userBloc.close();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 2), () {
      print("checking dots");
      toggleContainer();
    });
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('User Details'),
      ),
      body: BlocBuilder<UserBloc, UserState>(
        bloc: _userBloc,
        builder: (context, state) {
          if (state is UserDetailsLoaded) {
            final UserDetails userDetails = state.data;
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: RotationTransition(
                      turns: _controller,
                      child: Column(
                        children: [
                          Transform.rotate(
                            angle: 0.5, // Rotation angle in radians
                            child: Container(
                              width: 200,
                              height: 100,
                              color: Colors.greenAccent,
                              child: const Center(
                                child: Text(
                                  'User Details',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 20),
                                ),
                              ),
                            ),
                          ),
                          AnimatedContainer(
                            duration: const Duration(seconds: 1),
                            width: _containerWidth,
                            height: _containerHeight,
                            color: _containerColor,
                            // Add other properties like padding, margin, etc. as needed
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image(
                                    image:
                                        NetworkImage(userDetails.data!.avatar!),
                                    height: 60,
                                    width: 60,
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Row(
                                    children: [
                                      const Expanded(
                                        child: Text(
                                          "ID",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18),
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          userDetails.data!.id!.toString(),
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 20),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Row(
                                    children: [
                                      const Expanded(
                                        child: Text(
                                          "Email",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18),
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          userDetails.data!.email!,
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 20),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Row(
                                    children: [
                                      const Expanded(
                                        child: Text(
                                          "First Name",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18),
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          userDetails.data!.firstName!,
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 20),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Row(
                                    children: [
                                      const Expanded(
                                        child: Text(
                                          "Last Name",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18),
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          userDetails.data!.lastName!,
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 20),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else if (state is UserDetailsError) {
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _controller.forward(from: 0.0);
        },
        child: const Icon(Icons.play_arrow),
      ),
    );
  }
}
