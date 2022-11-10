import 'package:flutter/material.dart';
import 'package:moviestest/domain/models/serie.dart';
import 'package:moviestest/presentation/bloc/favorites/favorites_bloc.dart';
import 'package:moviestest/presentation/bloc/provider/provider.dart';
import 'package:moviestest/presentation/dependency_injection/injection.dart';
import 'package:moviestest/presentation/pages/serie/serie_page.dart';
import 'package:moviestest/presentation/pages/serie_detail/serie_detail_page.dart';

class SerieCard extends StatelessWidget {
  SerieCard(this.serie, {super.key});

  final Serie serie;

  final FavoritesBloc favoritesBloc =
      Provider.of<FavoritesBloc>(() => getIt.get<FavoritesBloc>())!;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => SeriePage(serie)));
      },
      child: Container(
        margin: const EdgeInsets.only(
          bottom: 30,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: serie.id!,
              child: SizedBox(
                height: 170,
                width: 130,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    serie.getPosterImageUrl(
                      type: SerieImageType.w300,
                    ),
                    fit: BoxFit.fill,
                  ),
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
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
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
                  Text('IMDb: ${serie.voteAverage}'),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        SerieDetailPage(serie)));
                          },
                          child: const Text('Watch now')),
                      IconButton(
                          onPressed: () {
                            favoritesBloc.addFavorite(serie);
                          },
                          icon: Icon(favoritesBloc.canAdd(serie.id!)
                              ? Icons.favorite_border
                              : Icons.favorite))
                    ],
                  )
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }
}
