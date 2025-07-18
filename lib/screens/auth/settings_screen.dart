import 'package:flutter/material.dart';
import 'login_screen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  // Define our custom color scheme
  final Color primaryGreen = const Color(0xFF007F5A);
  final Color limeAccent = const Color(0xFFC8FA60);
  final Color backgroundColor = const Color(0xFFFFFFFF);
  final Color darkGreen = const Color(0xFF094531);

  // Settings state variables
  bool _notificationsEnabled = true;
  bool _darkModeEnabled = false;
  bool _locationEnabled = true;
  double _radiusValue = 10.0;
  String _selectedLanguage = 'English';
  String _selectedCurrency = 'USD';
  
  // List of available languages and currencies
  final List<String> _languages = ['English', 'Hindi', 'Spanish', 'French', 'German'];
  final List<String> _currencies = ['USD', 'EUR', 'GBP', 'INR', 'JPY'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
        title: Text(
          'Settings',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: darkGreen,
          ),
        ),
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            // Account Settings
            _buildSectionHeader('Account Settings'),
            _buildSettingCard(
              icon: Icons.person_outline,
              title: 'Personal Information',
              subtitle: 'Update your profile details',
              onTap: () {
                // Navigate to profile edit screen
              },
            ),
            _buildSettingCard(
              icon: Icons.lock_outline,
              title: 'Change Password',
              subtitle: 'Update your security credentials',
              onTap: () {
                // Navigate to password change screen
              },
            ),
            _buildSettingCard(
              icon: Icons.payment_outlined,
              title: 'Payment Methods',
              subtitle: 'Manage your payment options',
              onTap: () {
                // Navigate to payment methods screen
              },
            ),
            
            const SizedBox(height: 24),
            
            // App Settings
            _buildSectionHeader('App Settings'),
            _buildSwitchSettingCard(
              icon: Icons.notifications_outlined,
              title: 'Notifications',
              subtitle: 'Enable push notifications',
              value: _notificationsEnabled,
              onChanged: (value) {
                setState(() {
                  _notificationsEnabled = value;
                });
              },
            ),
            _buildSwitchSettingCard(
              icon: Icons.dark_mode_outlined,
              title: 'Dark Mode',
              subtitle: 'Toggle app theme',
              value: _darkModeEnabled,
              onChanged: (value) {
                setState(() {
                  _darkModeEnabled = value;
                });
              },
            ),
            _buildSwitchSettingCard(
              icon: Icons.location_on_outlined,
              title: 'Location Services',
              subtitle: 'Use location for better recommendations',
              value: _locationEnabled,
              onChanged: (value) {
                setState(() {
                  _locationEnabled = value;
                });
              },
            ),
            
            // Search radius slider
            _buildSliderSettingCard(
              icon: Icons.radar_outlined,
              title: 'Search Radius',
              subtitle: '${_radiusValue.toInt()} km',
              value: _radiusValue,
              min: 1.0,
              max: 50.0,
              onChanged: (value) {
                setState(() {
                  _radiusValue = value;
                });
              },
            ),
            
            // Dropdown settings
            _buildDropdownSettingCard(
              icon: Icons.language_outlined,
              title: 'Language',
              value: _selectedLanguage,
              items: _languages,
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    _selectedLanguage = value;
                  });
                }
              },
            ),
            _buildDropdownSettingCard(
              icon: Icons.attach_money_outlined,
              title: 'Currency',
              value: _selectedCurrency,
              items: _currencies,
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    _selectedCurrency = value;
                  });
                }
              },
            ),
            
            const SizedBox(height: 24),
            
            // Support Section
            _buildSectionHeader('Support'),
            _buildSettingCard(
              icon: Icons.help_outline,
              title: 'Help Center',
              subtitle: 'Get help with your bookings',
              onTap: () {
                // Navigate to help center
              },
            ),
            _buildSettingCard(
              icon: Icons.phone_outlined,
              title: 'Contact Us',
              subtitle: 'Get in touch with our support team',
              onTap: () {
                // Navigate to contact us screen
              },
            ),
            _buildSettingCard(
              icon: Icons.policy_outlined,
              title: 'Privacy Policy',
              subtitle: 'Read our privacy policy',
              onTap: () {
                // Navigate to privacy policy screen
              },
            ),
            _buildSettingCard(
              icon: Icons.description_outlined,
              title: 'Terms of Service',
              subtitle: 'Read our terms of service',
              onTap: () {
                // Navigate to terms of service screen
              },
            ),
            
            const SizedBox(height: 24),
            
            // About Section
            _buildSectionHeader('About'),
            _buildSettingCard(
              icon: Icons.info_outline,
              title: 'About PlaySpace',
              subtitle: 'Learn more about our app',
              onTap: () {
                // Navigate to about screen
              },
            ),
            _buildSettingCard(
              icon: Icons.update,
              title: 'Version',
              subtitle: '1.0.0',
              onTap: null,
            ),
            
            const SizedBox(height: 24),
            
            // Logout Button
            _buildLogoutButton(),
            
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
  
  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: darkGreen,
        ),
      ),
    );
  }
  
  Widget _buildSettingCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required Function()? onTap,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      shadowColor: Colors.black.withOpacity(0.1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Icon(
          icon,
          color: primaryGreen,
        ),
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: darkGreen,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
          ),
        ),
        trailing: onTap != null
            ? Icon(
                Icons.chevron_right,
                color: primaryGreen,
              )
            : null,
        onTap: onTap,
      ),
    );
  }
  
  Widget _buildSwitchSettingCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool value,
    required Function(bool) onChanged,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      shadowColor: Colors.black.withOpacity(0.1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: SwitchListTile(
        secondary: Icon(
          icon,
          color: primaryGreen,
        ),
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: darkGreen,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
          ),
        ),
        value: value,
        activeColor: primaryGreen,
        activeTrackColor: limeAccent,
        onChanged: onChanged,
      ),
    );
  }
  
  Widget _buildSliderSettingCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required double value,
    required double min,
    required double max,
    required Function(double) onChanged,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      shadowColor: Colors.black.withOpacity(0.1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  icon,
                  color: primaryGreen,
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: darkGreen,
                      ),
                    ),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Slider(
              value: value,
              min: min,
              max: max,
              divisions: max.toInt(),
              activeColor: primaryGreen,
              inactiveColor: limeAccent.withOpacity(0.3),
              thumbColor: limeAccent,
              onChanged: onChanged,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${min.toInt()} km',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
                Text(
                  '${max.toInt()} km',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildDropdownSettingCard({
    required IconData icon,
    required String title,
    required String value,
    required List<String> items,
    required Function(String?) onChanged,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      shadowColor: Colors.black.withOpacity(0.1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Icon(
              icon,
              color: primaryGreen,
            ),
            const SizedBox(width: 16),
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: darkGreen,
              ),
            ),
            const Spacer(),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                border: Border.all(color: primaryGreen.withOpacity(0.3)),
                borderRadius: BorderRadius.circular(8),
              ),
              child: DropdownButton<String>(
                value: value,
                icon: Icon(Icons.arrow_drop_down, color: primaryGreen),
                elevation: 16,
                style: TextStyle(color: darkGreen),
                underline: Container(height: 0),
                onChanged: onChanged,
                items: items.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildLogoutButton() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.red.shade400, Colors.red.shade700],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.red.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: TextButton.icon(
        onPressed: () {
          // Show confirmation dialog
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Logout'),
              content: const Text('Are you sure you want to logout?'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    // Navigate to login screen
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginScreen(),
                      ),
                      (route) => false,
                    );
                  },
                  child: const Text('Logout'),
                ),
              ],
            ),
          );
        },
        icon: const Icon(
          Icons.logout,
          color: Colors.white,
        ),
        label: const Text(
          'LOGOUT',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        style: ButtonStyle(
          padding: MaterialStateProperty.all(
            const EdgeInsets.symmetric(vertical: 16),
          ),
          backgroundColor: MaterialStateProperty.all(Colors.transparent),
        ),
      ),
    );
  }
}