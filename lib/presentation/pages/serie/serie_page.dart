import 'package:flutter/material.dart';
import 'package:moviestest/domain/models/serie.dart';

class SeriePage extends StatelessWidget {
  const SeriePage(this.serie, {super.key});

  final Serie serie;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Popular'),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 40,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 30,
            ),
            Hero(
              tag: serie.id!,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: SizedBox(
                  height: 400,
                  child: Image.network(
                    serie.getPosterImageUrl(
                      type: SerieImageType.original,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Text(
              serie.name!,
              style: const TextStyle(fontSize: 26, fontWeight: FontWeight.w800),
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
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
              height: 15,
            ),
            Text(
              'IMDb: ${serie.voteAverage}',
              style: const TextStyle(
                fontSize: 14,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            ElevatedButton(onPressed: () {}, child: const Text('Watch now')),
            const SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}
