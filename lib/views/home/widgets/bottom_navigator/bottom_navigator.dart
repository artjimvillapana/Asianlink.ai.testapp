import 'package:flutter/material.dart';
import 'package:test_login/utils/colors/color.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      selectedItemColor: AppColors.primary,
      unselectedItemColor: AppColors.unSelectedColor,
      showUnselectedLabels: true,
      selectedLabelStyle: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.bold,
      ),
      unselectedLabelStyle: TextStyle(
        fontSize: 12,
      ),
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined, size: 25),
          label: "Home",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.video_library, size: 25),
          label: "Videos",
        ),
        BottomNavigationBarItem(
          icon: Transform.translate(
            offset: Offset(0, 10), // This will lower the middle icon
            child: Container(
              padding: EdgeInsets.all(10), // Adjust padding as needed
              child: Icon(
                Icons.add_box,
                color: AppColors.primary,
                size: 40, // Larger size for the middle item
              ),
            ),
          ),
          label: "",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.message_outlined, size: 25),
          label: "Message",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.account_circle_outlined, size: 25),
          label: "Account",
        ),
      ],
      type: BottomNavigationBarType.fixed,
    );
  }
}
