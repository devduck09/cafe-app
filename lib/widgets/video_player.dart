import 'package:CUDI/config/theme.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

import '../utils/provider.dart';

class VideoApp extends StatefulWidget {
  final String videoUrl;
  final String thumbnailUrl;

  const VideoApp({
    Key? key,
    required this.videoUrl,
    required this.thumbnailUrl,
  }) : super(key: key);

  @override
  _VideoAppState createState() => _VideoAppState();
}

class _VideoAppState extends State<VideoApp> {
  late VideoPlayerController videoPlayerController;
  late ChewieController _chewieController;
  late CudiProvider provider;
  late bool isView;

  @override
  void initState() {
    super.initState();

    videoPlayerController = VideoPlayerController.network(widget.videoUrl)
      ..initialize().then((_) {
        setState(() {
          // 비디오 초기화가 완료된 후에 UI를 업데이트합니다.
        });
      });

    _chewieController = ChewieController(
      videoPlayerController: videoPlayerController,
      looping: true,
      customControls: const CupertinoControls(
        backgroundColor: Colors.transparent,
        iconColor: Colors.white,
      ),
      allowFullScreen: true,
      showOptions: true,
      additionalOptions: (context) {
        return <OptionItem>[
          OptionItem(
            onTap: () => debugPrint('My option works!'),
            iconData: Icons.chat,
            title: 'My localized title',
          ),
          OptionItem(
            onTap: () =>
                debugPrint('Another option that works!'),
            iconData: Icons.chat,
            title: 'Another localized title',
          ),
        ];
      },
      // optionsBuilder: (context, defaultOptions) async {
      //   await showDialog<void>(
      //     context: context,
      //     builder: (ctx) {
      //       return AlertDialog(
      //         content: ListView.builder(
      //           itemCount: defaultOptions.length,
      //           itemBuilder: (_, i) => ActionChip(
      //             label: Text(defaultOptions[i].title),
      //             onPressed: () =>
      //                 defaultOptions[i].onTap!(),
      //           ),
      //         ),
      //       );
      //     },
      //   );
      // },
      errorBuilder: (context, errorMessage) {
        return Center(
          child: Text(
            errorMessage,
            style: const TextStyle(color: Colors.white),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<CudiProvider>(context);
    isView = provider.isView;

    return Container(
      child: _buildVideoWidget(context),
    );
  }

  Widget _buildVideoWidget(BuildContext context) {
    if (!videoPlayerController.value.isInitialized) {
      return Container();
    }

    return AspectRatio(
      aspectRatio: videoPlayerController.value.aspectRatio,
      child: Stack(
        children: [
          Positioned(top:50.0,bottom:50.0,left:0,right:0,child: Chewie(controller: _chewieController)),
          _buildThumbnailWidget(context),
          _buildCloseButtonWidget(context),
        ],
      ),
    );
  }

  Widget _buildThumbnailWidget(BuildContext context) {
    return isView
        ? SizedBox()
        : InkWell(
      onTap: () {
        if (!isView) {
          provider.setView(isView);
          _chewieController.play();
        } else {
          debugPrint('실행안됨');
        }
      },
      child: AspectRatio(
        aspectRatio: videoPlayerController.value.aspectRatio,
        child: AnimatedOpacity(
          opacity: isView ? 0.0 : 1.0,
          duration: const Duration(milliseconds: 700),
          child: Image.network(widget.thumbnailUrl, fit: BoxFit.cover),
        ),
      ),
    );
  }

  Widget _buildCloseButtonWidget(BuildContext context) {
    return Positioned(
      top: 47.0,
      left: 35,
      child: AnimatedOpacity(
        opacity: isView ? 1.0 : 0.0,
        duration: const Duration(milliseconds: 0),
        child: CloseButton(
          style: ButtonStyle(
            iconSize: MaterialStatePropertyAll(24.0),
                iconColor: MaterialStatePropertyAll(white.withOpacity(0.9))
          ),
          onPressed: () {
            provider.setView(isView);
            _chewieController.pause();
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    if (isView) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        // 폐기 전에 setState() 호출을 예약
        provider.setView(isView);
      });
    }
    videoPlayerController.dispose();
    _chewieController.dispose();
  }
}
