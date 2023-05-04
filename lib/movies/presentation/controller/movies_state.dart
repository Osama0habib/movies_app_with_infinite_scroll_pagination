part of 'movies_bloc.dart';

@immutable
class MoviesState extends Equatable {
  final List<Movie> nowPlayingMovies;
  final RequestState nowPlayingMoviesRequestState;
  final String nowPlayingMoviesMessage;
  final List<Movie> popularMovies;
  final RequestState popularMoviesRequestState;
  final String popularMoviesMessage;
  final List<Movie> topRatedMovies;
  final RequestState topRatedMoviesRequestState;
  final String topRatedMoviesMessage;
  final RequestState loadMoreRequestState;

  const MoviesState(
      {this.nowPlayingMovies = const [],
      this.nowPlayingMoviesRequestState = RequestState.loading,
      this.nowPlayingMoviesMessage = "",
      this.popularMovies = const [],
      this.popularMoviesRequestState = RequestState.loading,
      this.popularMoviesMessage = "",
      this.topRatedMovies = const [],
      this.topRatedMoviesMessage = "",
      this.topRatedMoviesRequestState = RequestState.loading,
      this.loadMoreRequestState = RequestState.loaded});

  MoviesState copyWith({
    List<Movie>? nowPlayingMovies,
    RequestState? nowPlayingMoviesRequestState,
    String? nowPlayingMoviesMessage,
    List<Movie>? popularMovies,
    RequestState? popularMoviesRequestState,
    String? popularMoviesMessage,
    List<Movie>? topRatedMovies,
    RequestState? topRatedMoviesRequestState,
    String? topRatedMoviesMessage,
    RequestState? loadMoreRequestState,
  }) {
    return MoviesState(
        nowPlayingMovies: nowPlayingMovies ?? this.nowPlayingMovies,
        nowPlayingMoviesRequestState:
            nowPlayingMoviesRequestState ?? this.nowPlayingMoviesRequestState,
        nowPlayingMoviesMessage:
            nowPlayingMoviesMessage ?? this.nowPlayingMoviesMessage,
        popularMovies: popularMovies ?? this.popularMovies,
        popularMoviesRequestState:
            popularMoviesRequestState ?? this.popularMoviesRequestState,
        popularMoviesMessage: popularMoviesMessage ?? this.popularMoviesMessage,
        topRatedMovies: topRatedMovies ?? this.topRatedMovies,
        topRatedMoviesRequestState:
            topRatedMoviesRequestState ?? this.topRatedMoviesRequestState,
        topRatedMoviesMessage:
            topRatedMoviesMessage ?? this.topRatedMoviesMessage,
        loadMoreRequestState:
            loadMoreRequestState ?? this.loadMoreRequestState);
  }

  @override
  List<Object> get props => [
        nowPlayingMovies,
        nowPlayingMoviesRequestState,
        nowPlayingMoviesMessage,
        popularMovies,
        popularMoviesRequestState,
        popularMoviesMessage,
        topRatedMovies,
        topRatedMoviesRequestState,
        topRatedMoviesMessage,
        loadMoreRequestState
      ];
}

// class MoviesInitial extends MoviesState {}
