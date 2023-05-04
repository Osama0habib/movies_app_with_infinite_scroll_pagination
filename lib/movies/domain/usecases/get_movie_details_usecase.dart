import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:movies_app/movies/domain/entities/movie_details.dart';

import '../../../core/base_usecase/base_usecase.dart';
import '../../../core/error/failure.dart';
import '../repository/base_movies_repository.dart';

class GetMovieDetailsUseCase extends BaseUseCase
<
MovieDetails , MovieDetailsParameter> {
final BaseMoviesRepository baseMoviesRepository;

GetMovieDetailsUseCase(this.baseMoviesRepository);

@override
Future<Either<Failure, MovieDetails>> call(MovieDetailsParameter parameters) async =>
await baseMoviesRepository.getMovieDetails(parameters);
}


class MovieDetailsParameter extends Equatable {

  final int movieId;

  const MovieDetailsParameter({required this.movieId});

  @override
  List<Object> get props => [movieId];
}