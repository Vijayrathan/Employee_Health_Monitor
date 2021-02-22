import 'dart:async';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

void main() => runApp(VideoPlayerApp());

class VideoPlayerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Video Player Demo',
      home: Stress(),
    );
  }
}

class Stress extends StatefulWidget {
  Stress({Key key}) : super(key: key);

  @override
  _StressState createState() => _StressState();
}

class _StressState extends State<Stress> {
  VideoPlayerController _controller;
  Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    _controller = VideoPlayerController.network(
      'https://firebasestorage.googleapis.com/v0/b/employeehealth-eaf82.appspot.com/o/5-Minute%20Meditation%20You%20Can%20Do%20Anywhere.mp4?alt=media&token=0907869d-f760-42e5-b2b9-25b0a994214f',
    );
    _initializeVideoPlayerFuture = _controller.initialize();
    _controller.setLooping(true);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Peace Space",style: TextStyle(fontSize: 20,fontWeight:FontWeight.bold),),
          backgroundColor: Colors.indigo,
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('images/backgroundapp.jpg'),
                colorFilter: ColorFilter.mode(
                    Colors.white.withOpacity(0.8), BlendMode.dstATop),
                fit: BoxFit.cover),
          ),
          child: ListView(
            children: [
              FutureBuilder(
                future: _initializeVideoPlayerFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return AspectRatio(
                      aspectRatio: _controller.value.aspectRatio,
                      child: VideoPlayer(_controller),
                    );
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                },
              ),
              IconButton(
                icon: Icon(
                  _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
                ),
                onPressed: () {
                  setState(() {
                    if (_controller.value.isPlaying) {
                      _controller.pause();
                    } else {
                      _controller.play();
                    }
                  });
                },
                alignment: Alignment.centerLeft,
              ),
              SizedBox(
                child: Text(
                  "Steps to meditate",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                height: 30,
                width: 20,
              ),
              Container(
                child: Text(
                  """1. Find your meditation spot
              
2. Sit in a comfortable position

3. Clear your mind

4. Simply sit and observe,Meditate for as long as you want, till you feel cleansed, purified, refreshed and good to go.

5.You may also want to just spend a few minutes expressing gratitude toward the things you enjoy in your life
""",
                  style: TextStyle(fontSize: 22),
                ),
                padding: const EdgeInsets.all(20),
              )
            ],
          ),
        )
    );
  }
}
