import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:movies_app/core/network/api_constance.dart';
import 'package:movies_app/core/utils/enums.dart';
import 'package:movies_app/movies/presentation/controller/movies_bloc.dart';

import '../../../core/services/service_locator.dart';
import '../../domain/entities/movie.dart';

class MoreMoviesScreen extends StatelessWidget {
  const MoreMoviesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent,elevation: 0,foregroundColor: Colors.black),
      body: BlocProvider(
        create: (context) =>
            sl<MoviesBloc>()..add(const GetPopularMoviesEvent(page: 1)),
        child: BlocBuilder<MoviesBloc, MoviesState>(
          builder: (context, state) {
            switch (state.popularMoviesRequestState) {
              case RequestState.loading:
                return const Center(
                  child: CircularProgressIndicator(),
                );
              case RequestState.loaded:
                context.read<MoviesBloc>().pagingController.itemList =
                    state.popularMovies;
                return PagedListView<int, Movie>(
                  physics: const BouncingScrollPhysics(),
                  pagingController: context.read<MoviesBloc>().pagingController,
                  builderDelegate: PagedChildBuilderDelegate<Movie>(
                      itemBuilder: (context, item, index) =>
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Card(
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: SizedBox(
                                      height: 150,
                                      width: 100,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: CachedNetworkImage(
                                          imageUrl: ApiConstance.imageUrl(
                                              item.backdropPath),
                                          fit: BoxFit.fitHeight,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          item.title,
                                          overflow: TextOverflow.ellipsis,
                                          style: Theme.of(context)
                                              .textTheme
                                              .headlineSmall,
                                        ),
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Chip(
                                                label: Text(item.releaseDate
                                                    .split("-")
                                                    .first)),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            const Icon(Icons.star),
                                            Text(
                                              item.voteAverage.toString(),
                                              overflow: TextOverflow.ellipsis,

                                            )
                                          ],
                                        ),
                                        Text(item.overview,overflow: TextOverflow.ellipsis,maxLines: 2,
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),),
                  ),
                );
              //   Column(
              //   children: [
              //     Expanded(
              //       child: ListView.builder(
              //         controller: context.read<MoviesBloc>().scrollController,
              //         itemCount: state.popularMovies.length,
              //         itemBuilder: (BuildContext context, int index) {
              //           return
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: Card(
            //     child: Row(
            //       children: [
            //         Padding(
            //           padding: const EdgeInsets.all(8.0),
            //           child: SizedBox(
            //             height: 150,
            //             width: 100,
            //             child: ClipRRect(
            //               borderRadius: BorderRadius.circular(10),
            //               child: CachedNetworkImage(
            //                 imageUrl: ApiConstance.imageUrl(
            //                     item.backdropPath),
            //                 fit: BoxFit.fitHeight,
            //               ),
            //             ),
            //           ),
            //         ),
            //         Expanded(
            //           child: Column(
            //             crossAxisAlignment:
            //                 CrossAxisAlignment.start,
            //             children: [
            //               Text(
            //                 item.title,
            //                 overflow: TextOverflow.ellipsis,
            //                 style: Theme.of(context)
            //                     .textTheme
            //                     .headlineSmall,
            //               ),
            //               Row(
            //                 mainAxisSize: MainAxisSize.max,
            //                 children: [
            //                   Chip(
            //                       label: Text(item.releaseDate
            //                           .split("-")
            //                           .first)),
            //                   const SizedBox(
            //                     width: 5,
            //                   ),
            //                   const Icon(Icons.star),
            //                   Text(
            //                     item.voteAverage.toString(),
            //                     overflow: TextOverflow.ellipsis,
            //
            //                   )
            //                 ],
            //               ),
            //               Text(item.overview,overflow: TextOverflow.ellipsis,maxLines: 2,
            //               )
            //             ],
            //           ),
            //         )
            //       ],
            //     ),
            //   ),),
              //         },
              //       ),
              //     ),
              //     if(state.loadMoreRequestState == RequestState.loading)
              //     const SizedBox(
              //       height: 100,
              //       child: Center(child: CircularProgressIndicator()),
              //     ),
              //     if(state.loadMoreRequestState == RequestState.error)
              //        SizedBox(
              //         height: 100,
              //         child: Center(child: Text(state.popularMoviesMessage),),
              //       ),
              //   ],
              // );
              case RequestState.error:
                return Center(
                  child: Text(state.popularMoviesMessage),
                );
            }
          },
        ),
      ),
    );
  }
}
