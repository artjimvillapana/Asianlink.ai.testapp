import 'package:flutter/material.dart';

class PublicServiceTab extends StatelessWidget {
  final List<dynamic> publicServiceList; // Adjust the type based on your data model.

  const PublicServiceTab({super.key, required this.publicServiceList});

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
