import 'package:flutter/material.dart';
import 'package:moviestest/domain/models/episode.dart';
import 'package:moviestest/domain/models/serie.dart';
import 'package:moviestest/presentation/bloc/serie_detail/serie_detail_bloc.dart';
import 'package:moviestest/presentation/state/base_state.dart';

class SerieDetailPage extends StatefulWidget {
  const SerieDetailPage(this.serie, {super.key});

  final Serie serie;

  @override
  State<SerieDetailPage> createState() => _SerieDetailPageState();
}

class _SerieDetailPageState
    extends BaseState<SerieDetailPage, SerieDetailBloc> {
  @override
  void initState() {
    super.initState();

    bloc!.getEpisodes(widget.serie.id!, 1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.serie.name!),
      ),
      body: StreamBuilder<SerieEpisodesInfo>(
        stream: bloc!.episodesInfoStream,
        builder:
            (BuildContext context, AsyncSnapshot<SerieEpisodesInfo> snapshot) {
          if (snapshot.hasData) {
            final SerieEpisodesInfo info = snapshot.data!;

            final List<Episode> episodes = info.episodes!;
            final int currentEpisodeIndex = info.selectedEpisode!;

            final Episode currentEpisode = episodes[currentEpisodeIndex];

            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Episode ${currentEpisodeIndex + 1}'),
                        if (currentEpisodeIndex < episodes.length - 1)
                          GestureDetector(
                              onTap: () {
                                bloc!.goToNextEpisode();
                              },
                              child: Row(
                                children: const [
                                  Text('Next'),
                                  Icon(Icons.keyboard_arrow_right_rounded),
                                ],
                              ))
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child:
                              Image.network(widget.serie.getBackdropImageUrl(
                                type: SerieImageType.w400
                              ))),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    Text(
                      currentEpisode.name!,
                      textAlign: TextAlign.start,
                      style: const TextStyle(
                          fontSize: 26, fontWeight: FontWeight.w800),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Text(
                      'IMDb: ${currentEpisode.voteAverage?.toStringAsFixed(1)} | ${currentEpisode.airDate?.year} | ${widget.serie.numberOfSeasons ?? 1} Season',
                      style: const TextStyle(
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Text(widget.serie.overview!),
                  ],
                ),
              ),
            );
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
