import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YouTubePlayer extends StatefulWidget {
  const YouTubePlayer({Key? key, required this.videoId}) : super(key: key);

  final String videoId;

  @override
  State<YouTubePlayer> createState() => _YouTubePlayerState();
}

class _YouTubePlayerState extends State<YouTubePlayer> {
  late final YoutubePlayerController youtubePlayerController;
  final bool _isPlayerReady = false;
  void listener() {
    if (_isPlayerReady && mounted && !youtubePlayerController.value.isFullScreen) {
      setState(() {});
    }
  }
  @override
  void initState() {
    super.initState();
    youtubePlayerController = YoutubePlayerController(
      initialVideoId: widget.videoId,
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
      ),

    );
  }

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: FadeInUp(
        from: 20,
        duration: const Duration(milliseconds: 500),
        child: YoutubePlayerBuilder(
          onExitFullScreen: () {
            // The player forces portraitUp after exiting fullscreen. This overrides the behaviour.
            SystemChrome.setPreferredOrientations(DeviceOrientation.values);
          },
          player: YoutubePlayer(

            controller: youtubePlayerController,
            showVideoProgressIndicator: false,
            progressIndicatorColor: Colors.blueAccent,
            topActions: <Widget>[
              const SizedBox(width: 8.0),
              Expanded(
                child: Text(
                  youtubePlayerController.metadata.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),

            ],
            onReady: () {
              youtubePlayerController.addListener(listener);
            },
            onEnded: (data) {},
          ),
            onEnterFullScreen: (){

            },
          builder: (context, player) =>
              player
        ),
      ),
    );
  }
}
