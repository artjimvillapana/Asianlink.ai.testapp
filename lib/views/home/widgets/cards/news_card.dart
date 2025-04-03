import 'package:flutter/material.dart';
import 'package:test_login/models/news_model.dart';
import 'package:test_login/utils/app_constant/images.dart';
import 'package:test_login/utils/colors/color.dart';
import 'package:video_player/video_player.dart';

class NewsCard extends StatefulWidget {
  final NewsModel news;

  const NewsCard({super.key, required this.news});

  @override
  NewsCardState createState() => NewsCardState();
}

class NewsCardState extends State<NewsCard> {
  late VideoPlayerController? controller;

  @override
  void initState() {
    super.initState();
    if (widget.news.imageUrl.isEmpty && widget.news.videoUrl!.isNotEmpty) {
      controller = VideoPlayerController.asset(widget.news.videoUrl!)
        ..initialize().then((_) {
          setState(() {});
        });
      controller?.setLooping(true);
    } else {
      controller = null;
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color(0xFFFFFFFF),
      elevation: 0,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Image.asset(Images.newsIcon, width: 15),
                const SizedBox(width: 5),
                const Text(
                  "News",
                  style: TextStyle(
                    color: AppColors.darkBlue,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    widget.news.title,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                    softWrap: true,
                  ),
                ),
                const SizedBox(width: 10),

                // Image or Video (Right)
                if (widget.news.imageUrl.isNotEmpty)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      widget.news.imageUrl,
                      width: 120,
                      height: 80,
                      fit: BoxFit.cover,
                    ),
                  )
                else if (widget.news.videoUrl!.isNotEmpty)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: controller != null && controller!.value.isInitialized
                        ? SizedBox(
                            width: 120,
                            height: 80,
                            child: VideoPlayer(controller!),
                          )
                        : const Center(child: CircularProgressIndicator()),
                  )
                else
                  Container(
                    width: 120,
                    height: 80,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Center(child: Icon(Icons.broken_image, size: 40, color: Colors.grey)),
                  ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Text(
                  "newspost",
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(" • "),
                const Text(
                  "Just now",
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
