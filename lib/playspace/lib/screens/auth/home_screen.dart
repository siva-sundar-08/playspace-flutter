import 'package:flutter/material.dart';

import 'bookings_screen.dart';
import 'explore_screen.dart';
import 'settings_screen.dart';
import 'profile_screen.dart';
import 'notification_screen.dart';
// Import venue booking screen
import '../venues/venue_booking_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  
  // Define our custom color scheme
  final Color primaryGreen = const Color(0xFF007F5A);
  final Color limeAccent = const Color(0xFFC8FA60);
  final Color backgroundColor = const Color(0xFFFFFFFF);
  final Color darkGreen = const Color(0xFF094531);
  
  // List of screens for the bottom navigation
  late final List<Widget> _screens;
  
  @override
  void initState() {
    super.initState();
    // Initialize the screens list
    _screens = [
      _buildHomeContent(),
      const BookingsScreen(),
      const ExploreScreen(),
      const SettingsScreen(), 
      _buildExploreContent(),
      _buildSettingsContent(),
    ];
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: _selectedIndex == 0 ? _buildAppBar() : null,
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: primaryGreen,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Bookings',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.explore),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
  
  // Build the app bar for the home screen
  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: backgroundColor,
      elevation: 0,
      title: Text(
        'PlaySpace',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: darkGreen,
        ),
      ),
      automaticallyImplyLeading: false, // Remove back button
      actions: [
        IconButton(
          icon: Icon(Icons.notifications_outlined, color: primaryGreen),
          onPressed: () {
            // Navigate to notifications
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const NotificationScreen(),
              ),
            );
          },
        ),
        IconButton(
          icon: Icon(Icons.person_outline, color: primaryGreen),
          onPressed: () {
            // Navigate to profile
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ProfileScreen(),
              ),
            );
          },
        ),
      ],
    );
  }
  
  // Home tab content
  Widget _buildHomeContent() {
    // Rest of the method remains the same...
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // Welcome section
          Text(
            'Welcome to PlaySpace',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: darkGreen,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Book your favorite play experiences',
            style: TextStyle(
              fontSize: 16,
              color: primaryGreen.withOpacity(0.7),
            ),
          ),
          const SizedBox(height: 24),
          
          // Search bar
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search for venues, games, or experiences',
                hintStyle: TextStyle(color: primaryGreen.withOpacity(0.5)),
                prefixIcon: Icon(Icons.search, color: primaryGreen),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: limeAccent.withOpacity(0.2),
              ),
            ),
          ),
          const SizedBox(height: 24),
          
          // Categories section
          Text(
            'Categories',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: darkGreen,
            ),
          ),
          const SizedBox(height: 16),
          
          // Category cards - Fixed height to prevent overflow
          SizedBox(
            height: 140, // Increased height slightly
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                _buildCategoryCard(
                  'Turf',
                  'Book sports grounds',
                  Icons.sports_soccer,
                  primaryGreen,
                  [primaryGreen, darkGreen.withOpacity(0.8)],
                ),
                _buildCategoryCard(
                  'VR Games',
                  'Immersive experiences',
                  Icons.videogame_asset,
                  primaryGreen,
                  [primaryGreen.withOpacity(0.8), darkGreen],
                ),
                _buildCategoryCard(
                  'Indoor Games',
                  'Fun activities inside',
                  Icons.sports_esports,
                  primaryGreen,
                  [primaryGreen, primaryGreen.withOpacity(0.7)],
                ),
                _buildCategoryCard(
                  'Trampoline',  
                  'Jump & have fun',
                  Icons.flight_takeoff,
                  primaryGreen,
                  [darkGreen, primaryGreen],
                ),
                _buildCategoryCard(
                  'Gaming Park',
                  'Console & PC games',
                  Icons.gamepad,
                  primaryGreen,
                  [primaryGreen.withOpacity(0.9), darkGreen.withOpacity(0.7)],
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          
          // Featured section
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Featured Venues',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: darkGreen,
                ),
              ),
              TextButton(
                onPressed: () {
                  // Navigate to all venues
                },
                style: TextButton.styleFrom(
                  foregroundColor: primaryGreen,
                ),
                child: const Text('See All'),
              ),
            ],
          ),
          const SizedBox(height: 8),
          
          // Featured venues cards
          _buildFeaturedVenue(
            'Green Field Turf',
            'Football, Cricket, Tennis',
            '4.8',
            'assets/turf.jpg',
          ),
          const SizedBox(height: 16),
          _buildFeaturedVenue(
            'VR World',
            'Racing, Adventure, Shooting',
            '4.6',
            'assets/vr.jpg',
          ),
          const SizedBox(height: 16),
          _buildFeaturedVenue(
            'Game Zone',
            'Bowling, Pool, Arcade',
            '4.5',
            'assets/indoor.jpg',
          ),
          const SizedBox(height: 16),
          _buildFeaturedVenue(
            'Bounce Factory',
            'Trampolines, Foam Pit',
            '4.7',
            'assets/trampoline.jpg',
          ),
          const SizedBox(height: 16),
          _buildFeaturedVenue(
            'Gamer\'s Paradise',
            'PC Gaming, Console Zone, VR',
            '4.9',
            'assets/gaming.jpg',
          ),
          
          // Promotions
          const SizedBox(height: 24),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [primaryGreen, darkGreen],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: darkGreen.withOpacity(0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Special Offer',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Get 20% off on your first booking',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: () {
                    // Apply offer
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: limeAccent,
                    foregroundColor: darkGreen,
                    elevation: 4,
                    shadowColor: limeAccent.withOpacity(0.5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'Book Now',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Add extra padding at the bottom to ensure no overflow
          const SizedBox(height: 16),
        ],
      ),
    );
  }
  
  // Helper method to get venue type based on name
  String _getVenueType(String venueName) {
    // Map venue names to their types
    switch (venueName) {
      case 'Green Field Turf':
        return 'Turf';
      case 'VR World':
        return 'VR Games';
      case 'Game Zone':
        return 'Indoor Games';
      case 'Bounce Factory':
        return 'Trampoline';
      case 'Gamer\'s Paradise':
        return 'Gaming Park';
      default:
        return 'Venue';
    }
  }

  // Helper method to get available activities for each venue
  List<String> _getActivitiesForVenue(String venueName) {
    // Map venue names to their available activities
    switch (venueName) {
      case 'Green Field Turf':
        return ['Football', 'Cricket', 'Tennis'];
      case 'VR World':
        return ['Racing Games', 'Adventure Games', 'Shooting Games'];
      case 'Game Zone':
        return ['Bowling', 'Pool', 'Arcade Games'];
      case 'Bounce Factory':
        return ['Open Jump', 'Foam Pit', 'Trampoline Dodgeball'];
      case 'Gamer\'s Paradise':
        return ['PC Gaming', 'Console Gaming', 'VR Experience'];
      default:
        return ['General Play'];
    }
  }
  
  // Placeholder for Explore tab
  Widget _buildExploreContent() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.explore,
            size: 100,
            color: primaryGreen.withOpacity(0.5),
          ),
          const SizedBox(height: 16),
          Text(
            'Explore',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: darkGreen,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Discover new play experiences',
            style: TextStyle(
              fontSize: 16,
              color: primaryGreen.withOpacity(0.7),
            ),
          ),
        ],
      ),
    );
  }
  
  // Placeholder for Settings tab
  Widget _buildSettingsContent() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.settings,
            size: 100,
            color: primaryGreen.withOpacity(0.5),
          ),
          const SizedBox(height: 16),
          Text(
            'Settings',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: darkGreen,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Manage your account preferences',
            style: TextStyle(
              fontSize: 16,
              color: primaryGreen.withOpacity(0.7),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryCard(String title, String subtitle, IconData icon, Color color, List<Color> gradientColors) {
    return Container(
      width: 150,
      margin: const EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: gradientColors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            // Navigate to category
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CategoryScreen(category: title),
              ),
            );
          },
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, color: Colors.white, size: 32),
                const SizedBox(height: 12),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  maxLines: 1, // Limit to 1 line
                  overflow: TextOverflow.ellipsis, // Add ellipsis if overflows
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white.withOpacity(0.8),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFeaturedVenue(String name, String activities, String rating, String imageAsset) {
    return GestureDetector(
      onTap: () {
        // Navigate to venue details
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => VenueDetailScreen(venueName: name),
          ),
        );
      },
      child: Container(
        width: double.infinity,
        height: 120,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, limeAccent.withOpacity(0.1)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            // Image - fixed by using Image.asset
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                bottomLeft: Radius.circular(16),
              ),
              child: Image.asset(
                imageAsset,
                width: 120,
                height: 120,
                fit: BoxFit.cover,
                // Add error handling to show placeholder if image fails to load
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: 120,
                    height: 120,
                    color: limeAccent.withOpacity(0.2),
                    child: Center(
                      child: Icon(Icons.image, size: 40, color: primaryGreen),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: darkGreen,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    activities,
                    style: TextStyle(
                      color: primaryGreen.withOpacity(0.7),
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.star,
                            color: Colors.amber,
                            size: 18,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            rating,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: darkGreen,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [primaryGreen, darkGreen],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: primaryGreen.withOpacity(0.3),
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: TextButton(
                          onPressed: () {
                            // Updated: Navigate to VenueBookingScreen instead
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => VenueBookingScreen(
                                  venueName: name,
                                  venueType: _getVenueType(name),
                                  availableActivities: _getActivitiesForVenue(name),
                                  rating: double.parse(rating),
                                ),
                              ),
                            );
                          },
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            minimumSize: const Size(60, 36),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            backgroundColor: Colors.transparent,
                          ),
                          child: const Text(
                            'Book',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
          ],
        ),
      ),
    );
  }
}

// Placeholder screens for navigation
class CategoryScreen extends StatelessWidget {
  final String category;
  const CategoryScreen({Key? key, required this.category}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(category),
        backgroundColor: const Color(0xFF007F5A),
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Text('$category Category Screen'),
      ),
    );
  }
}

class VenueDetailScreen extends StatelessWidget {
  final String venueName;
  const VenueDetailScreen({Key? key, required this.venueName}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(venueName),
        backgroundColor: const Color(0xFF007F5A),
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Text('Venue Details for $venueName'),
      ),
    );
  }
}

class BookingScreen extends StatelessWidget {
  final String venueName;
  const BookingScreen({Key? key, required this.venueName}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Book $venueName'),
        backgroundColor: const Color(0xFF007F5A),
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Text('Booking Screen for $venueName'),
      ),
    );
  }
}