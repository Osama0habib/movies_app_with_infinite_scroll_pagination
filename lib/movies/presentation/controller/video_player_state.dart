part of 'video_player_bloc.dart';

class VideoPlayerState extends Equatable {
  final YoutubePlayerController? youtubePlayerController ;
  final RequestState videoInitilaizeState;
  const VideoPlayerState({this.youtubePlayerController,this.videoInitilaizeState = RequestState.loading,});

  VideoPlayerState copyWith(
      {YoutubePlayerController? youtubePlayerController,RequestState? videoInitilaizeState}) =>
      VideoPlayerState(
          youtubePlayerController:
          youtubePlayerController ??this.youtubePlayerController,videoInitilaizeState: videoInitilaizeState ?? this.videoInitilaizeState);

  @override
  List<Object?> get props => [youtubePlayerController];
}


