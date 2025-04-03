import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:test_login/models/news_model.dart';
import 'package:test_login/utils/app_constant/images.dart';
import 'package:test_login/utils/colors/color.dart';

class CommunityCard extends StatefulWidget {
  final NewsModel community;

  const CommunityCard({super.key, required this.community});

  @override
  CommunityCardState createState() => CommunityCardState();
}

class CommunityCardState extends State<CommunityCard> {
  bool _showFullTitle = false;

  // Toggles the like status
  void _toggleLike() {
    setState(() {
      widget.community.isLiked = !widget.community.isLiked!;
      // widget.community.isLiked! ? widget.community.likes = widget.community.likes! + 1 : widget.community.likes = widget.community.likes! - 1;
    });
  }

  // Show comment input dialog and handle adding a comment
  void _showCommentDialog() {
    TextEditingController commentController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add a Comment'),
          content: TextField(
            controller: commentController,
            decoration: const InputDecoration(hintText: 'Write your comment...'),
            maxLines: 3,
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (commentController.text.isNotEmpty) {
                  setState(() {
                    // widget.community.comments = widget.community.comments! + 1;
                  });
                }
                Navigator.pop(context);
              },
              child: const Text('Post'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  // Show share options for sharing to other platforms
  void _showShareDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Share this post'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: const [
              ListTile(
                leading: Icon(Icons.facebook),
                title: Text('Facebook'),
              ),
              ListTile(
                leading: Icon(Icons.share),
                title: Text('WhatsApp'),
              ),
              ListTile(
                leading: Icon(Icons.email),
                title: Text('Email'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Color(0xFFFFFFFF),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {},
              child: Row(
                children: [
                  Image.asset(
                    Images.communityIcon,
                    width: 20,
                    height: 20,
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    "Community",
                    style: TextStyle(color: AppColors.darkBlue, fontWeight: FontWeight.bold, fontSize: 12),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            GestureDetector(
              onTap: () {},
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage(widget.community.profilePicture ?? ''),
                    radius: 20,
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.community.userName ?? "Unknown",
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        widget.community.time,
                        style: const TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                    ],
                  ),
                  const Spacer(),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12), // Reduced padding
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.add, color: Colors.white, size: 16), // Smaller icon size
                        SizedBox(width: 5),
                        Text(
                          "Follow",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12, // Smaller font size
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            GestureDetector(
              onTap: () {
                setState(() {
                  _showFullTitle = !_showFullTitle;
                });
              },
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Expanded(
                    child: Text(
                      widget.community.title,
                      maxLines: _showFullTitle ? null : 2,
                      overflow: _showFullTitle ? TextOverflow.visible : TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 12),
                    ),
                  ),
                  if (!_showFullTitle)
                    Text(
                      "Show More",
                      style: TextStyle(color: AppColors.unSelectedColor, fontSize: 12),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            GestureDetector(
              onTap: () {},
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  'assets/images/restaurant.jpg',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              spacing: 5,
              children: [
                GestureDetector(
                  onTap: _toggleLike, // Toggle like on tap
                  child: _reactionIcon(
                    FontAwesomeIcons.heart,
                    widget.community.likes!,
                    widget.community.isLiked!,
                  ),
                ),
                GestureDetector(
                  onTap: _showCommentDialog, // Show comment dialog on tap
                  child: _reactionIcon(
                    FontAwesomeIcons.message,
                    widget.community.comments!,
                    false,
                  ),
                ),
                GestureDetector(
                  onTap: _showShareDialog, // Show share dialog on tap
                  child: _reactionIcon(
                    Icons.share_outlined,
                    widget.community.shares!,
                    false,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _reactionIcon(IconData icon, int count, bool isActive) {
    return Row(
      children: [
        Icon(icon, size: 20, color: isActive ? Colors.red : Colors.grey),
        const SizedBox(width: 5),
        Text(
          count.toString(),
          style: TextStyle(
            color: isActive ? Colors.red : Colors.grey,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
