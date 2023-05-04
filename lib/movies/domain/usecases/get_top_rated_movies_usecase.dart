import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:movies_app/core/base_usecase/base_usecase.dart';
import 'package:movies_app/movies/domain/repository/base_movies_repository.dart';

import '../../../core/error/failure.dart';
import '../entities/movie.dart';

class GetTopRatedMoviesUseCase extends BaseUseCase<List<Movie>,TopRatedMoviesPageParameter> {
  final BaseMoviesRepository baseMoviesRepository;

  GetTopRatedMoviesUseCase(this.baseMoviesRepository);

  @override
  Future<Either<Failure, List<Movie>>> call(TopRatedMoviesPageParameter parameters) async =>
      await baseMoviesRepository.getTopRatedMovies(parameters);
}

class TopRatedMoviesPageParameter extends Equatable {

  final int page;

  const TopRatedMoviesPageParameter({required this.page});

  @override
  List<Object> get props => [page];
}