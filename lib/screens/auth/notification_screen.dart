import 'package:flutter/material.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  // Define our custom color scheme to match the home screen
  final Color primaryGreen = const Color(0xFF007F5A);
  final Color limeAccent = const Color(0xFFC8FA60);
  final Color backgroundColor = const Color(0xFFFFFFFF);
  final Color darkGreen = const Color(0xFF094531);

  // Sample notification data
  final List<NotificationItem> _notifications = [
    NotificationItem(
      title: 'Booking Confirmed',
      content: 'Your booking at Green Field Turf for tomorrow at 5:00 PM is confirmed.',
      time: 'Just now',
      isRead: false,
      icon: Icons.check_circle,
      type: NotificationType.booking,
    ),
    NotificationItem(
      title: 'Payment Successful',
      content: 'Payment of ₹1,200 for VR World has been processed successfully.',
      time: '10 minutes ago',
      isRead: false,
      icon: Icons.payment,
      type: NotificationType.payment,
    ),
    NotificationItem(
      title: 'New Offer Available',
      content: 'Get 15% off on all Indoor Games bookings this weekend!',
      time: '2 hours ago',
      isRead: true,
      icon: Icons.local_offer,
      type: NotificationType.offer,
    ),
    NotificationItem(
      title: 'Booking Reminder',
      content: 'Your session at Game Zone starts in 3 hours. Get ready for fun!',
      time: '5 hours ago',
      isRead: true,
      icon: Icons.access_time,
      type: NotificationType.reminder,
    ),
    NotificationItem(
      title: 'Review Request',
      content: 'How was your experience at Bounce Factory? Please leave a review.',
      time: '1 day ago',
      isRead: true,
      icon: Icons.star,
      type: NotificationType.review,
    ),
    NotificationItem(
      title: 'New Venue Added',
      content: 'Cricket Hub is now available for booking in your area.',
      time: '2 days ago',
      isRead: true,
      icon: Icons.sports_cricket,
      type: NotificationType.newVenue,
    ),
    NotificationItem(
      title: 'Price Drop Alert',
      content: 'Prices for Gaming Paradise have been reduced by 10% for weekday bookings.',
      time: '3 days ago',
      isRead: true,
      icon: Icons.trending_down,
      type: NotificationType.priceAlert,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
        title: Text(
          'Notifications',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: darkGreen,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: primaryGreen),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          TextButton(
            onPressed: () {
              // Mark all as read
              setState(() {
                for (var notification in _notifications) {
                  notification.isRead = true;
                }
              });
            },
            child: Text(
              'Mark all as read',
              style: TextStyle(color: primaryGreen),
            ),
          ),
        ],
      ),
      body: _notifications.isEmpty
          ? _buildEmptyState()
          : _buildNotificationsList(),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.notifications_off_outlined,
            size: 100,
            color: primaryGreen.withOpacity(0.5),
          ),
          const SizedBox(height: 16),
          Text(
            'No Notifications',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: darkGreen,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'You don\'t have any notifications at the moment',
            style: TextStyle(
              fontSize: 16,
              color: primaryGreen.withOpacity(0.7),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationsList() {
    return Column(
      children: [
        // Filter section
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildFilterChip('All', true),
                _buildFilterChip('Bookings', false),
                _buildFilterChip('Payments', false),
                _buildFilterChip('Offers', false),
                _buildFilterChip('Reminders', false),
              ],
            ),
          ),
        ),
        // Divider
        Divider(height: 1, color: Colors.grey.withOpacity(0.2)),
        // Notifications list
        Expanded(
          child: ListView.builder(
            itemCount: _notifications.length,
            itemBuilder: (context, index) {
              final notification = _notifications[index];
              return _buildNotificationItem(notification);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildFilterChip(String label, bool isSelected) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      child: FilterChip(
        selected: isSelected,
        label: Text(label),
        onSelected: (bool selected) {
          // Implement filter logic
        },
        backgroundColor: limeAccent.withOpacity(0.2),
        selectedColor: primaryGreen.withOpacity(0.2),
        checkmarkColor: primaryGreen,
        labelStyle: TextStyle(
          color: isSelected ? primaryGreen : darkGreen,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(
            color: isSelected ? primaryGreen : Colors.transparent,
            width: 1,
          ),
        ),
      ),
    );
  }

  Widget _buildNotificationItem(NotificationItem notification) {
    // Determine gradient colors based on notification type
    List<Color> gradientColors;
    switch (notification.type) {
      case NotificationType.booking:
        gradientColors = [primaryGreen.withOpacity(0.1), limeAccent.withOpacity(0.1)];
        break;
      case NotificationType.payment:
        gradientColors = [Colors.blue.withOpacity(0.1), primaryGreen.withOpacity(0.1)];
        break;
      case NotificationType.offer:
        gradientColors = [Colors.orange.withOpacity(0.1), limeAccent.withOpacity(0.1)];
        break;
      default:
        gradientColors = [Colors.grey.withOpacity(0.05), Colors.white];
    }

    // Special styling for unread notifications
    final bool isUnread = !notification.isRead;

    return Dismissible(
      key: Key(notification.title + notification.time),
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        // Remove the notification
        setState(() {
          _notifications.remove(notification);
        });
      },
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: isUnread 
                ? [primaryGreen.withOpacity(0.1), limeAccent.withOpacity(0.15)]
                : gradientColors,
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          leading: Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: _getIconGradient(notification.type),
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              notification.icon,
              color: Colors.white,
              size: 24,
            ),
          ),
          title: Text(
            notification.title,
            style: TextStyle(
              fontWeight: isUnread ? FontWeight.bold : FontWeight.w500,
              color: darkGreen,
              fontSize: 16,
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 4),
              Text(
                notification.content,
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                notification.time,
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                ),
              ),
            ],
          ),
          trailing: isUnread
              ? Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    color: primaryGreen,
                    shape: BoxShape.circle,
                  ),
                )
              : null,
          onTap: () {
            // Mark as read and navigate to detail if needed
            setState(() {
              notification.isRead = true;
            });
            
            // Handle different notification types
            switch (notification.type) {
              case NotificationType.booking:
                _showNotificationDetail(context, notification);
                break;
              case NotificationType.offer:
                // Navigate to offers page
                break;
              default:
                _showNotificationDetail(context, notification);
            }
          },
        ),
      ),
    );
  }

  List<Color> _getIconGradient(NotificationType type) {
    switch (type) {
      case NotificationType.booking:
        return [primaryGreen, darkGreen];
      case NotificationType.payment:
        return [Colors.blue, Colors.blue.shade800];
      case NotificationType.offer:
        return [Colors.orange, Colors.deepOrange];
      case NotificationType.reminder:
        return [Colors.purple, Colors.deepPurple];
      case NotificationType.review:
        return [Colors.amber, Colors.orange];
      case NotificationType.newVenue:
        return [Colors.teal, Colors.teal.shade800];
      case NotificationType.priceAlert:
        return [Colors.pink, Colors.pinkAccent];
    }
  }

  void _showNotificationDetail(BuildContext context, NotificationItem notification) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.7,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with gradient
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryGreen, darkGreen],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        notification.title,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close, color: Colors.white),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    notification.time,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.8),
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            // Content
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        notification.content,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 24),
                      // Additional content based on notification type
                      if (notification.type == NotificationType.booking)
                        _buildBookingDetails(),
                      if (notification.type == NotificationType.payment)
                        _buildPaymentDetails(),
                      if (notification.type == NotificationType.offer)
                        _buildOfferDetails(),
                    ],
                  ),
                ),
              ),
            ),
            // Action buttons
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        // Primary action based on notification type
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryGreen,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(_getActionButtonText(notification.type)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getActionButtonText(NotificationType type) {
    switch (type) {
      case NotificationType.booking:
        return 'View Booking';
      case NotificationType.payment:
        return 'View Receipt';
      case NotificationType.offer:
        return 'Claim Offer';
      case NotificationType.reminder:
        return 'View Details';
      case NotificationType.review:
        return 'Write Review';
      case NotificationType.newVenue:
        return 'Explore Venue';
      case NotificationType.priceAlert:
        return 'Book Now';
    }
  }

  Widget _buildBookingDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Booking Details',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: darkGreen,
          ),
        ),
        const SizedBox(height: 16),
        _buildDetailItem('Venue', 'Green Field Turf'),
        _buildDetailItem('Date', 'April 17, 2025'),
        _buildDetailItem('Time', '5:00 PM - 6:00 PM'),
        _buildDetailItem('Sport', 'Football'),
        _buildDetailItem('Booking ID', 'PS2504170023'),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: limeAccent.withOpacity(0.2),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              Icon(Icons.info_outline, color: primaryGreen),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Please arrive 15 minutes before your session to complete check-in formalities.',
                  style: TextStyle(
                    color: darkGreen,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPaymentDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Payment Details',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: darkGreen,
          ),
        ),
        const SizedBox(height: 16),
        _buildDetailItem('Amount Paid', '₹1,200'),
        _buildDetailItem('Payment Method', 'Credit Card (XXXX-XXXX-XXXX-4589)'),
        _buildDetailItem('Transaction ID', 'TXN4867251398'),
        _buildDetailItem('Payment Date', 'April 16, 2025'),
        _buildDetailItem('Status', 'Completed'),
      ],
    );
  }

  Widget _buildOfferDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Offer Details',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: darkGreen,
          ),
        ),
        const SizedBox(height: 16),
        _buildDetailItem('Discount', '15% off'),
        _buildDetailItem('Valid on', 'All Indoor Games'),
        _buildDetailItem('Valid until', 'April 21, 2025'),
        _buildDetailItem('Promo code', 'WEEKEND15'),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.orange.withOpacity(0.2), limeAccent.withOpacity(0.2)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.orange.withOpacity(0.3)),
          ),
          child: Row(
            children: [
              Icon(Icons.timer, color: Colors.orange),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Offer expires in 5 days. Book now to avail discount!',
                  style: TextStyle(
                    color: darkGreen,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDetailItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: TextStyle(
                color: Colors.grey.shade700,
                fontSize: 14,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                color: darkGreen,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Enum for notification types
enum NotificationType {
  booking,
  payment,
  offer,
  reminder,
  review,
  newVenue,
  priceAlert,
}

// Notification data model
class NotificationItem {
  final String title;
  final String content;
  final String time;
  bool isRead;
  final IconData icon;
  final NotificationType type;

  NotificationItem({
    required this.title,
    required this.content,
    required this.time,
    required this.isRead,
    required this.icon,
    required this.type,
  });
}