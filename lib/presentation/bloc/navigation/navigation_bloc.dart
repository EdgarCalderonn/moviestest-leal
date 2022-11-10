import 'package:injectable/injectable.dart';
import 'package:moviestest/presentation/bloc/provider/bloc.dart';
import 'package:rxdart/streams.dart';
import 'package:rxdart/subjects.dart';

@injectable
class NavigationBloc extends Bloc {
  final BehaviorSubject<int> _navIndexSubject = BehaviorSubject<int>.seeded(0);
  ValueStream<int> get navIndexStream => _navIndexSubject.stream;

  void changeTab(int newIndex) {
    _navIndexSubject.value = newIndex;
  }

  @override
  void dispose() {
    _navIndexSubject.close();
  }
}

enum NavTab {
  home,
  favorites,
  recent,
}
