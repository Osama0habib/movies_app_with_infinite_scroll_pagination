import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:movies_app/core/base_usecase/base_usecase.dart';
import 'package:movies_app/movies/domain/entities/recommendation.dart';
import 'package:movies_app/movies/domain/repository/base_movies_repository.dart';

import '../../../core/error/failure.dart';

class GetMovieRecommendationUseCase extends BaseUseCase<List<Recommendation> , MovieRecommendationParameter> {
  final BaseMoviesRepository baseMoviesRepository;

  GetMovieRecommendationUseCase(this.baseMoviesRepository);

  @override
  Future<Either<Failure, List<Recommendation>>> call(MovieRecommendationParameter parameters) async =>
      await baseMoviesRepository.getMovieRecommendation(parameters);
}

class MovieRecommendationParameter extends Equatable {

  final int id;

  const MovieRecommendationParameter({required this.id});

  @override
  List<Object> get props => [id];
}