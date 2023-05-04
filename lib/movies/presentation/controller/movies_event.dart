part of 'movies_bloc.dart';

@immutable
abstract class MoviesEvent extends Equatable {
  const MoviesEvent();

  @override
  List<Object> get props => [];
}

class GetNowPlayingMoviesEvent extends MoviesEvent {}

class GetPopularMoviesEvent extends MoviesEvent {
  final int page;

  const GetPopularMoviesEvent({required this.page});

  @override
  List<Object> get props => [page];
}

class GetTopRatedMoviesEvent extends MoviesEvent {
  final int page;

  const GetTopRatedMoviesEvent({required this.page});

  @override
  List<Object> get props => [page];

}

class GetPopularMoviesNextPageEvent extends MoviesEvent {
  final int page;

  const GetPopularMoviesNextPageEvent({required this.page});

  @override
  List<Object> get props => [page];

}


