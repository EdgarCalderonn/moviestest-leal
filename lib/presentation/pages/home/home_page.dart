import 'package:flutter/material.dart';
import 'package:moviestest/presentation/bloc/home/home_bloc.dart';
import 'package:moviestest/presentation/state/base_state.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends BaseState<HomePage, HomeBloc> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home page'),
        actions: [
          IconButton(
              onPressed: () {
                bloc!.logout();
              },
              icon: const Icon(Icons.logout))
        ],
      ),
    );
  }
}
