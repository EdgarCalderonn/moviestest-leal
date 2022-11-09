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
    bloc!.getPopularSeries();
    bloc!.getRecommendedSeries();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                bloc!.logout();
              },
              icon: const Icon(Icons.settings))
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 30,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Popular',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                ),
              ),
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            width: 20,
                          ),
                          ...populars.map<Widget>(
                            (Serie serie) {
                              return Container(
                                margin: EdgeInsets.only(
                                  right: populars.indexOf(serie) !=
                                          populars.length - 1
                                      ? 30
                                      : 0,
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: SizedBox(
                                          child: Image.network(
                                            serie.getPosterImageUrl(
                                              type: SerieImageType.w200,
                                            ),
                                            height: 150,
                                            width: 100,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    SizedBox(
                                        width: 100,
                                        child: Text(
                                          serie.name!,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ))
                                  ],
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
                }),
            const SizedBox(
              height: 30,
            ),
            const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Divider()),
            const SizedBox(
              height: 20,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Recommendations',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            StreamBuilder<List<Serie>>(
                stream: bloc!.recommendedSeriesStream,
                builder: (context, recommendedSnapshot) {
                  if (recommendedSnapshot.hasData) {
                    final List<Serie> recommended = recommendedSnapshot.data!;

                    return Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ...recommended
                              .map<Widget>((serie) => Container(
                                    margin: const EdgeInsets.only(
                                      bottom: 30,
                                    ),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: 170,
                                          width: 130,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            child: Image.network(
                                              serie.getPosterImageUrl(
                                                type: SerieImageType.w300,
                                              ),
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                            child: Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 20,
                                          ),
                                          height: 170,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(serie.name!),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Row(
                                                children: const [
                                                  Icon(
                                                    Icons.star,
                                                    size: 15,
                                                  ),
                                                  Icon(
                                                    Icons.star,
                                                    size: 15,
                                                  ),
                                                  Icon(
                                                    Icons.star,
                                                    size: 15,
                                                  ),
                                                  Icon(
                                                    Icons.star,
                                                    size: 15,
                                                  ),
                                                  Icon(
                                                    Icons.star,
                                                    size: 15,
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Text(
                                                  'IMDb: ${serie.voteAverage}'),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  ElevatedButton(
                                                      onPressed: () {},
                                                      child: const Text(
                                                          'Watch now')),
                                                  IconButton(
                                                      onPressed: () {},
                                                      icon: const Icon(Icons
                                                          .favorite_border))
                                                ],
                                              )
                                            ],
                                          ),
                                        )),
                                      ],
                                    ),
                                  ))
                              .toList()
                        ],
                      ),
                    );
                  }

                  return const SizedBox.shrink();
                })
          ],
        ),
      ),
    );
  }
}
