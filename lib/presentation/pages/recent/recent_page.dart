import 'package:flutter/material.dart';
import 'package:moviestest/domain/models/serie.dart';
import 'package:moviestest/presentation/bloc/recent/recent_bloc.dart';
import 'package:moviestest/presentation/state/base_state.dart';

class RecentPage extends StatefulWidget {
  const RecentPage({super.key});

  @override
  State<RecentPage> createState() => _RecentPageState();
}

class _RecentPageState extends BaseState<RecentPage, RecentBloc> {
  @override
  void initState() {
    super.initState();
    bloc!.loadRecent();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recent'),
        centerTitle: true,
      ),
      body: StreamBuilder<List<Serie>>(
          stream: bloc!.recentSeriesStream,
          builder: (BuildContext context,
              AsyncSnapshot<List<Serie>> recentSeriesSnapshot) {
            if (recentSeriesSnapshot.hasData) {
              final List<Serie> recentSeries = recentSeriesSnapshot.data!;

              return SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 30,
                      ),
                      ...recentSeries
                          .map<Widget>((serie) => Container(
                                alignment: Alignment.center,
                                margin: const EdgeInsets.only(
                                  bottom: 30,
                                ),
                                child: Column(
                                  children: [
                                    ClipRRect(
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 20,
                                        ),
                                        width: double.infinity,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: Image.network(
                                            serie.getPosterImageUrl(
                                              type: SerieImageType.w400,
                                            ),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      serie.name!,
                                      style: const TextStyle(
                                          fontSize: 26,
                                          fontWeight: FontWeight.w800),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    const Text('3 episodes of 20'),

                                    
                                    const Divider()
                                  ],
                                ),
                              ))
                          .toList(),
                    ],
                  ),
                ),
              );
            }

            return const Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }
}
