import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_login/controller/providers/home_provider.dart';
import 'package:test_login/utils/app_constant/images.dart';
import 'package:test_login/utils/colors/color.dart';
import 'package:test_login/views/home/widgets/bottom_navigator/bottom_navigator.dart';
import 'package:test_login/views/home/widgets/notification/notification_view.dart';
import 'package:test_login/views/home/widgets/tabs_view/community_tab.dart';
import 'package:test_login/views/home/widgets/tabs_view/for_you_tab.dart';
import 'package:test_login/views/home/widgets/tabs_view/news_tab.dart';
import 'package:test_login/views/home/widgets/tabs_view/public_service_tab.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends ConsumerState<HomeScreen> with SingleTickerProviderStateMixin {
  late final TabController _tabController = TabController(length: 4, vsync: this);
  final int _selectedIndex = 0;

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final newsState = ref.watch(homeNewsProvider);

    return Scaffold(
      appBar: _buildAppBar(),
      body: Column(
        children: [
          Expanded(child: _buildTabView(newsState)),
        ],
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Color(0xFFF8FAFC),
      elevation: 0,
      title: Row(
        children: [
          Expanded(
            child: SizedBox(
              height: 50,
              width: double.infinity,
              child: TextField(
                decoration: InputDecoration(
                  hintStyle: TextStyle(color: AppColors.fontSecondary),
                  hintText: 'Search',
                  prefixIcon: Icon(Icons.search, color: AppColors.fontSecondary),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: AppColors.midWhite,
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          IconButton(
            icon: const Icon(Icons.notifications_none_outlined, color: Colors.blue),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const NotificationListScreen()),
              );
            },
          ),
        ],
      ),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: _buildTabBar(),
      ),
    );
  }

  Widget _buildTabBar() {
    return TabBar(
      controller: _tabController,
      indicatorColor: AppColors.primary,
      unselectedLabelColor: Colors.grey,
      labelColor: AppColors.primary,
      indicatorSize: TabBarIndicatorSize.label,
      tabAlignment: TabAlignment.center,
      isScrollable: true,
      tabs: [
        _buildTab(Images.fireIcon, "For You"),
        _buildTab(Images.newsIcon, "News"),
        _buildTab(Images.publicserviceIcon, "Public Service"),
        _buildTab(Images.communityIcon, "Community"),
      ],
    );
  }

  Widget _buildTabView(AsyncValue<List<dynamic>> newsState) {
    return newsState.when(
      data: (newsList) {
        final newsItems = newsList.where((item) => item.category == 'news').toList();
        final publicServiceItems = newsList.where((item) => item.category == 'public_service').toList();
        final communityItems = newsList.where((item) => item.category == 'community').toList();

        return TabBarView(
          controller: _tabController,
          children: [
            const ForYouTab(),
            NewsTab(newsList: newsItems),
            PublicServiceTab(publicServiceList: publicServiceItems),
            CommunityTab(communityList: communityItems),
          ],
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text('Error loading data: $error', textAlign: TextAlign.center),
        ),
      ),
    );
  }

  Widget _buildTab(String iconPath, String label) {
    return Tab(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(iconPath, width: 20),
          const SizedBox(width: 8),
          Text(label, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, fontFamily: 'Poppins')),
        ],
      ),
    );
  }
}
