import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movies_app/core/network/api_constance.dart';
import 'package:movies_app/movies/domain/entities/genres.dart';
import 'package:movies_app/movies/domain/entities/recommendation.dart';
import 'package:movies_app/movies/presentation/controller/movie_details_bloc.dart';
import 'package:movies_app/movies/presentation/controller/video_player_bloc.dart';
import 'package:movies_app/movies/presentation/screens/watch_screen.dart';
import 'package:shimmer/shimmer.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../core/services/service_locator.dart';
import '../../../core/utils/dummy.dart';
import '../../../core/utils/enums.dart';
import '../../domain/entities/movie_details.dart';
import '../componants/youtube_player.dart';

class MovieDetailScreen extends StatelessWidget {
  final int id;

  const MovieDetailScreen({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<MovieDetailsBloc>()
        ..add(GetMovieDetailsEvent(id))
        ..add(GetMovieRecommendationEvent(id)),
      child: const Scaffold(
        body: MovieDetailContent(),
      ),
    );
  }
}

class MovieDetailContent extends StatelessWidget {
  const MovieDetailContent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieDetailsBloc, MovieDetailsState>(
      builder: (context, state) {
        switch (state.movieDetailsState) {
          case RequestState.loading:
            return const Center(
              child: CircularProgressIndicator(),
            );
          case RequestState.loaded:
            return CustomScrollView(
                    key: const Key('movieDetailScrollView'),
                    slivers: [
                      SliverAppBar(
                        pinned: true,
                        expandedHeight: 250.0,
                        flexibleSpace: FlexibleSpaceBar(
                          background: FadeIn(
                            duration: const Duration(milliseconds: 500),
                            child: ShaderMask(
                              shaderCallback: (rect) {
                                return const LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Colors.transparent,
                                    Colors.black,
                                    Colors.black,
                                    Colors.transparent,
                                  ],
                                  stops: [0.0, 0.5, 1.0, 1.0],
                                ).createShader(
                                  Rect.fromLTRB(
                                      0.0, 0.0, rect.width, rect.height),
                                );
                              },
                              blendMode: BlendMode.dstIn,
                              child: CachedNetworkImage(
                                width: MediaQuery.of(context).size.width,
                                imageUrl: ApiConstance.imageUrl(
                                    state.movieDetails!.backdropPath),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: FadeInUp(
                          from: 20,
                          duration: const Duration(milliseconds: 500),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(state.movieDetails!.title,
                                    style: GoogleFonts.poppins(
                                      fontSize: 23,
                                      fontWeight: FontWeight.w700,
                                      letterSpacing: 1.2,
                                    )),
                                const SizedBox(height: 8.0),
                                Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 2.0,
                                        horizontal: 8.0,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.grey[800],
                                        borderRadius:
                                            BorderRadius.circular(4.0),
                                      ),
                                      child: Text(
                                        state.movieDetails!.releaseDate
                                            .split('-')[0],
                                        style: const TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 16.0),
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.star,
                                          color: Colors.amber,
                                          size: 20.0,
                                        ),
                                        const SizedBox(width: 4.0),
                                        Text(
                                          (state.movieDetails!.voteAverage /
                                                  2)
                                              .toStringAsFixed(1),
                                          style: const TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.w500,
                                            letterSpacing: 1.2,
                                          ),
                                        ),
                                        const SizedBox(width: 4.0),
                                        Text(
                                          '(${state.movieDetails!.voteAverage})',
                                          style: const TextStyle(
                                            fontSize: 1.0,
                                            fontWeight: FontWeight.w500,
                                            letterSpacing: 1.2,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(width: 16.0),
                                    Text(
                                      _showDuration(
                                          state.movieDetails!.runtime),
                                      style: const TextStyle(
                                        color: Colors.white70,
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w500,
                                        letterSpacing: 1.2,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 20.0),
                                Text(
                                  state.movieDetails!.overview,
                                  style: const TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w400,
                                    letterSpacing: 1.2,
                                  ),
                                ),
                                const SizedBox(height: 8.0),
                                Text(
                                  'Genres: ${_showGenres(state.movieDetails!.genres)}',
                                  style: const TextStyle(
                                    color: Colors.white70,
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: 1.2,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SliverPadding(
                          padding: const EdgeInsets.fromLTRB(
                              16.0, 0.0, 16.0, 24.0),
                          sliver: SliverToBoxAdapter(
                            child: FadeInUp(
                                from: 20,
                                duration: const Duration(milliseconds: 500),
                                child: FilledButton(onPressed: () { Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => WatchScreen(videoId: state.movieDetails!.videoId,recommendations: state.movieRecommendation,) )); },
                                  child: Text("Watch trailler"),)
                            ),
                          )),
                      SliverPadding(
                        padding:
                            const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 24.0),
                        sliver: SliverToBoxAdapter(
                          child: FadeInUp(
                            from: 20,
                            duration: const Duration(milliseconds: 500),
                            child: Text(
                              'More like this'.toUpperCase(),
                              style: const TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.w500,
                                letterSpacing: 1.2,
                              ),
                            ),
                          ),
                        ),
                      ),
                       SliverPadding(
                        padding:
                            const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 24.0),
                        sliver: ShowRecommendation(recommendations: state.movieRecommendation!),
                      ),

                    ],
                  );


          case RequestState.error:
            return Center(
              child: Text(state.movieDetailsMessage),
            );
        }
      },
    );
  }

  String _showGenres(List<Genres> genres) {
    String result = '';
    for (var genre in genres) {
      result += '${genre.name}, ';
    }

    if (result.isEmpty) {
      return result;
    }

    return result.substring(0, result.length - 2);
  }

  String _showDuration(int runtime) {
    final int hours = runtime ~/ 60;
    final int minutes = runtime % 60;

    if (hours > 0) {
      return '${hours}h ${minutes}m';
    } else {
      return '${minutes}m';
    }
  }

  // Widget showRecommendations() {
  //   return BlocBuilder<MovieDetailsBloc, MovieDetailsState>(
  //     builder: (context, state) {
  //       return SliverGrid(
  //         delegate: SliverChildBuilderDelegate(
  //           (context, index) {
  //             final recommendation = state.movieRecommendation[index];
  //             return FadeInUp(
  //               from: 20,
  //               duration: const Duration(milliseconds: 500),
  //               child: ClipRRect(
  //                 borderRadius: const BorderRadius.all(Radius.circular(4.0)),
  //                 child: CachedNetworkImage(
  //                   imageUrl:
  //                       ApiConstance.imageUrl(recommendation.backdropPath!),
  //                   placeholder: (context, url) => Shimmer.fromColors(
  //                     baseColor: Colors.grey[850]!,
  //                     highlightColor: Colors.grey[800]!,
  //                     child: Container(
  //                       height: 170.0,
  //                       width: 120.0,
  //                       decoration: BoxDecoration(
  //                         color: Colors.black,
  //                         borderRadius: BorderRadius.circular(8.0),
  //                       ),
  //                     ),
  //                   ),
  //                   errorWidget: (context, url, error) =>
  //                       const Icon(Icons.error),
  //                   height: 180.0,
  //                   fit: BoxFit.cover,
  //                 ),
  //               ),
  //             );
  //           },
  //           childCount: state.movieRecommendation.length,
  //         ),
  //         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
  //           mainAxisSpacing: 8.0,
  //           crossAxisSpacing: 8.0,
  //           childAspectRatio: 0.7,
  //           crossAxisCount: 3,
  //         ),
  //       );
  //     },
  //   );
  // }
}

// Widget youtubeHierarchy() {
//   return BlocBuilder<VideoPlayerBloc, VideoPlayerState>(
//     builder: (context, state) {
//       switch (state.videoInitilaizeState) {
//         case RequestState.loading:
//           return const Center(
//             child: Text("error Loading Video"),
//           );
//         case RequestState.loaded:
//           return YoutubePlayerBuilder(
//               onExitFullScreen: () {
//                 SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
//
//               },
//               player: YoutubePlayer(
//                 controller: state.youtubePlayerController!,
//                 showVideoProgressIndicator: true,
//                 progressIndicatorColor: Colors.blueAccent,
//                 topActions: <Widget>[
//                   const SizedBox(width: 8.0),
//                   Expanded(
//                     child: Text(
//                       state.youtubePlayerController!.metadata.title,
//                       style: const TextStyle(
//                         color: Colors.white,
//                         fontSize: 18.0,
//                       ),
//                       overflow: TextOverflow.ellipsis,
//                       maxLines: 1,
//                     ),
//                   ),
//                 ],
//                 // onReady: () {
//                 //   state.youtubePlayerController
//                 //       !.addListener(listener);
//                 // },
//                 onEnded: (data) {},
//               ),
//               onEnterFullScreen: () {
//                 context.read<VideoPlayerBloc>().add(EnterFullScreen());
//               },
//               builder: (context, player) => Column(
//                 children: [
//                   player,
//                 ],
//               ));
//         case RequestState.error:
//           return const Center(
//             child: Text("error Loading Video"),
//           );
//       }
//     },
//   );
// }

class ShowRecommendation extends StatelessWidget {
  const ShowRecommendation({Key? key,required this.recommendations}) : super(key: key);
final List<Recommendation> recommendations;
  @override
  Widget build(BuildContext context) {
return SliverGrid(
          delegate: SliverChildBuilderDelegate(
                (context, index) {
              final recommendation = recommendations[index];
              return FadeInUp(
                from: 20,
                duration: const Duration(milliseconds: 500),
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(4.0)),
                  child: CachedNetworkImage(
                    imageUrl:
                    ApiConstance.imageUrl(recommendation.backdropPath!),
                    placeholder: (context, url) => Shimmer.fromColors(
                      baseColor: Colors.grey[850]!,
                      highlightColor: Colors.grey[800]!,
                      child: Container(
                        height: 170.0,
                        width: 120.0,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ),
                    errorWidget: (context, url, error) =>
                    const Icon(Icons.error),
                    height: 180.0,
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
            childCount: recommendations.length,
          ),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            mainAxisSpacing: 8.0,
            crossAxisSpacing: 8.0,
            childAspectRatio: 0.7,
            crossAxisCount: 3,
          ),
        );


  }
}
