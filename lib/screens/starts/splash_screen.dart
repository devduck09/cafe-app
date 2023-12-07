import 'package:CUDI/screens/starts/launch_screen.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

// class  extends StatelessWidget {
//   const SplashScreen({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//
//     // 비동기 함수로 만듭니다.
//     Future.delayed(Duration(seconds: 2), () async {
//       // await Navigator.pushReplacement<void, void>(
//       //   context,
//       //   MaterialPageRoute<void>(
//       //     builder: (BuildContext context) => const LaunchScreen(),
//       //   ),
//       // );
//     });
//
//     return Scaffold(
//       body: VideoPlayer(VideoPlayerController.asset('assets/images/00_splash_video.mp4')),
//     );
//   }
// }

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('assets/images/00_splash_video.mp4')
      ..initialize().then((_) {
        _controller.play();
        setState(() {});
        _controller.addListener(() {
          if (_controller.value.position == _controller.value.duration) {
            _navigateToNextScreen();
          }
        });
      });
  }

  void _navigateToNextScreen() {
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 700),
        pageBuilder: (_, __, ___) => const LaunchScreen(),
        transitionsBuilder: (_, animation, __, child) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
      return Scaffold(
        body: Center(
          child: _controller.value.isInitialized
              ? AspectRatio(
            aspectRatio: _controller.value.aspectRatio,
            child: VideoPlayer(_controller),
          )
              : Container(),
        ),
        // floatingActionButton: FloatingActionButton(
        //   onPressed: () {
        //     setState(() {
        //       _controller = VideoPlayerController.asset('assets/images/00_splash_video.mp4')
        //         ..initialize().then((_) {
        //           // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        //           _controller.play();
        //           setState(() {});
        //         });
        //     });
        //   },
        //   child: Icon(
        //     _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
        //   ),
        // ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}

