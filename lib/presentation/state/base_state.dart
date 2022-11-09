import 'package:flutter/material.dart';
import 'package:moviestest/presentation/bloc/provider/bloc.dart';
import 'package:moviestest/presentation/bloc/provider/provider.dart';
import 'package:moviestest/presentation/dependency_injection/injection.dart';


abstract class BaseState<T extends StatefulWidget, K extends Bloc>
    extends State<T> {
  K? bloc;

  @override
  void initState() {
    super.initState();
    bloc = Provider.of<K>(() => getIt.get<K>());
  }

  @override
  void dispose() {
    Provider.dispose<K>();
    super.dispose();
  }
}
