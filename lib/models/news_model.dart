class NewsModel {
  final String title;
  final String source;
  final String time;
  final String imageUrl;
  final String description;
  final String category;
  final String? profilePicture;
  final String? userName;
  final String? postContent;
  final String? postImage;
  final int? likes;
  final int? comments;
  final String? location;
  final int? shares;
  final String? videoUrl;
  bool? isFeatured = false;
  bool? isBreakingNews = false;
  bool? isLiked = false;
  DateTime? createdAt;

  NewsModel({this.isLiked, this.isBreakingNews, this.isFeatured, this.location, this.videoUrl, this.likes, this.comments, this.shares, required this.title, required this.source, required this.time, required this.imageUrl, required this.description, required this.category, this.profilePicture, this.userName, this.postContent, this.postImage, this.createdAt});

  bool get isCommunity => category.toLowerCase() == 'community';
}
