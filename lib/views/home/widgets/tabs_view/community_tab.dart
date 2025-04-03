import 'package:flutter/material.dart';

class CommunityTab extends StatelessWidget {
  final List<dynamic> communityList; // Adjust the type based on your data model.

  const CommunityTab({super.key, required this.communityList});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [],
      ),
    );
  }
}
