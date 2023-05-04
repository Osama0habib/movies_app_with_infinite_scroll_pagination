
import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movies_app/movies/presentation/componants/popular_movies_component.dart';
import 'package:movies_app/movies/presentation/controller/movies_bloc.dart';
import 'package:movies_app/movies/presentation/screens/more_movies_screen.dart';
import 'package:shimmer/shimmer.dart';

import '../../../core/network/api_constance.dart';
import '../../../core/services/service_locator.dart';
import '../../../core/utils/dummy.dart';
import '../componants/now_playing_movies_component.dart';
import '../componants/top_rated_movies_component.dart';


class MainMoviesScreen extends StatelessWidget {
  const MainMoviesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
  create: (context) => sl<MoviesBloc>()..add(GetNowPlayingMoviesEvent())..add(const GetPopularMoviesEvent(page: 1))..add(const GetTopRatedMoviesEvent(page: 1)),
  child: SingleChildScrollView(
      key: const Key('movieScrollView'),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const NowPlayingMoviesComponent(),
          Container(
            margin: const EdgeInsets.fromLTRB(16.0, 24.0, 16.0, 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Popular",
                  style: GoogleFonts.poppins(
                    fontSize: 19,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.15,
                  ),
                ),
                InkWell(
                  onTap: () {
                    /// TODO : NAVIGATION TO POPULAR SCREEN
                    Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => const MoreMoviesScreen() ));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: const [
                        Text('See More'),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 16.0,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const PopularMoviesComponent(),
          Container(
            margin: const EdgeInsets.fromLTRB(
              16.0,
              24.0,
              16.0,
              8.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Top Rated",
                  style: GoogleFonts.poppins(
                    fontSize: 19,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.15,
                  ),
                ),
                InkWell(
                  onTap: () {
                    /// TODO : NAVIGATION TO Top Rated Movies Screen
                    Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => const MoreMoviesScreen() ));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: const [
                        Text('See More'),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 16.0,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const TopRatedMoviesComponent(),
          const SizedBox(height: 50.0),
        ],
      ),
    ),
);
  }
}
