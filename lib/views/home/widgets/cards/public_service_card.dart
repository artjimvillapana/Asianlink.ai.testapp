import 'package:flutter/material.dart';
import 'package:test_login/models/news_model.dart';
import 'package:test_login/utils/app_constant/images.dart';
import 'package:test_login/utils/colors/color.dart';
import 'package:video_player/video_player.dart';

class PublicServiceCard extends StatefulWidget {
  final NewsModel service;

  const PublicServiceCard({super.key, required this.service});

  @override
  _PublicServiceCardState createState() => _PublicServiceCardState();
}

class _PublicServiceCardState extends State<PublicServiceCard> {
  VideoPlayerController? videoPlayerController;
  bool isPlaying = false;

  @override
  void initState() {
    super.initState();

    if (widget.service.videoUrl != null && widget.service.videoUrl!.isNotEmpty) {
      videoPlayerController = VideoPlayerController.asset(widget.service.videoUrl!)
        ..initialize().then((_) {
          setState(() {});
        });
    }
  }

  @override
  void dispose() {
    videoPlayerController?.dispose();
    super.dispose();
  }

  void _togglePlayPause() {
    setState(() {
      if (isPlaying) {
        videoPlayerController?.pause();
      } else {
        videoPlayerController?.play();
      }
      isPlaying = !isPlaying;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color(0xFFFFFFFF),
      elevation: 0,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Image.asset(
                  Images.publicserviceIcon,
                  width: 20,
                  height: 20,
                ),
                const SizedBox(width: 8),
                const Text(
                  "Public Service",
                  style: TextStyle(color: AppColors.darkBlue, fontWeight: FontWeight.bold, fontSize: 12),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              widget.service.title,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 5),
            widget.service.imageUrl.isNotEmpty
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      widget.service.imageUrl,
                      width: 150,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                  )
                : widget.service.videoUrl!.isNotEmpty
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            videoPlayerController != null && videoPlayerController!.value.isInitialized
                                ? AspectRatio(
                                    aspectRatio: videoPlayerController!.value.aspectRatio,
                                    child: VideoPlayer(videoPlayerController!),
                                  )
                                : const Center(child: CircularProgressIndicator()),
                            Positioned(
                              child: IconButton(
                                icon: Icon(
                                  isPlaying ? Icons.pause_circle_rounded : Icons.play_arrow_rounded,
                                  size: 50,
                                  color: Colors.white,
                                ),
                                onPressed: _togglePlayPause,
                              ),
                            ),
                          ],
                        ),
                      )
                    : Container(
                        width: 150,
                        height: 100,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Center(child: Icon(Icons.broken_image, size: 40, color: Colors.grey)),
                      ),
            Padding(
              padding: const EdgeInsets.only(top: 5.0),
              child: Row(
                children: [
                  Text(
                    widget.service.location!,
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Text(" • ", style: TextStyle(fontSize: 10, color: Colors.grey)),
                  Text(
                    widget.service.time,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
