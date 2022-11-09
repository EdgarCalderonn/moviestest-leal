import 'package:flutter/material.dart';
import 'package:moviestest/domain/models/serie.dart';
import 'package:moviestest/presentation/bloc/home/home_bloc.dart';
import 'package:moviestest/presentation/state/base_state.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends BaseState<HomePage, HomeBloc> {
  @override
  void initState() {
    super.initState();
    bloc!.getSeries();
  }

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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 30,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text('Popular'),
          ),
          const SizedBox(
            height: 20,
          ),
          StreamBuilder<List<Serie>>(
              stream: bloc!.popularSeriesStream,
              builder: (context, seriesSnapshot) {
                if (seriesSnapshot.hasData) {
                  final List<Serie> populars = seriesSnapshot.data!;
                  return SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        const SizedBox(
                          width: 20,
                        ),
                        ...populars.map<Widget>(
                          (Serie serie) {
    
                            return Container(
                              margin: EdgeInsets.only(
                                right:
                                    populars.indexOf(serie) != populars.length -1
                                        ? 20
                                        : 0,
                              ),
                              child: Image.network(
                                serie.getPosterImageUrl(
                                  type: SerieImageType.w200,
                                ),
                                height: 150,
                              ),
                            );
                          },
                        ).toList(),
                        const SizedBox(
                          width: 20,
                        ),
                      ],
                    ),
                  );
                }

                return const Center(child: CircularProgressIndicator());
              })
        ],
      ),

    );
  }
}
