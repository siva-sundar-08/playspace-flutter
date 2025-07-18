import 'package:flutter/material.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({Key? key}) : super(key: key);

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  // Define our custom color scheme (matching the home screen)
  final Color primaryGreen = const Color(0xFF007F5A);
  final Color limeAccent = const Color(0xFFC8FA60);
  final Color backgroundColor = const Color(0xFFFFFFFF);
  final Color darkGreen = const Color(0xFF094531);

  // Tabs for the explore section
  final List<String> _exploreTabs = [
    'All',
    'Trending',
    'New',
    'Popular',
    'Nearby'
  ];
  int _selectedTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
        title: Text(
          'Explore',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: darkGreen,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list, color: primaryGreen),
            onPressed: () {
              // Show filter options
              _showFilterModal(context);
            },
          ),
          IconButton(
            icon: Icon(Icons.search, color: primaryGreen),
            onPressed: () {
              // Show search modal
              _showSearchModal(context);
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Tab Section
          Container(
            height: 50,
            margin: const EdgeInsets.symmetric(vertical: 16),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _exploreTabs.length,
              itemBuilder: (context, index) {
                bool isSelected = _selectedTabIndex == index;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedTabIndex = index;
                    });
                  },
                  child: Container(
                    margin: const EdgeInsets.only(right: 12),
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      gradient: isSelected
                          ? LinearGradient(
                              colors: [primaryGreen, darkGreen],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            )
                          : null,
                      color: isSelected ? null : limeAccent.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Center(
                      child: Text(
                        _exploreTabs[index],
                        style: TextStyle(
                          color: isSelected ? Colors.white : primaryGreen,
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          
          // Content Section
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                // Recommended section
                _buildSectionHeader('Recommended For You', onTap: () {}),
                const SizedBox(height: 16),
                SizedBox(
                  height: 280,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      _buildRecommendedCard(
                        'Premium Sports Arena',
                        'Multiple Sports Facilities',
                        4.9,
                        'assets/premium_sports1.jpg',
                        ['Football', 'Tennis', 'Basketball'],
                        const Color(0xFF1E88E5),
                        const Color(0xFF0D47A1),
                      ),
                      _buildRecommendedCard(
                        'Adventure VR Park',
                        'Next-gen Gaming Experience',
                        4.8,
                        'assets/vr_park.jpg',
                        ['Adventure', 'Shooting', 'Racing'],
                        const Color(0xFF6A1B9A),
                        const Color(0xFF4A148C),
                      ),
                      _buildRecommendedCard(
                        'Elite Gaming Hub',
                        'Competitive Gaming Venue',
                        4.7,
                        'assets/gaming_hub.jpg',
                        ['PC Gaming', 'Tournaments', 'Console'],
                        const Color(0xFF00897B),
                        const Color(0xFF004D40),
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 24),
                
                // Trending Experiences section
                _buildSectionHeader('Trending Experiences', onTap: () {}),
                const SizedBox(height: 16),
                _buildTrendingExperience(
                  'Laser Tag Arena',
                  'Team-based laser combat gaming',
                  4.6,
                  '2.5 km',
                  'assets/laser_tag.jpg',
                  [primaryGreen, darkGreen],
                ),
                const SizedBox(height: 16),
                _buildTrendingExperience(
                  'Bowling Kingdom',
                  'Premium bowling lanes with arcade',
                  4.5,
                  '3.8 km',
                  'assets/bowling.jpg',
                  [const Color(0xFFE65100), const Color(0xFFBF360C)],
                ),
                const SizedBox(height: 16),
                
                // Special Events section
                _buildSectionHeader('Special Events', onTap: () {}),
                const SizedBox(height: 16),
                Container(
                  height: 200,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      _buildEventCard(
                        'Gaming Tournament',
                        'This Weekend',
                        'Prizes worth ₹50,000',
                        'assets/tournament.jpg',
                        [const Color(0xFFD81B60), const Color(0xFF880E4F)],
                      ),
                      _buildEventCard(
                        'Virtual Reality Fest',
                        'Next Week',
                        'Experience latest VR games',
                        'assets/vr_fest.jpg',
                        [const Color(0xFF3949AB), const Color(0xFF1A237E)],
                      ),
                      _buildEventCard(
                        'Sports Day',
                        'Coming Soon',
                        'Multi-sport competition',
                        'assets/sports_day.jpg',
                        [const Color(0xFF00ACC1), const Color(0xFF006064)],
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 24),
                
                // Categories for Quick Access
                _buildSectionHeader('Categories', onTap: () {}),
                const SizedBox(height: 16),
                
                GridView.count(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  crossAxisCount: 2,
                  childAspectRatio: 1.5,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  children: [
                    _buildCategoryTile(
                      'Indoor Games',
                      Icons.sports_esports,
                      [primaryGreen, darkGreen],
                    ),
                    _buildCategoryTile(
                      'Outdoor Sports',
                      Icons.sports_soccer,
                      [const Color(0xFF43A047), const Color(0xFF1B5E20)],
                    ),
                    _buildCategoryTile(
                      'VR Experiences',
                      Icons.vrpano,
                      [const Color(0xFF5E35B1), const Color(0xFF311B92)],
                    ),
                    _buildCategoryTile(
                      'Adventure Parks',
                      Icons.landscape,
                      [const Color(0xFFEF6C00), const Color(0xFFE65100)],
                    ),
                  ],
                ),
                
                const SizedBox(height: 24),
                
                // Discover by Location
                // In the _ExploreScreenState class, update the Discover by Location section:

// Discover by Location
_buildSectionHeader('Discover by Location', onTap: () {}),
const SizedBox(height: 16),
Container(
  height: 140, // Reduced height slightly
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(16),
    gradient: LinearGradient(
      colors: [primaryGreen.withOpacity(0.8), darkGreen],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    boxShadow: [
      BoxShadow(
        color: darkGreen.withOpacity(0.3),
        blurRadius: 8,
        offset: const Offset(0, 3),
      ),
    ],
  ),
  child: Material(
    color: Colors.transparent,
    child: InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: () {
        // Navigate to map view
      },
      child: Padding(
        padding: const EdgeInsets.all(12), // Reduced padding
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Icon(
                  Icons.map,
                  color: Colors.white,
                  size: 30, // Reduced icon size
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Find Venues Nearby',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16, // Reduced font size
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4), // Reduced spacing
                      Text(
                        'Discover play spaces around your location',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.9),
                          fontSize: 12, // Reduced font size
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12), // Reduced spacing
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12, // Reduced padding
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: limeAccent,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  'Open Map',
                  style: TextStyle(
                    color: darkGreen,
                    fontWeight: FontWeight.bold,
                    fontSize: 12, // Reduced font size
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  ),
),
                
                // Extra padding at bottom
                const SizedBox(height: 24),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title, {required Function onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: darkGreen,
          ),
        ),
        TextButton(
          onPressed: () => onTap(),
          style: TextButton.styleFrom(
            foregroundColor: primaryGreen,
          ),
          child: const Text('See All'),
        ),
      ],
    );
  }

  Widget _buildRecommendedCard(
    String name,
    String description,
    double rating,
    String imageAsset,
    List<String> tags,
    Color startColor,
    Color endColor,
  ) {
    return Container(
      width: 220,
      margin: const EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Main card with image and gradient overlay
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Container(
              height: 280,
              width: 220,
              child: Stack(
                children: [
                  // Image
                  Positioned.fill(
                    child: Image.asset(
                      imageAsset,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: primaryGreen.withOpacity(0.2),
                          child: Center(
                            child: Icon(Icons.image, size: 40, color: primaryGreen),
                          ),
                        );
                      },
                    ),
                  ),
                  // Gradient overlay
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black.withOpacity(0.7),
                          ],
                          stops: const [0.6, 1.0],
                        ),
                      ),
                    ),
                  ),
                  // Content
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Tags
                          SizedBox(
                            height: 26,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: tags.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  margin: EdgeInsets.only(right: 8),
                                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [startColor, endColor],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    ),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(
                                    tags[index],
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          const SizedBox(height: 8),
                          // Name
                          Text(
                            name,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4),
                          // Description
                          Text(
                            description,
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.8),
                              fontSize: 12,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 8),
                          // Rating
                          Row(
                            children: [
                              const Icon(
                                Icons.star,
                                color: Colors.amber,
                                size: 18,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                rating.toString(),
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              const Spacer(),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: limeAccent,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  'Book',
                                  style: TextStyle(
                                    color: darkGreen,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTrendingExperience(
    String name,
    String description,
    double rating,
    String distance,
    String imageAsset,
    List<Color> gradientColors,
  ) {
    return Container(
      width: double.infinity,
      height: 120,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            // Navigate to details
          },
          borderRadius: BorderRadius.circular(16),
          child: Ink(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.white, limeAccent.withOpacity(0.1)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                // Image
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
                      const SizedBox(height: 4),
                      Text(
                        description,
                        style: TextStyle(
                          color: primaryGreen.withOpacity(0.7),
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.star,
                                color: Colors.amber,
                                size: 18,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                rating.toString(),
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: darkGreen,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(width: 16),
                          Icon(
                            Icons.location_on,
                            size: 16,
                            color: primaryGreen,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            distance,
                            style: TextStyle(
                              color: primaryGreen,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 38,
                  width: 80,
                  margin: const EdgeInsets.only(right: 16),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: gradientColors,
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        // Book venue
                      },
                      borderRadius: BorderRadius.circular(20),
                      child: const Center(
                        child: Text(
                          'Book',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEventCard(
    String title,
    String time,
    String description,
    String imageAsset,
    List<Color> gradientColors,
  ) {
    return Container(
      width: 280,
      margin: const EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Background image
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.asset(
              imageAsset,
              width: 280,
              height: 200,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: 280,
                  height: 200,
                  color: primaryGreen.withOpacity(0.2),
                  child: Center(
                    child: Icon(Icons.image, size: 40, color: primaryGreen),
                  ),
                );
              },
            ),
          ),
          // Gradient overlay
          Container(
            width: 280,
            height: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  gradientColors[0].withOpacity(0.7),
                  gradientColors[1].withOpacity(0.9),
                ],
                stops: const [0.4, 0.7, 1.0],
              ),
            ),
          ),
          // Content
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Time badge
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: limeAccent,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      time,
                      style: TextStyle(
                        color: darkGreen,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Title
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  // Description
                  Text(
                    description,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.9),
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Join button
          Positioned(
            top: 16,
            right: 16,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Text(
                'Join',
                style: TextStyle(
                  color: gradientColors[0],
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryTile(
    String title,
    IconData icon,
    List<Color> gradientColors,
  ) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
        gradient: LinearGradient(
          colors: gradientColors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            // Navigate to category
          },
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  size: 32,
                  color: Colors.white,
                ),
                const SizedBox(height: 8),
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showFilterModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Filter By',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: darkGreen,
                ),
              ),
              const SizedBox(height: 20),
              // Filter options would go here
              ListTile(
                leading: Icon(Icons.sort, color: primaryGreen),
                title: Text('Sort by'),
                trailing: Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(Icons.attach_money, color: primaryGreen),
                title: Text('Price Range'),
                trailing: Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(Icons.star, color: primaryGreen),
                title: Text('Rating'),
                trailing: Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(Icons.location_on, color: primaryGreen),
                title: Text('Distance'),
                trailing: Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {},
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OutlinedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: primaryGreen),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    ),
                    child: Text(
                      'Reset',
                      style: TextStyle(color: primaryGreen),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryGreen,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    ),
                    child: const Text('Apply'),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  void _showSearchModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.9,
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  Text(
                    'Search',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: darkGreen,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Search for activities, venues, events...',
                  prefixIcon: Icon(Icons.search, color: primaryGreen),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: primaryGreen.withOpacity(0.3)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: primaryGreen.withOpacity(0.3)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: primaryGreen),
                  ),
                  filled: true,
                  fillColor: limeAccent.withOpacity(0.1),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Recent Searches',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: darkGreen,
                ),
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  _buildSearchChip('Football Ground'),
                  _buildSearchChip('Virtual Reality'),
                  _buildSearchChip('Table Tennis'),
                  _buildSearchChip('Gaming Arena'),
                ],
              ),
              const SizedBox(height: 24),
              Text(
                'Popular Searches',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: darkGreen,
                ),
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  _buildSearchChip('Bowling'),
                  _buildSearchChip('Cricket'),
                  _buildSearchChip('Laser Tag'),
                  _buildSearchChip('VR Experience'),
                  _buildSearchChip('Go Karting'),
                  _buildSearchChip('Arcade Games'),
                ],
              ),
              const SizedBox(height: 24),
              Expanded(
                child: ListView(
                  children: [
                    ListTile(
                      leading: Icon(Icons.sports_esports, color: primaryGreen),
                      title: Text('Elite Gaming Hub'),
                      subtitle: Text('3.5 km away'),
                      trailing: Icon(Icons.arrow_forward_ios, size: 16),
                      onTap: () {},
                    ),
                    Divider(),
                    ListTile(
                      leading: Icon(Icons.sports_soccer, color: primaryGreen),
                      title: Text('Premium Sports Arena'),
                      subtitle: Text('2.1 km away'),
                      trailing: Icon(Icons.arrow_forward_ios, size: 16),
                      onTap: () {},
                    ),
                    Divider(),
                    ListTile(
                      leading: Icon(Icons.sports_cricket, color: primaryGreen),
                      title: Text('Cricket Stadium'),
                      subtitle: Text('5.7 km away'),
                      trailing: Icon(Icons.arrow_forward_ios, size: 16),
                      onTap: () {},
                    ),
                    Divider(),
                    ListTile(
                      leading: Icon(Icons.vrpano, color: primaryGreen),
                      title: Text('Adventure VR Park'),
                      subtitle: Text('1.8 km away'),
                      trailing: Icon(Icons.arrow_forward_ios, size: 16),
                      onTap: () {},
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSearchChip(String label) {
    return Chip(
      label: Text(label),
      backgroundColor: limeAccent.withOpacity(0.2),
      labelStyle: TextStyle(color: primaryGreen),
      deleteIcon: Icon(Icons.close, size: 16, color: primaryGreen),
      onDeleted: () {
        // Remove from recent searches
      },
    );
  }
}