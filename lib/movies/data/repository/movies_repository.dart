import 'package:dartz/dartz.dart';
import 'package:movies_app/core/error/failure.dart';
import 'package:movies_app/movies/data/datasource/movies_remote_datasource.dart';
import 'package:movies_app/movies/domain/entities/movie.dart';
import 'package:movies_app/movies/domain/entities/movie_details.dart';
import 'package:movies_app/movies/domain/entities/recommendation.dart';
import 'package:movies_app/movies/domain/repository/base_movies_repository.dart';
import 'package:movies_app/movies/domain/usecases/get_movie_details_usecase.dart';
import 'package:movies_app/movies/domain/usecases/get_movie_recommendation_usecase.dart';
import 'package:movies_app/movies/domain/usecases/get_popluar_movies_usecase.dart';
import 'package:movies_app/movies/domain/usecases/get_top_rated_movies_usecase.dart';

import '../../../core/error/exceptions.dart';

class MoviesRepository extends BaseMoviesRepository {
  final BaseMovieRemoteDataSource baseMovieRemoteDataSource;

  MoviesRepository(this.baseMovieRemoteDataSource);

  @override
  Future<Either<Failure, List<Movie>>> getNowPlayingMovies() async {
    final result = await baseMovieRemoteDataSource.getNowPlayingMovies();
    return sharedResult(result);
  }

  @override
  Future<Either<Failure, List<Movie>>> getPopularMovies(PopularMoviesPageParameter parameter) async {
    final result = await baseMovieRemoteDataSource.getPopularMovies(parameter);
    return sharedResult(result);
  }

  @override
  Future<Either<Failure, List<Movie>>> getTopRatedMovies(TopRatedMoviesPageParameter parameter) async {
    final result = await baseMovieRemoteDataSource.getTopRatedMovies(parameter);
    return sharedResult(result);
  }


  Either<Failure, List<Movie>> sharedResult(result) {
    try {
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, MovieDetails>> getMovieDetails(MovieDetailsParameter parameter) async {
   final result = await baseMovieRemoteDataSource.getMovieDetails(parameter);
   try {
     return Right(result);
   } on ServerException catch (failure) {
     return Left(ServerFailure(failure.errorMessageModel.statusMessage));
   }
  }

  @override
  Future<Either<Failure, List<Recommendation>>> getMovieRecommendation(MovieRecommendationParameter parameter) async {
    final result = await baseMovieRemoteDataSource.getMovieRecommendation(parameter);
    try {
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }
}
