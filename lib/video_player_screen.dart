import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerScreen extends StatefulWidget {
  final String _link;
  const VideoPlayerScreen(this._link, {super.key});

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late VideoPlayerController _controller;

  @override
  void didUpdateWidget(VideoPlayerScreen oldWidget) {
    initController();
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    initController();
    super.initState();
  }

  void initController() {
    print(widget._link);
    _controller = VideoPlayerController.networkUrl(
      Uri.parse(widget._link),
      videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true),
    );

    _controller.addListener(() {
      setState(() {});
    });
    _controller.setLooping(true);
    _controller.initialize().then((_) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Video player'),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              ),
              Text('Position: ${_controller.value.position}'),
              // Align(
              //     alignment: Alignment.bottomCenter,
              //     child: VideoProgressIndicator(_controller, allowScrubbing: true)),
              Slider(
                value: _controller.value.position.inMilliseconds.toDouble(),
                min: 0,
                max: _controller.value.duration.inMilliseconds.toDouble(),
                onChanged: (value) async {
                  await _controller
                      .seekTo(Duration(milliseconds: value.toInt()));
                },
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 60,
              color: Colors.white,
              alignment: Alignment.bottomCenter,
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(_controller.value.isPlaying
                        ? Icons.pause
                        : Icons.play_arrow),
                    onPressed: () {
                      setState(() {
                        _controller.value.isPlaying
                            ? _controller.pause()
                            : _controller.play();
                      });
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.replay_10),
                    onPressed: () async {
                      await _controller.seekTo(_controller.value.position -
                          const Duration(seconds: 10));
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.forward_10),
                    onPressed: () async {
                      await _controller.seekTo(_controller.value.position +
                          const Duration(seconds: 10));
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.replay),
                    onPressed: () async {
                      await _controller.seekTo(const Duration(seconds: 0));
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
