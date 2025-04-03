import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:test_login/utils/app_constant/images.dart';
import 'package:test_login/utils/colors/color.dart';

class FeaturedNews extends StatefulWidget {
  final List<dynamic> newsList;

  const FeaturedNews({super.key, required this.newsList});

  @override
  FeaturedNewsState createState() => FeaturedNewsState();
}

class FeaturedNewsState extends State<FeaturedNews> {
  final CarouselSliderController _carouselController = CarouselSliderController();
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    if (widget.newsList.isEmpty) {
      return const Center(child: Text('No featured news available.'));
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Column(
        children: [
          SizedBox(
            height: 200,
            child: CarouselSlider.builder(
              carouselController: _carouselController,
              itemCount: widget.newsList.length,
              itemBuilder: (context, index, realIndex) {
                final news = widget.newsList[index];
                final imageUrl = news.imageUrl ?? 'assets/placeholder.jpg';

                return _buildNewsCard(news, imageUrl);
              },
              options: CarouselOptions(
                height: 180,
                initialPage: 1,
                enableInfiniteScroll: true,
                viewportFraction: 0.7,
                onPageChanged: (index, reason) {
                  setState(() {
                    _currentPage = index;
                  });
                },
              ),
            ),
          ),
          const SizedBox(height: 10),
          _buildIndicator(),
        ],
      ),
    );
  }

  Widget _buildNewsCard(dynamic news, String imageUrl) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.65,
        margin: const EdgeInsets.only(left: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: news.isBreakingNews ? AppColors.brightyellow : Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    height: 120,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        image: AssetImage(imageUrl),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  if (news.isBreakingNews)
                    Positioned(
                      top: 8,
                      left: 8,
                      child: _buildBreakingNewsIndicator(),
                    ),
                ],
              ),
              const SizedBox(height: 8),
              if (news.isBreakingNews)
                Row(
                  children: [
                    Image.asset(
                      Images.siren,
                      width: 14,
                      height: 14,
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        'Breaking News: ${news.title ?? 'No Title'}',
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 10,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ],
                )
              else
                Text(
                  news.title ?? 'No Title',
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 10,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              Row(
                children: [
                  Text(
                    news.source ?? 'No Source',
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 10,
                    ),
                  ),
                  const SizedBox(width: 5),
                  Text(
                    news.time ?? 'No Time',
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Breaking news indicator widget
  Widget _buildBreakingNewsIndicator() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        children: [
          Image.asset(
            Images.siren,
            width: 14,
            height: 14,
          ),
          const SizedBox(width: 3),
          Text(
            'Breaking News',
            style: const TextStyle(
              color: Colors.black,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  // Method to build carousel indicators
  Widget _buildIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: widget.newsList.asMap().entries.map((entry) {
        return GestureDetector(
          onTap: () => _carouselController.animateToPage(entry.key),
          child: Container(
            width: 6.0,
            height: 6.0,
            margin: const EdgeInsets.symmetric(horizontal: 3.0),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _currentPage == entry.key ? AppColors.darkGrey : Colors.grey[200],
            ),
          ),
        );
      }).toList(),
    );
  }
}
