import 'package:fitness/core/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

BottomNavigationBar customButtomNavigation(){
  final HomePageController homePageController = sl<HomePageController>();

  return BottomNavigationBar(
        currentIndex: homePageController.bottomPageIndex.value,
        onTap: homePageController.setBottomIndex,
        selectedItemColor: Colors.blue, // Set the color for the selected item
        unselectedItemColor: Colors.grey, // Set the color for the unselected items
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.restaurant_menu),
            label: 'Diet',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.fitness_center),
            label: 'Exercise',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Chat',
          ),
        ],
      );
}