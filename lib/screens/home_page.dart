import 'package:flutter/material.dart';
import '../models/place.dart';
import '../services/api_service.dart';
import '../widgets/category_button.dart';
import '../widgets/destination_card.dart';
import '../widgets/custom_bottom_nav.dart';
import '../utils/constants.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Place> places = [];
  bool isLoading = true;
  String selectedCategory = AppStrings.all;
  int currentNavIndex = 0;

  @override
  void initState() {
    super.initState();
    loadPlaces();
  }

  Future<void> loadPlaces() async {
    try {
      setState(() {
        isLoading = true;
      });

      List<Place> loadedPlaces = await ApiService.getAllPlace();

      setState(() {
        places = loadedPlaces;
        isLoading = false;
      });

    } catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error loading places: $e')),
      );
    }
  }

  List<Place> getFilteredPlaces() {
    if (selectedCategory == AppStrings.all) {
      return places;
    }
    return places.where((place) => place.category == selectedCategory).toList();
  }

  void onFavoriteToggle(Place place) {
    // Handle favorite toggle logic here
    print('Toggled favorite for: ${place.name}');
  }

  void onNavTap(int index) {
    setState(() {
      currentNavIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Section
            _buildHeader(),
            SizedBox(height: 30),

            // Category Buttons
            _buildCategoryButtons(),
            SizedBox(height: 30),

            // Popular Destinations Title
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                AppStrings.popularDestinations,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),
            SizedBox(height: 15),

            // Popular Destinations Grid
            _buildDestinationsGrid(),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNav(
        currentIndex: currentNavIndex,
        onTap: onNavTap,
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.primaryPurple,
            AppColors.lightPurple,
          ],
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(Icons.menu, color: Colors.white, size: 28),
              Icon(Icons.notifications_outlined, color: Colors.white, size: 28),
            ],
          ),
          SizedBox(height: 20),
          Text(
            AppStrings.greeting,
            style: TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 5),
          Text(
            AppStrings.subtitle,
            style: TextStyle(
              color: Colors.white70,
              fontSize: 16,
            ),
          ),
          SizedBox(height: 20),
          // Search Bar
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: Offset(0, 5),
                ),
              ],
            ),
            child: TextField(
              decoration: InputDecoration(
                hintText: AppStrings.searchHint,
                prefixIcon: Icon(Icons.search, color: Colors.grey),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryButtons() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          CategoryButton(
            title: AppStrings.hotels,
            icon: Icons.hotel,
            color: AppColors.orangeCategory,
            isSelected: selectedCategory == AppStrings.hotels,
            onTap: () {
              setState(() {
                selectedCategory = AppStrings.hotels;
              });
            },
          ),
          CategoryButton(
            title: AppStrings.flights,
            icon: Icons.flight,
            color: AppColors.redCategory,
            isSelected: selectedCategory == AppStrings.flights,
            onTap: () {
              setState(() {
                selectedCategory = AppStrings.flights;
              });
            },
          ),
          CategoryButton(
            title: AppStrings.all,
            icon: Icons.explore,
            color: AppColors.greenCategory,
            isSelected: selectedCategory == AppStrings.all,
            onTap: () {
              setState(() {
                selectedCategory = AppStrings.all;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDestinationsGrid() {
    return Expanded(
      child: isLoading
          ? Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(AppColors.primaryPurple),
        ),
      )
          : Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.8,
            crossAxisSpacing: 15,
            mainAxisSpacing: 15,
          ),
          itemCount: getFilteredPlaces().length,
          itemBuilder: (context, index) {
            return DestinationCard(
              place: getFilteredPlaces()[index],
              onFavoriteToggle: onFavoriteToggle,
            );
          },
        ),
      ),
    );
  }
}