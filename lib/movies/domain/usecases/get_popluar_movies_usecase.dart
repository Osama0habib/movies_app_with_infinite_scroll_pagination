import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:movies_app/core/base_usecase/base_usecase.dart';
import 'package:movies_app/movies/domain/repository/base_movies_repository.dart';

import '../../../core/error/failure.dart';
import '../entities/movie.dart';

class GetPopularMoviesUseCase extends BaseUseCase<List<Movie>,PopularMoviesPageParameter> {

  final BaseMoviesRepository baseMoviesRepository;

  GetPopularMoviesUseCase(this.baseMoviesRepository);

  @override
  Future<Either<Failure,List<Movie>>> call(PopularMoviesPageParameter parameters) async {
    return await baseMoviesRepository.getPopularMovies(parameters);
  }
}

class PopularMoviesPageParameter extends Equatable {

  final int page;

  const PopularMoviesPageParameter({required this.page});

  @override
  List<Object> get props => [page];
}