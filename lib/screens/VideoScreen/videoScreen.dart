import 'package:aradhana/Constants/Constants.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class videoScreen extends StatefulWidget {
  static String routeName = "/videoScreen";

  const videoScreen({Key key}) : super(key: key);

  @override
  State<videoScreen> createState() => _videoScreenState();
}

class _videoScreenState extends State<videoScreen> {
  final videoUrl = "https://www.youtube.com/watch?v=mwJ6PJFRMBo";
  YoutubePlayerController _ctrl;
  @override
  void initState() {
    final videoId = YoutubePlayer.convertUrlToId(videoUrl);
    _ctrl = YoutubePlayerController(initialVideoId: videoId);
    super.initState();
  }

  void _launch(String id) async =>
      await canLaunch(id) ? await launch(id) : throw 'Could not launch $id';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("How To Use?", style: appBarTxtStyl),
        actions: [
          IconButton(
              onPressed: () {
                Share.share('Check this out!\n https://rb.gy/wtanw');
              },
              icon: Icon(Icons.share))
        ],
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height * 0.7,
        child: YoutubePlayer(
          controller: _ctrl,
          // aspectRatio: 16 / 9,
          showVideoProgressIndicator: true,
        ),
      ),
    );
  }
}
