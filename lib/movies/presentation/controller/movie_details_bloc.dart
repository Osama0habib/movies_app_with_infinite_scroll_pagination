import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/core/utils/enums.dart';
import 'package:movies_app/movies/domain/entities/movie_details.dart';
import 'package:movies_app/movies/domain/usecases/get_movie_details_usecase.dart';

import '../../domain/entities/recommendation.dart';
import '../../domain/usecases/get_movie_recommendation_usecase.dart';

part 'movie_details_event.dart';
part 'movie_details_state.dart';

class MovieDetailsBloc extends  Bloc<MovieDetailsEvent, MovieDetailsState> {
  final GetMovieDetailsUseCase getMovieDetailsUseCase;
  final GetMovieRecommendationUseCase getMovieRecommendationUseCase;

  MovieDetailsBloc(this.getMovieDetailsUseCase, this.getMovieRecommendationUseCase) : super(const MovieDetailsState( )) {
    on<GetMovieDetailsEvent>(_getMovieDetails);

    on<GetMovieRecommendationEvent>(_getMovieRecommendation);
  }

  FutureOr<void> _getMovieDetails(GetMovieDetailsEvent event, Emitter<MovieDetailsState> emit)async {
    final result = await getMovieDetailsUseCase(  MovieDetailsParameter(movieId: event.movieId));
    print(result);
    result.fold((l) =>
        emit(state.copyWith(movieDetailsState: RequestState.error,
            movieDetailsMessage: l.message)), (r) =>
        emit(state.copyWith(movieDetailsState: RequestState.loaded,
            movieDetails: r)));
  }

  FutureOr<void> _getMovieRecommendation(GetMovieRecommendationEvent event, Emitter<MovieDetailsState> emit)async {
    final result = await getMovieRecommendationUseCase(  MovieRecommendationParameter(id: event.id));
    print(result);
    result.fold((l) =>
        emit(state.copyWith(movieRecommendationState: RequestState.error,
            movieRecommendationMessage: l.message)), (r) =>
        emit(state.copyWith(movieRecommendationState: RequestState.loaded,
            movieRecommendation: r)));
  }
}
