import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:meta/meta.dart';
import 'package:movies_app/core/base_usecase/base_usecase.dart';
import 'package:movies_app/core/utils/enums.dart';
import 'package:movies_app/movies/domain/usecases/get_now_playing_movies_usecase.dart';
import 'package:movies_app/movies/domain/usecases/get_popluar_movies_usecase.dart';
import 'package:movies_app/movies/domain/usecases/get_top_rated_movies_usecase.dart';

import '../../domain/entities/movie.dart';

part 'movies_event.dart';

part 'movies_state.dart';

class MoviesBloc extends Bloc<MoviesEvent, MoviesState> {
  final GetNowPlayingMoviesUseCase getNowPlayingMoviesUseCase;
  final GetPopularMoviesUseCase getPopularMoviesUseCase;
  final GetTopRatedMoviesUseCase getTopRatedMoviesUseCase;

  int page = 1;
  ScrollController scrollController = ScrollController();
  final PagingController<int, Movie> pagingController =
  PagingController(firstPageKey: 1);


  MoviesBloc(this.getNowPlayingMoviesUseCase, this.getPopularMoviesUseCase, this.getTopRatedMoviesUseCase) : super(const MoviesState()) {
    on<GetNowPlayingMoviesEvent>(_getPlayingNowMovies);

    on<GetPopularMoviesEvent>(_getPopularMovies);

    on<GetTopRatedMoviesEvent>(_getTopRatedMovies);

    on<GetPopularMoviesNextPageEvent>(_getPopularMoviesNextPage);


    // scrollController.addListener(() {
    //   add(GetPopularMoviesNextPageEvent(page: page));
    // });

    pagingController.addPageRequestListener((pageKey) {
      add(GetPopularMoviesNextPageEvent(page: page));
    });



  }

  FutureOr<void> _getPlayingNowMovies(GetNowPlayingMoviesEvent event, Emitter<MoviesState> emit) async{
    final result = await getNowPlayingMoviesUseCase(const NoParameter());
    print(result);
    result.fold((l) =>
        emit(state.copyWith(nowPlayingMoviesRequestState: RequestState.error,
            nowPlayingMoviesMessage: l.message)), (r) =>
        emit(state.copyWith(nowPlayingMoviesRequestState: RequestState.loaded,
            nowPlayingMovies: r)));
  }

  FutureOr<void> _getPopularMovies(GetPopularMoviesEvent event, Emitter<MoviesState> emit) async{
    final result = await getPopularMoviesUseCase(const PopularMoviesPageParameter(page: 1));
    print(result);
    result.fold((l) =>
        emit(state.copyWith(popularMoviesRequestState: RequestState.error,
            popularMoviesMessage: l.message)), (r) =>
        emit(state.copyWith(popularMoviesRequestState: RequestState.loaded,
            popularMovies: r)));
  }

  FutureOr<void> _getTopRatedMovies(GetTopRatedMoviesEvent event, Emitter<MoviesState> emit) async{
    final result = await getTopRatedMoviesUseCase(const TopRatedMoviesPageParameter(page: 1));
    print(result);
    result.fold((l) =>
        emit(state.copyWith(topRatedMoviesRequestState: RequestState.error,
            topRatedMoviesMessage: l.message)), (r) =>
        emit(state.copyWith(topRatedMoviesRequestState: RequestState.loaded,
            topRatedMovies: r)));
  }


  Future<FutureOr<void>> _getPopularMoviesNextPage(GetPopularMoviesNextPageEvent event, Emitter<MoviesState> emit) async {
    // if(pagingController. == scrollController.position.maxScrollExtent){
      emit(state.copyWith(loadMoreRequestState: RequestState.loading));
      page++;
      final result = await getPopularMoviesUseCase( PopularMoviesPageParameter(page: page));
      print(result);
      result.fold((l) =>
          emit(state.copyWith(loadMoreRequestState: RequestState.error,
              popularMoviesMessage: l.message)), (r) =>
          emit(state.copyWith(loadMoreRequestState: RequestState.loaded,
              popularMovies: [...state.popularMovies,...r])));
    }
  }



