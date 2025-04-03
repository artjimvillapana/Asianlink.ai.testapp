import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_login/models/news_model.dart';
import 'package:test_login/utils/app_constant/images.dart';
import 'package:test_login/utils/app_constant/video.dart';

final homeNewsProvider = StateNotifierProvider<HomeNotifier, AsyncValue<List<NewsModel>>>((ref) {
  return HomeNotifier(ref);
});

class HomeNotifier extends StateNotifier<AsyncValue<List<NewsModel>>> {
  final Ref ref;

  HomeNotifier(this.ref) : super(const AsyncValue.loading()) {
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      // Simulate network delay
      await Future.delayed(const Duration(seconds: 1));

      final news = [
        NewsModel(
          title: "Breaking News: Massive Fire...",
          source: "Acme News",
          time: "1h ago",
          imageUrl: Images.fire,
          description: 'A massive fire broke out in the Rocky Mountains...',
          category: 'News',
          createdAt: DateTime.now().subtract(Duration(hours: 1)),
        ),
        NewsModel(
          title: "News Celebrating Prosperity: Chinese New Year 2025 Kicks Off...",
          source: "Acme News",
          time: "Just now",
          imageUrl: Images.chi,
          description: 'Chinese New Year celebrations start in grand style...',
          category: 'News',
          createdAt: DateTime.now(),
        ),
        NewsModel(
          title: "Minimum wage increase under review, Palace says",
          source: "Inquirer.Net",
          time: "Just now",
          isBreakingNews: true,
          isFeatured: true,
          imageUrl: Images.castro,
          description: 'Chinese New Year celebrations start in grand style...',
          category: 'News',
          createdAt: DateTime.now(),
        ),
        NewsModel(
          title: "China warns PH ‘threatening regional peace’ after US OKs jet sale",
          source: "Inquirer.Net",
          time: "Just now",
          isFeatured: true,
          isBreakingNews: false,
          imageUrl: Images.china,
          description: 'Chinese New Year celebrations start in grand style...',
          category: 'News',
          createdAt: DateTime.now(),
        ),
      ];

      final publicService = [
        NewsModel(
          title: "Stay Safe: Classes Canceled in Cavite Due to Heavy Rainfall",
          source: "Health News",
          time: "2h ago",
          imageUrl: "",
          videoUrl: Video.bagyo,
          description: 'New guidelines aim to improve global health standards...',
          category: 'Public Service',
          location: 'Bacoor,Cavite',
          createdAt: DateTime.now(),
        ),
      ];

      final community = [
        NewsModel(
          title: "Our small business just reached a huge  milestone!: 5,000 happy customers!... TEST TEST TEST TEST TEST TEST",
          source: "Local News",
          userName: "John Doe",
          time: "3h ago",
          imageUrl: Images.restaurant,
          likes: 1001,
          comments: 500,
          shares: 200,
          isLiked: true,
          profilePicture: Images.profile,
          description: 'Our small business just reached a huge  milestone!: 5,000 happy customers!........... TEST TEST TEST TEST TEST TEST',
          category: 'Community',
          createdAt: DateTime.now(),
        ),
      ];

      // Combine the data into one list
      final allData = [...news, ...publicService, ...community];

      // Update the state with all combined data
      state = AsyncValue.data(allData);
    } catch (e, stack) {
      // Handle any errors during the fetch
      state = AsyncValue.error(e, stack);
    }
  }
}
