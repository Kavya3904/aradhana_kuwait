import 'package:aradhana/Constants/Constants.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class videoPage extends StatefulWidget {
  static String routeName = "/videoPage";

  const videoPage({Key key}) : super(key: key);

  @override
  State<videoPage> createState() => _videoPageState();
}

class _videoPageState extends State<videoPage> {
  bool load = true;
  VideoPlayerController videoPlayerController;
  ChewieController chewieController;
  //-----------------------------
  YoutubePlayerController _controller;

//-----------------------------
  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: 'b1G9hSU5ZFw',
      flags: YoutubePlayerFlags(
        autoPlay: true,
      ),
    );
    // initializeVideoPlayer();
  }

  @override
  void dispose() {
    videoPlayerController.dispose();
    chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text("Welcome to Aradhana Jewellery", style: appBarTxtStyl),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        height: MediaQuery.of(context).size.height * 0.8,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15), color: Colors.white),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 50, top: 10),
          child: YoutubePlayer(
            controller: _controller,
            bottomActions: [
              CurrentPosition(),
              ProgressBar(isExpanded: true),
              RemainingDuration(),
              // FullScreenButton(),
            ],
            aspectRatio: 9 / 16,
            showVideoProgressIndicator: true,
            progressIndicatorColor: Colors.amber,
            progressColors: ProgressBarColors(
              playedColor: Colors.amber,
              handleColor: Colors.amberAccent,
            ),
            onReady: () {
              _controller.addListener(() {});
            },
          ),
        ),
      ),
    );
  }
}
