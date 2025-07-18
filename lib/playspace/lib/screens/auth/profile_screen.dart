import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // Define our custom color scheme - matching the home screen
  final Color primaryGreen = const Color(0xFF007F5A);
  final Color limeAccent = const Color(0xFFC8FA60);
  final Color backgroundColor = const Color(0xFFFFFFFF);
  final Color darkGreen = const Color(0xFF094531);
  
  // User data
  final String userName = "Siva Sundar";
  final String userEmail = "sivasundar5944@gmail.com";
  final String phoneNumber = "(+91) 9361100724";
  final String memberSince = "April 2023";
  final String membershipType = "Premium Pro";
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
        title: Text(
          'My Profile',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: darkGreen,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: primaryGreen),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.settings, color: primaryGreen),
            onPressed: () {
              // Navigate to settings screen
              Navigator.pushNamed(context, '/settings');
            },
          ),
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            // Profile header with avatar
            _buildProfileHeader(),
            const SizedBox(height: 24),
            
            // Stats section
            _buildStatsSection(),
            const SizedBox(height: 24),
            
            // Personal Information section
            _buildPersonalInfoSection(),
            const SizedBox(height: 24),

            // Membership section
            _buildMembershipSection(),
            const SizedBox(height: 24),
            
            // Bookings section
            _buildBookingsSection(),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
  
  Widget _buildProfileHeader() {
    return Column(
      children: [
        // Profile image with gradient border
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: [primaryGreen, limeAccent],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: primaryGreen.withOpacity(0.3),
                blurRadius: 10,
                spreadRadius: 2,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          padding: const EdgeInsets.all(3), // Border width
          child: CircleAvatar(
            radius: 55,
            backgroundColor: limeAccent.withOpacity(0.3),
            backgroundImage: const AssetImage('assets/profile.jpg'),
            // Removed the child with person icon
          ),
        ),
        const SizedBox(height: 16),
        
        // User name
        Text(
          userName,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: darkGreen,
          ),
        ),
        const SizedBox(height: 4),
        
        // User email
        Text(
          userEmail,
          style: TextStyle(
            fontSize: 16,
            color: primaryGreen.withOpacity(0.8),
          ),
        ),
        const SizedBox(height: 8),
        
        // Member badge
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: limeAccent,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Text(
            membershipType,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: darkGreen,
            ),
          ),
        ),
        const SizedBox(height: 16),
        
        // Edit profile button
        OutlinedButton.icon(
          onPressed: () => _editProfile(),
          style: OutlinedButton.styleFrom(
            foregroundColor: primaryGreen,
            side: BorderSide(color: primaryGreen),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          icon: Icon(Icons.edit, size: 18),
          label: const Text('Edit Profile'),
        ),
      ],
    );
  }
  
  Widget _buildStatsSection() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [primaryGreen.withOpacity(0.1), limeAccent.withOpacity(0.15)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildStatItem('12', 'Bookings'),
          _buildDivider(),
          _buildStatItem('3', 'Venues'),
          _buildDivider(),
          _buildStatItem('250', 'Points'),
        ],
      ),
    );
  }
  
  Widget _buildStatItem(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: darkGreen,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: primaryGreen,
          ),
        ),
      ],
    );
  }
  
  Widget _buildDivider() {
    return Container(
      height: 40,
      width: 1,
      color: primaryGreen.withOpacity(0.3),
    );
  }
  
  Widget _buildPersonalInfoSection() {
    return _buildSectionCard(
      'Personal Information',
      Icons.person_outline,
      [
        _buildInfoRow(Icons.phone_outlined, 'Phone Number', phoneNumber),
        const Divider(height: 1),
        _buildInfoRow(Icons.email_outlined, 'Email Address', userEmail),
        const Divider(height: 1),
        _buildInfoRow(Icons.calendar_today_outlined, 'Member Since', memberSince),
      ],
    );
  }
  
  Widget _buildMembershipSection() {
    return _buildSectionCard(
      'Membership Details',
      Icons.card_membership,
      [
        _buildInfoRow(Icons.star_outline, 'Membership Type', membershipType),
        const Divider(height: 1),
        _buildInfoRow(Icons.loyalty_outlined, 'Loyalty Points', '250 points'),
        const Divider(height: 1),
        _buildInfoRow(Icons.calendar_today_outlined, 'Next Renewal', 'April 15, 2026'),
      ],
    );
  }
  
  Widget _buildBookingsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8.0, bottom: 12.0),
          child: Text(
            'Your Bookings',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: darkGreen,
            ),
          ),
        ),
        Row(
          children: [
            Expanded(
              child: _buildBookingButton(
                'Upcoming',
                Icons.calendar_today,
                () => _navigateToBookings('upcoming'),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildBookingButton(
                'Past',
                Icons.history,
                () => _navigateToBookings('past'),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _buildBookingButton(
                'Saved Venues',
                Icons.favorite_border,
                () => _navigateToBookings('saved'),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildBookingButton(
                'Book Now',
                Icons.add_circle_outline,
                () => _navigateToBookings('new'),
              ),
            ),
          ],
        ),
      ],
    );
  }
  
  Widget _buildSectionCard(String title, IconData icon, List<Widget> children) {
    return Card(
      elevation: 2,
      shadowColor: Colors.grey.withOpacity(0.3),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: limeAccent.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    icon,
                    color: primaryGreen,
                    size: 22,
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: darkGreen,
                  ),
                ),
              ],
            ),
          ),
          ...children,
        ],
      ),
    );
  }
  
  Widget _buildInfoRow(IconData icon, String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: Row(
        children: [
          Icon(
            icon,
            size: 20,
            color: primaryGreen,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: darkGreen,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildBookingButton(String title, IconData icon, VoidCallback onTap) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.15),
            blurRadius: 8,
            spreadRadius: 1,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  color: primaryGreen,
                  size: 28,
                ),
                const SizedBox(height: 8),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: darkGreen,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  
  void _editProfile() {
    // Navigate to profile edit screen
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Navigate to: Edit Profile'),
        backgroundColor: primaryGreen,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
  
  void _navigateToBookings(String type) {
    // Navigate to bookings of specific type
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Navigate to: $type bookings'),
        backgroundColor: primaryGreen,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}