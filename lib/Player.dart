import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:wakelock/wakelock.dart';
import 'PlayerControls.dart';
import 'main.dart';

class Player extends StatefulWidget {
  Video video;

  Player(this.video);

  @override
  State<StatefulWidget> createState() {
    return PlayerState();
  }
}

class PlayerState extends State<Player> {
  static List<VideoPlayerController> player = new List();
  VideoPlayerController _controller;
  static bool isWakelock = false;

  @override
  void initState() {
    super.initState();
    if (!isWakelock) {
      Wakelock.enable();
      isWakelock = true;
    }
    print("Wakelock.enable");
    var url = "assets/v2.mp4";
    print(url);
    _controller = VideoPlayerController.asset(url)
      ..initialize().then((_) {
        _controller.play();
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
    player.add(_controller);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async {
        await _controller.dispose();
        exit(0);
      },
      child: (_controller != null && _controller.value.initialized)
          ? Stack(
              children: [
                Center(
                  child: AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: VideoPlayer(_controller),
                  ),
                ),
                PlayerControls(_controller)
              ],
            )
          : Center(child: CupertinoActivityIndicator()),
    );
  }

  @override
  void dispose() {
    super.dispose();
    print("dispose");
    if (_controller != null) {
      _controller.dispose();
    }
    player.remove(_controller);
    if (isWakelock && player.length <= 0) {
      Wakelock.disable();
      isWakelock = false;
    }
  }
}
