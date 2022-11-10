import 'package:flutter/material.dart';
import 'package:moviestest/domain/models/serie.dart';
import 'package:moviestest/presentation/bloc/favorites/favorites_bloc.dart';
import 'package:moviestest/presentation/bloc/provider/provider.dart';
import 'package:moviestest/presentation/dependency_injection/injection.dart';
import 'package:moviestest/presentation/widgets/serie_card.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  final FavoritesBloc bloc =
      Provider.of<FavoritesBloc>(() => getIt.get<FavoritesBloc>())!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
        centerTitle: true,
      ),
      body: StreamBuilder<List<Serie>>(
          stream: bloc.favoriteSeriesStream,
          builder: (BuildContext context,
              AsyncSnapshot<List<Serie>> favoritesStreamSnapshot) {
            if (favoritesStreamSnapshot.hasData) {
              final List<Serie> favorites = favoritesStreamSnapshot.data!;

              if (favorites.isEmpty) {
                return const Center(
                  child: Text('You have no favorites'),
                );
              }

              return Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 30,
                      ),
                      ...favorites
                          .map<Widget>((serie) => Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SerieCard(serie),
                                  const Divider(
                                    thickness: 2,
                                    height: 0,
                                  ),
                                  const SizedBox(
                                    height: 30,
                                  ),
                                ],
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
