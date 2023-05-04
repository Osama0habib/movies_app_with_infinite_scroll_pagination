import 'package:dartz/dartz.dart';
import 'package:movies_app/movies/domain/entities/movie_details.dart';
import 'package:movies_app/movies/domain/entities/recommendation.dart';
import 'package:movies_app/movies/domain/usecases/get_movie_details_usecase.dart';
import 'package:movies_app/movies/domain/usecases/get_popluar_movies_usecase.dart';
import 'package:movies_app/movies/domain/usecases/get_top_rated_movies_usecase.dart';

import '../../../core/error/failure.dart';
import '../entities/movie.dart';
import '../usecases/get_movie_recommendation_usecase.dart';

abstract class BaseMoviesRepository{

  Future<Either<Failure,List<Movie>>> getNowPlayingMovies();
  Future<Either<Failure,List<Movie>>> getPopularMovies(PopularMoviesPageParameter parameter);
  Future<Either<Failure,List<Movie>>> getTopRatedMovies(TopRatedMoviesPageParameter parameter);
  Future<Either<Failure,MovieDetails>> getMovieDetails(MovieDetailsParameter parameter);
  Future<Either<Failure,List<Recommendation>>> getMovieRecommendation(MovieRecommendationParameter parameter);



} 