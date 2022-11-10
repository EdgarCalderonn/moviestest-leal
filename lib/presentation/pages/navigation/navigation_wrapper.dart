import 'package:flutter/material.dart';
import 'package:moviestest/presentation/bloc/navigation/navigation_bloc.dart';
import 'package:moviestest/presentation/pages/home/home_page.dart';
import 'package:moviestest/presentation/pages/recent/recent_page.dart';
import 'package:moviestest/presentation/state/base_state.dart';

class NavigationWrapper extends StatefulWidget {
  const NavigationWrapper({super.key});

  @override
  State<NavigationWrapper> createState() => _NavigationWrapperState();
}

class _NavigationWrapperState
    extends BaseState<NavigationWrapper, NavigationBloc> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<int>(
        stream: bloc!.navIndexStream,
        builder: (BuildContext context, AsyncSnapshot<int> navTabSnapshot) {
          if (navTabSnapshot.hasData) {
            return Scaffold(
              body: Builder(builder: (context) {
                switch (navTabSnapshot.data!) {
                  case 0:
                    return const HomePage();

                  case 1:
                  return const Scaffold();

                  case 2:
                  return const RecentPage();
                  
                }

                return const HomePage();
              }),
              bottomNavigationBar: BottomNavigationBar(
                currentIndex: navTabSnapshot.data!,
                onTap: (index) {
                  bloc!.changeTab(index);
                },
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.favorite_border),
                    label: 'Favorite',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.replay_sharp),
                    label: 'Recent',
                  ),
                ],
              ),
            );
          }

          return const SizedBox.shrink();
        });
  }
}
