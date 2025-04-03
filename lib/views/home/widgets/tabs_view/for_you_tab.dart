import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shimmer/shimmer.dart';
import 'package:test_login/models/news_model.dart';
import 'package:test_login/controller/providers/home_provider.dart';
import 'package:test_login/utils/colors/color.dart';
import 'package:test_login/views/home/widgets/cards/community_card.dart';
import 'package:test_login/views/home/widgets/cards/featured_news.dart';
import 'package:test_login/views/home/widgets/cards/news_card.dart';
import 'package:test_login/views/home/widgets/cards/public_service_card.dart';

class ForYouTab extends ConsumerWidget {
  const ForYouTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final newsState = ref.watch(homeNewsProvider);

    return newsState.when(
      data: (newsList) {
        if (newsList.isEmpty) {
          return const Center(child: Text("No news available."));
        }

        newsList.sort((a, b) => b.createdAt!.compareTo(a.createdAt!));

        final Map<String, List<NewsModel>> categorizedNews = {};
        for (var news in newsList) {
          categorizedNews.putIfAbsent(news.category, () => []).add(news);
        }

        final randomizedCategories = categorizedNews.entries.toList();
        randomizedCategories.shuffle(Random());

        final newsItems = newsList.where((item) => item.category == 'News' && item.isFeatured == true).toList();

        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionTitle("Featured News"),
              FeaturedNews(newsList: newsItems),
              for (var entry in randomizedCategories) ...[
                Column(
                  children: entry.value.map((newsItem) {
                    return _buildPostCard(newsItem);
                  }).toList(),
                ),
              ],
            ],
          ),
        );
      },
      loading: () => FutureBuilder(
        future: Future.delayed(const Duration(seconds: 10)),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return _buildShimmerLoader();
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      error: (error, stack) => Center(child: Text('Error: $error', style: const TextStyle(color: Colors.red))),
    );
  }

  Widget _buildPostCard(NewsModel news) {
    switch (news.category) {
      case 'Breaking News':
        return NewsCard(news: news);
      case 'Community':
        return CommunityCard(community: news);
      case 'Public Service':
        return PublicServiceCard(service: news);
      default:
        return NewsCard(news: news);
    }
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(color: AppColors.darkBlue, fontWeight: FontWeight.w600, fontSize: 15)),
          const Text("See More", style: TextStyle(color: AppColors.primary, fontSize: 12)),
        ],
      ),
    );
  }

  Widget _buildShimmerLoader() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 5,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              height: 100,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        );
      },
    );
  }
}
