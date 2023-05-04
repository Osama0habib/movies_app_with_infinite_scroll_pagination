part of 'movie_details_bloc.dart';

class MovieDetailsState extends Equatable {
  final MovieDetails? movieDetails;
  final RequestState movieDetailsState;
  final String movieDetailsMessage;

  final List<Recommendation> movieRecommendation;
  final RequestState movieRecommendationState;
  final String movieRecommendationMessage;

  const MovieDetailsState({
    this.movieDetails,
    this.movieDetailsState = RequestState.loading,
    this.movieDetailsMessage = "",
    this.movieRecommendation = const [],
    this.movieRecommendationState = RequestState.loading,
    this.movieRecommendationMessage = "",
  });

  MovieDetailsState copyWith({
    MovieDetails? movieDetails,
    RequestState? movieDetailsState,
    String? movieDetailsMessage,
    List<Recommendation>? movieRecommendation,
    RequestState? movieRecommendationState,
    String? movieRecommendationMessage,
  }) {
    return MovieDetailsState(
      movieDetails: movieDetails ?? this.movieDetails,
      movieDetailsMessage: movieDetailsMessage ?? this.movieDetailsMessage,
      movieDetailsState: movieDetailsState ?? this.movieDetailsState,
      movieRecommendation: movieRecommendation ?? this.movieRecommendation,
      movieRecommendationState: movieRecommendationState ?? this.movieRecommendationState,
      movieRecommendationMessage: movieRecommendationMessage ?? this.movieRecommendationMessage
    );
  }

  @override
  List<Object?> get props =>
      [
        movieDetails,
        movieDetailsState,
        movieDetailsMessage,
        movieRecommendation,
        movieRecommendationState,
        movieRecommendationMessage
      ];
}
