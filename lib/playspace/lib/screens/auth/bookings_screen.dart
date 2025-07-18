import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BookingsScreen extends StatefulWidget {
  const BookingsScreen({Key? key}) : super(key: key);

  @override
  State<BookingsScreen> createState() => _BookingsScreenState();
}

class _BookingsScreenState extends State<BookingsScreen> {
  // Define custom color scheme to match the app
  final Color primaryGreen = const Color(0xFF007F5A);
  final Color limeAccent = const Color(0xFFC8FA60);
  final Color backgroundColor = const Color(0xFFFFFFFF);
  final Color darkGreen = const Color(0xFF094531);
  
  // Track selected tab
  bool _showUpcoming = true;
  
  // Filter panel state
  bool _showFilters = false;
  
  // Selected filters
  Set<String> _selectedVenueTypes = {};
  Set<String> _selectedStatuses = {};
  
  // Sample booking data
  List<BookingData> _bookings = [];
  
  @override
  void initState() {
    super.initState();
    // Initialize with sample data
    _loadSampleBookings();
  }
  
  void _loadSampleBookings() {
    _bookings = [
      BookingData(
        id: "BK10023456",
        venueName: "Green Field Turf",
        venueType: "Turf",
        activity: "Football",
        date: DateTime(2025, 4, 20),
        startTime: "6:00 PM",
        endTime: "7:30 PM",
        status: "Confirmed",
        venueIcon: Icons.sports_soccer,
      ),
      BookingData(
        id: "BK10023457",
        venueName: "VR World",
        venueType: "VR Games",
        activity: "Racing Games",
        date: DateTime(2025, 4, 23),
        startTime: "3:00 PM",
        endTime: "4:00 PM",
        status: "Confirmed",
        venueIcon: Icons.videogame_asset,
      ),
      BookingData(
        id: "BK10023458",
        venueName: "VR World",
        venueType: "VR Games",
        activity: "Adventure Games",
        date: DateTime(2025, 3, 29),
        startTime: "2:00 PM",
        endTime: "3:30 PM",
        status: "Cancelled",
        venueIcon: Icons.videogame_asset,
      ),
      BookingData(
        id: "BK10023459",
        venueName: "Indoor Arena",
        venueType: "Indoor Games",
        activity: "Basketball",
        date: DateTime(2025, 3, 15),
        startTime: "4:00 PM",
        endTime: "5:30 PM",
        status: "Completed",
        venueIcon: Icons.sports_basketball,
      ),
    ];
  }
  
  // Toggle between upcoming and past bookings
  void _toggleView(bool showUpcoming) {
    setState(() {
      _showUpcoming = showUpcoming;
    });
  }
  
  // Toggle filter panel visibility
  void _toggleFilters() {
    setState(() {
      _showFilters = !_showFilters;
    });
  }
  
  // Apply selected filters
  void _applyFilters() {
    setState(() {
      _showFilters = false;
    });
  }
  
  // Clear all filters
  void _clearFilters() {
    setState(() {
      _selectedVenueTypes.clear();
      _selectedStatuses.clear();
    });
  }
  
  // Handle venue type filter selection
  void _toggleVenueTypeFilter(String type) {
    setState(() {
      if (_selectedVenueTypes.contains(type)) {
        _selectedVenueTypes.remove(type);
      } else {
        _selectedVenueTypes.add(type);
      }
    });
  }
  
  // Handle status filter selection
  void _toggleStatusFilter(String status) {
    setState(() {
      if (_selectedStatuses.contains(status)) {
        _selectedStatuses.remove(status);
      } else {
        _selectedStatuses.add(status);
      }
    });
  }
  
  // Reschedule booking
  void _rescheduleBooking(BookingData booking) {
    // Navigate to the VenueBookingScreen with pre-filled data for rescheduling
    // This is where you would connect to your venue_booking_screen.dart
    // For now, just show a snackbar
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Rescheduling ${booking.venueName}...'),
        backgroundColor: primaryGreen,
      ),
    );
  }
  
  // View booking details
  void _viewBookingDetails(BookingData booking) {
    // Show booking details in a modal
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _buildBookingDetailsModal(booking),
    );
  }
  
  // Handle "Book Again" action
  void _bookAgain(BookingData booking) {
    // Navigate to the VenueBookingScreen
    // This is where you would connect to your venue_booking_screen.dart
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Booking ${booking.venueName} again...'),
        backgroundColor: primaryGreen,
      ),
    );
  }
  
  // Leave a review for a booking
  void _leaveReview(BookingData booking) {
    // Show review dialog
    showDialog(
      context: context,
      builder: (context) => _buildReviewDialog(booking),
    );
  }
  
  // Generate filtered bookings list
  List<BookingData> _getFilteredBookings() {
    final now = DateTime.now();
    
    return _bookings.where((booking) {
      // Filter by upcoming/past
      final isUpcoming = booking.date.isAfter(now.subtract(const Duration(days: 1)));
      if (_showUpcoming != isUpcoming) {
        return false;
      }
      
      // Apply venue type filter if selected
      if (_selectedVenueTypes.isNotEmpty && !_selectedVenueTypes.contains(booking.venueType)) {
        return false;
      }
      
      // Apply status filter if selected
      if (_selectedStatuses.isNotEmpty && !_selectedStatuses.contains(booking.status)) {
        return false;
      }
      
      return true;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final filteredBookings = _getFilteredBookings();
    
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
        title: Text(
          'My Bookings',
          style: TextStyle(
            color: Color(0xFF094531),
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list, color: darkGreen),
            onPressed: _toggleFilters,
          ),
        ],
      ),
      body: Stack(
        children: [
          Column(
            children: [
              // Tab selector
              Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Colors.grey.shade200),
                  ),
                ),
                child: Row(
                  children: [
                    _buildTabButton('Upcoming', _showUpcoming, () => _toggleView(true)),
                    _buildTabButton('Past', !_showUpcoming, () => _toggleView(false)),
                  ],
                ),
              ),
              
              // Bookings list
              Expanded(
                child: filteredBookings.isEmpty
                    ? _buildEmptyState()
                    : ListView.builder(
                        itemCount: filteredBookings.length,
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        itemBuilder: (context, index) {
                          return _buildBookingCard(filteredBookings[index]);
                        },
                      ),
              ),
            ],
          ),
          
          // Filter panel
          if (_showFilters)
            _buildFilterPanel(),
        ],
      ),
    );
  }
  
  // Tab button widget
  Widget _buildTabButton(String title, bool isSelected, VoidCallback onTap) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: isSelected ? primaryGreen : Colors.transparent,
                width: 3,
              ),
            ),
          ),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: isSelected ? primaryGreen : Colors.grey,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
  
  // Booking card widget
  Widget _buildBookingCard(BookingData booking) {
    final isConfirmed = booking.status == "Confirmed";
    final isCancelled = booking.status == "Cancelled";
    
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Booking header with date and status
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: const Color(0xFFECF6F0),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  DateFormat('EEEE, MMM d, yyyy').format(booking.date),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF094531),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: isCancelled
                        ? Colors.red
                        : isConfirmed
                            ? const Color(0xFF4CAF50)
                            : Colors.orange,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Text(
                    booking.status,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          // Booking details
          Container(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                // Venue icon
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: const Color(0xFFECF6F0),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    booking.venueIcon,
                    color: primaryGreen,
                    size: 32,
                  ),
                ),
                const SizedBox(width: 16),
                
                // Venue details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        booking.venueName,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Color(0xFF094531),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        booking.activity,
                        style: TextStyle(
                          color: primaryGreen,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(
                            Icons.access_time,
                            size: 16,
                            color: Colors.grey.shade600,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '${booking.startTime} - ${booking.endTime}',
                            style: TextStyle(
                              color: Colors.grey.shade800,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          // Booking actions
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                // Action buttons based on booking status
                if (isConfirmed) ...[
                  // Reschedule button
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => _rescheduleBooking(booking),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: primaryGreen,
                        side: BorderSide(color: primaryGreen),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      child: const Text('Reschedule'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  
                  // View Details button
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => _viewBookingDetails(booking),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryGreen,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        elevation: 0,
                      ),
                      child: const Text('View Details'),
                    ),
                  ),
                ] else if (isCancelled) ...[
                  // Leave Review button
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => _leaveReview(booking),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: primaryGreen,
                        side: BorderSide(color: primaryGreen),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      child: const Text('Leave Review'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  
                  // Book Again button
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => _bookAgain(booking),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryGreen,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        elevation: 0,
                      ),
                      child: const Text('Book Again'),
                    ),
                  ),
                ] else ...[
                  // Past booking: Leave Review button
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => _leaveReview(booking),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: primaryGreen,
                        side: BorderSide(color: primaryGreen),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      child: const Text('Leave Review'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  
                  // Book Again button
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => _bookAgain(booking),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryGreen,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        elevation: 0,
                      ),
                      child: const Text('Book Again'),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  // Empty state widget
  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            _showUpcoming ? Icons.event_available : Icons.history,
            size: 80,
            color: Colors.grey.shade300,
          ),
          const SizedBox(height: 16),
          Text(
            _showUpcoming
                ? 'No upcoming bookings'
                : 'No past bookings',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            _showUpcoming
                ? 'Book a venue to see your upcoming reservations'
                : 'Your booking history will appear here',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }
  
  // Filter panel widget
  Widget _buildFilterPanel() {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.4,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Filter header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Filter Bookings',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF094531),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: _toggleFilters,
                    color: Colors.grey.shade600,
                  ),
                ],
              ),
            ),
            
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Venue Type filters
                    Text(
                      'Venue Type',
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
                        _buildFilterChip('Turf', 'Turf'),
                        _buildFilterChip('VR Games', 'VR Games'),
                        _buildFilterChip('Indoor Games', 'Indoor Games'),
                      ],
                    ),
                    
                    const SizedBox(height: 20),
                    
                    // Status filters
                    Text(
                      'Status',
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
                        _buildFilterChip('Confirmed', 'Confirmed', isStatus: true),
                        _buildFilterChip('Completed', 'Completed', isStatus: true),
                        _buildFilterChip('Cancelled', 'Cancelled', isStatus: true),
                      ],
                    ),
                    
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
            
            // Filter actions
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  // Clear All button
                  Expanded(
                    child: TextButton(
                      onPressed: _clearFilters,
                      style: TextButton.styleFrom(
                        foregroundColor: darkGreen,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: const Text('Clear All'),
                    ),
                  ),
                  const SizedBox(width: 16),
                  // Apply button
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _applyFilters,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryGreen,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        elevation: 0,
                      ),
                      child: const Text('Apply'),
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
  
  // Filter chip widget
  Widget _buildFilterChip(String label, String value, {bool isStatus = false}) {
    final isSelected = isStatus
        ? _selectedStatuses.contains(value)
        : _selectedVenueTypes.contains(value);
    
    return GestureDetector(
      onTap: () {
        if (isStatus) {
          _toggleStatusFilter(value);
        } else {
          _toggleVenueTypeFilter(value);
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? limeAccent : Colors.grey.shade200,
          borderRadius: BorderRadius.circular(50),
          border: isSelected
              ? Border.all(color: primaryGreen)
              : null,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (isSelected)
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Icon(
                  Icons.check,
                  size: 16,
                  color: primaryGreen,
                ),
              ),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? primaryGreen : Colors.grey.shade800,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  // Booking details modal
  Widget _buildBookingDetailsModal(BookingData booking) {
    return Container(
      margin: const EdgeInsets.only(top: 60),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: DraggableScrollableSheet(
        initialChildSize: 0.95,
        minChildSize: 0.7,
        maxChildSize: 0.95,
        expand: false,
        builder: (context, scrollController) {
          return Stack(
            children: [
              SingleChildScrollView(
                controller: scrollController,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: primaryGreen,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Handle bar
                          Center(
                            child: Container(
                              height: 5,
                              width: 60,
                              margin: const EdgeInsets.only(bottom: 16),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.3),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          
                          // Booking ID and Date
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Booking ID: ${booking.id}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                decoration: BoxDecoration(
                                  color: booking.status == "Cancelled"
                                      ? Colors.red
                                      : booking.status == "Confirmed"
                                          ? Colors.green
                                          : Colors.orange,
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: Text(
                                  booking.status,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          
                          // Venue name and info
                          Row(
                            children: [
                              Container(
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Icon(
                                  booking.venueIcon,
                                  color: primaryGreen,
                                  size: 36,
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      booking.venueName,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      booking.activity,
                                      style: TextStyle(
                                        color: limeAccent,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          
                          const SizedBox(height: 16),
                          
                          // Date and time
                          Row(
                            children: [
                              const Icon(
                                Icons.calendar_today,
                                color: Colors.white,
                                size: 16,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                DateFormat('EEEE, MMM d, yyyy').format(booking.date),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              const Icon(
                                Icons.access_time,
                                color: Colors.white,
                                size: 16,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                '${booking.startTime} - ${booking.endTime}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    
                    // Booking details
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Booking details section
                          _buildDetailsSectionTitle('Booking Details'),
                          const SizedBox(height: 16),
                          
                          // Participants
                          _buildDetailItem('Participants', '3 People'),
                          const SizedBox(height: 12),
                          
                          // Additional services
                          _buildDetailItem('Additional Services', 'Equipment Rental'),
                          const SizedBox(height: 12),
                          
                          // Payment method
                          _buildDetailItem('Payment Method', 'Credit Card'),
                          const SizedBox(height: 12),
                          
                          // Booking date
                          _buildDetailItem('Booking Date', '18 Apr, 2025'),
                          
                          const SizedBox(height: 24),
                          
                          // Payment details section
                          _buildDetailsSectionTitle('Payment Details'),
                          const SizedBox(height: 16),
                          
                          // Base price
                          _buildPaymentDetailItem('Base Price (x3)', '\$135.00'),
                          const SizedBox(height: 12),
                          
                          // Services fee
                          _buildPaymentDetailItem('Service Fee', '\$5.00'),
                          const SizedBox(height: 12),
                          
                          // Tax
                          _buildPaymentDetailItem('Tax (10%)', '\$14.00'),
                          const SizedBox(height: 12),
                          // Divider for total
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 12),
                            child: Divider(),
                          ),
                          
                          // Total amount
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Total Amount',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Color(0xFF094531),
                                ),
                              ),
                              Text(
                                '\$154.00',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: primaryGreen,
                                ),
                              ),
                            ],
                          ),
                          
                          const SizedBox(height: 24),
                          
                          // Venue Location section
                          _buildDetailsSectionTitle('Venue Location'),
                          const SizedBox(height: 16),
                          
                          // Location map placeholder
                          Container(
                            height: 160,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.map,
                                    size: 48,
                                    color: Colors.grey.shade500,
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    'Map View',
                                    style: TextStyle(
                                      color: Colors.grey.shade600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),
                          
                          // Venue address
                          Text(
                            '123 Main Street, Downtown City, State 12345',
                            style: TextStyle(
                              color: Colors.grey.shade700,
                            ),
                          ),
                          
                          const SizedBox(height: 24),
                          
                          // Venue rules section
                          _buildDetailsSectionTitle('Venue Rules'),
                          const SizedBox(height: 16),
                          
                          // Rule items
                          _buildRuleItem('Please arrive 10 minutes before your slot'),
                          _buildRuleItem('Outside food and drinks are not allowed'),
                          _buildRuleItem('Proper sports attire is required'),
                          _buildRuleItem('Cancellation policy: Free cancellation up to 24 hours before booking'),
                          
                          const SizedBox(height: 24),
                          
                          // Buttons section
                          booking.status == "Confirmed" 
                              ? _buildActionButtons(booking) 
                              : _buildPastBookingButtons(booking),
                          
                          const SizedBox(height: 16),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              
              // Close button
              Positioned(
                top: 10,
                right: 10,
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.3),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.close,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
  
  // Details section title widget
  Widget _buildDetailsSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: darkGreen,
      ),
    );
  }
  
  // Detail item widget
  Widget _buildDetailItem(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.grey.shade600,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: darkGreen,
          ),
        ),
      ],
    );
  }
  
  // Payment detail item widget
  Widget _buildPaymentDetailItem(String label, String amount) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.grey.shade600,
          ),
        ),
        Text(
          amount,
          style: TextStyle(
            color: darkGreen,
          ),
        ),
      ],
    );
  }
  
  // Venue rule item widget
  Widget _buildRuleItem(String rule) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.check_circle,
            size: 18,
            color: primaryGreen,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              rule,
              style: TextStyle(
                color: Colors.grey.shade700,
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  // Action buttons for confirmed bookings
  Widget _buildActionButtons(BookingData booking) {
    return Column(
      children: [
        // Cancel Booking button
        SizedBox(
          width: double.infinity,
          child: OutlinedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Cancelling booking for ${booking.venueName}...'),
                  backgroundColor: Colors.red,
                ),
              );
            },
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.red,
              side: const BorderSide(color: Colors.red),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(vertical: 14),
            ),
            child: const Text('Cancel Booking'),
          ),
        ),
        const SizedBox(height: 12),
        
        // Reschedule button
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _rescheduleBooking(booking);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryGreen,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(vertical: 14),
              elevation: 0,
            ),
            child: const Text('Reschedule'),
          ),
        ),
      ],
    );
  }
  
  // Buttons for past bookings
  Widget _buildPastBookingButtons(BookingData booking) {
    return Column(
      children: [
        // Leave Review button
        SizedBox(
          width: double.infinity,
          child: OutlinedButton(
            onPressed: () {
              Navigator.pop(context);
              _leaveReview(booking);
            },
            style: OutlinedButton.styleFrom(
              foregroundColor: primaryGreen,
              side: BorderSide(color: primaryGreen),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(vertical: 14),
            ),
            child: const Text('Leave Review'),
          ),
        ),
        const SizedBox(height: 12),
        
        // Book Again button
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _bookAgain(booking);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryGreen,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(vertical: 14),
              elevation: 0,
            ),
            child: const Text('Book Again'),
          ),
        ),
      ],
    );
  }
  
  // Review dialog
  Widget _buildReviewDialog(BookingData booking) {
    double rating = 0;
    final TextEditingController reviewController = TextEditingController();
    
    return StatefulBuilder(
      builder: (context, setState) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Dialog title
                Text(
                  'Rate Your Experience',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: darkGreen,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  booking.venueName,
                  style: TextStyle(
                    color: primaryGreen,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 20),
                
                // Star rating
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(5, (index) {
                    return IconButton(
                      icon: Icon(
                        index < rating ? Icons.star : Icons.star_border,
                        color: index < rating ? Colors.amber : Colors.grey,
                        size: 36,
                      ),
                      onPressed: () {
                        setState(() {
                          rating = index + 1;
                        });
                      },
                    );
                  }),
                ),
                const SizedBox(height: 20),
                
                // Review text field
                TextField(
                  controller: reviewController,
                  maxLines: 4,
                  decoration: InputDecoration(
                    hintText: 'Share your experience...',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: primaryGreen),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                
                // Submit button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Thank you for your review!'),
                          backgroundColor: primaryGreen,
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryGreen,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      elevation: 0,
                    ),
                    child: const Text('Submit Review'),
                  ),
                ),
                const SizedBox(height: 10),
                
                // Cancel button
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    'Cancel',
                    style: TextStyle(color: Colors.grey.shade600),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

// Booking data model
class BookingData {
  final String id;
  final String venueName;
  final String venueType;
  final String activity;
  final DateTime date;
  final String startTime;
  final String endTime;
  final String status;
  final IconData venueIcon;
  
  BookingData({
    required this.id,
    required this.venueName,
    required this.venueType,
    required this.activity,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.status,
    required this.venueIcon,
  });
}