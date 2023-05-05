part of 'video_player_bloc.dart';

abstract class VideoPlayerEvent extends Equatable {
  const VideoPlayerEvent();
  @override
  List<Object> get props => [];
}

class VideoPlayerInitEvent extends VideoPlayerEvent {
  final String videoId;

  const VideoPlayerInitEvent(this.videoId);


  @override
  List<Object> get props => [videoId];
}

class EnterFullScreen extends VideoPlayerEvent {

}
