import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

// Import from auth folder



class VenueBookingScreen extends StatefulWidget {
  final String venueName;
  final String venueType;
  final List<String> availableActivities;
  final double rating;

  const VenueBookingScreen({
    Key? key,
    required this.venueName,
    required this.venueType,
    required this.availableActivities,
    required this.rating,
  }) : super(key: key);

  @override
  State<VenueBookingScreen> createState() => _VenueBookingScreenState();
}

class _VenueBookingScreenState extends State<VenueBookingScreen> {
  // Define custom color scheme to match the app
  final Color primaryGreen = const Color(0xFF007F5A);
  final Color limeAccent = const Color(0xFFC8FA60);
  final Color backgroundColor = const Color(0xFFFFFFFF);
  final Color darkGreen = const Color(0xFF094531);

  // Calendar and time selection related variables
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  
  // Available time slots (would normally come from an API)
  final List<String> _availableTimeSlots = [
    '9:00 AM - 10:30 AM',
    '11:00 AM - 12:30 PM',
    '1:00 PM - 2:30 PM',
    '3:00 PM - 4:30 PM',
    '5:00 PM - 6:30 PM',
    '7:00 PM - 8:30 PM',
  ];
  String? _selectedTimeSlot;
  
  // Activity selection
  String? _selectedActivity;
  
  // Number of participants
  int _participantCount = 1;
  
  // Extra services/equipment
  Map<String, bool> _extraServices = {
    'Equipment Rental': false,
    'Instructor/Coach': false,
    'Photography Service': false,
    'Refreshments': false,
  };

  // Payment method
  String _paymentMethod = 'Credit Card';
  
  // Total cost calculation
  double _basePrice = 45.0;
  double _serviceFee = 5.0;
  double _tax = 0.0;
  double _extraServicesCost = 0.0;

  @override
  void initState() {
    super.initState();
    // Initialize with first activity if available
    if (widget.availableActivities.isNotEmpty) {
      _selectedActivity = widget.availableActivities.first;
    }
    // Calculate initial tax
    _calculateTotals();
  }

  // Calculate all costs
  void _calculateTotals() {
    // Calculate extras cost
    _extraServicesCost = 0.0;
    _extraServices.forEach((service, isSelected) {
      if (isSelected) {
        switch (service) {
          case 'Equipment Rental':
            _extraServicesCost += 10.0;
            break;
          case 'Instructor/Coach':
            _extraServicesCost += 25.0;
            break;
          case 'Photography Service':
            _extraServicesCost += 15.0;
            break;
          case 'Refreshments':
            _extraServicesCost += 8.0;
            break;
        }
      }
    });
    
    // Base price times number of participants (with a small discount for groups)
    double participantMultiplier = _participantCount > 3 ? 0.9 : 1.0;
    double subtotal = (_basePrice * _participantCount * participantMultiplier) + _extraServicesCost + _serviceFee;
    
    // Calculate tax (10%)
    _tax = subtotal * 0.1;
    
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    double totalAmount = (_basePrice * _participantCount) + _serviceFee + _tax + _extraServicesCost;
    
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: primaryGreen,
        foregroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Book ${widget.venueName}',
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Venue Banner with Rating
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              decoration: BoxDecoration(
                color: primaryGreen,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  // Venue Icon
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Center(
                      child: Icon(
                        _getVenueIcon(widget.venueType),
                        color: primaryGreen,
                        size: 36,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  // Venue Info
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.venueName,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          widget.venueType,
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.9),
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            const Icon(
                              Icons.star,
                              color: Color(0xFFC8FA60),
                              size: 18,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              widget.rating.toString(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              ' (132 reviews)',
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.8),
                                fontSize: 12,
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
            
            // Booking progress tracker
            Container(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
              decoration: BoxDecoration(
                color: limeAccent.withOpacity(0.2),
                border: Border(
                  bottom: BorderSide(color: Colors.grey.shade200),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildProgressDot(1, true, "Select"),
                  _buildProgressLine(true),
                  _buildProgressDot(2, _selectedDay != null, "Schedule"),
                  _buildProgressLine(_selectedDay != null && _selectedTimeSlot != null),
                  _buildProgressDot(3, _selectedDay != null && _selectedTimeSlot != null, "Review"),
                  _buildProgressLine(false),
                  _buildProgressDot(4, false, "Confirm"),
                ],
              ),
            ),
            
            // Activity selection
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionTitle('Choose Activity', Icons.sports),
                  const SizedBox(height: 12),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade200),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: DropdownButtonFormField<String>(
                      value: _selectedActivity,
                      onChanged: (newValue) {
                        setState(() {
                          _selectedActivity = newValue;
                        });
                      },
                      items: widget.availableActivities.map((activity) {
                        return DropdownMenuItem<String>(
                          value: activity,
                          child: Text(activity),
                        );
                      }).toList(),
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        border: InputBorder.none,
                        hintText: 'Select an activity',
                        hintStyle: TextStyle(color: Colors.grey.shade500),
                      ),
                      icon: Icon(Icons.arrow_drop_down, color: primaryGreen),
                      isExpanded: true,
                    ),
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Number of participants
                  _buildSectionTitle('Number of Participants', Icons.people),
                  const SizedBox(height: 12),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade200),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '$_participantCount ${_participantCount > 1 ? "People" : "Person"}',
                          style: const TextStyle(fontSize: 16),
                        ),
                        Row(
                          children: [
                            IconButton(
                              onPressed: _participantCount > 1 
                                  ? () {
                                      setState(() {
                                        _participantCount--;
                                        _calculateTotals();
                                      });
                                    } 
                                  : null,
                              icon: Icon(
                                Icons.remove_circle_outline,
                                color: _participantCount > 1 ? primaryGreen : Colors.grey,
                              ),
                            ),
                            Text(
                              '$_participantCount',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            IconButton(
                              onPressed: _participantCount < 10 
                                  ? () {
                                      setState(() {
                                        _participantCount++;
                                        _calculateTotals();
                                      });
                                    } 
                                  : null,
                              icon: Icon(
                                Icons.add_circle_outline,
                                color: _participantCount < 10 ? primaryGreen : Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Date selection
                  _buildSectionTitle('Select Date', Icons.calendar_today),
                  const SizedBox(height: 12),
                  Card(
                    elevation: 2,
                    shadowColor: primaryGreen.withOpacity(0.2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TableCalendar(
                        firstDay: DateTime.now(),
                        lastDay: DateTime.now().add(const Duration(days: 90)),
                        focusedDay: _focusedDay,
                        calendarFormat: _calendarFormat,
                        availableCalendarFormats: const {
                          CalendarFormat.month: 'Month',
                          CalendarFormat.twoWeeks: '2 Weeks',
                        },
                        selectedDayPredicate: (day) {
                          return isSameDay(_selectedDay, day);
                        },
                        onDaySelected: (selectedDay, focusedDay) {
                          setState(() {
                            _selectedDay = selectedDay;
                            _focusedDay = focusedDay;
                            _selectedTimeSlot = null; // Reset time slot when date changes
                          });
                        },
                        onFormatChanged: (format) {
                          setState(() {
                            _calendarFormat = format;
                          });
                        },
                        onPageChanged: (focusedDay) {
                          _focusedDay = focusedDay;
                        },
                        headerStyle: HeaderStyle(
                          titleCentered: true,
                          formatButtonDecoration: BoxDecoration(
                            color: limeAccent.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          formatButtonTextStyle: TextStyle(color: primaryGreen),
                          titleTextStyle: TextStyle(
                            color: darkGreen,
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        calendarStyle: CalendarStyle(
                          selectedDecoration: BoxDecoration(
                            color: primaryGreen,
                            shape: BoxShape.circle,
                          ),
                          todayDecoration: BoxDecoration(
                            color: limeAccent.withOpacity(0.7),
                            shape: BoxShape.circle,
                          ),
                          todayTextStyle: TextStyle(color: darkGreen),
                          outsideDaysVisible: false,
                        ),
                      ),
                    ),
                  ),
                  
                  if (_selectedDay != null) ...[
                    const SizedBox(height: 24),
                    
                    // Time slot selection
                    _buildSectionTitle('Select Time Slot', Icons.access_time),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: _availableTimeSlots.map((timeSlot) {
                        final isSelected = timeSlot == _selectedTimeSlot;
                        final isAvailable = !['11:00 AM - 12:30 PM', '5:00 PM - 6:30 PM']
                            .contains(timeSlot); // Simulate some slots being unavailable
                            
                        return GestureDetector(
                          onTap: isAvailable ? () {
                            setState(() {
                              _selectedTimeSlot = timeSlot;
                            });
                          } : null,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? primaryGreen
                                  : isAvailable 
                                      ? Colors.white 
                                      : Colors.grey.shade100,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: isSelected
                                    ? primaryGreen
                                    : isAvailable 
                                        ? Colors.grey.shade300 
                                        : Colors.grey.shade200,
                              ),
                            ),
                            child: Text(
                              timeSlot,
                              style: TextStyle(
                                color: isSelected
                                    ? Colors.white
                                    : isAvailable 
                                        ? Colors.black87 
                                        : Colors.grey,
                                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                  
                  if (_selectedDay != null && _selectedTimeSlot != null) ...[
                    const SizedBox(height: 24),
                    
                    // Additional Services
                    _buildSectionTitle('Additional Services', Icons.add_box),
                    const SizedBox(height: 12),
                    Card(
                      elevation: 2,
                      shadowColor: primaryGreen.withOpacity(0.2),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: _extraServices.entries.map((entry) {
                            return CheckboxListTile(
                              title: Text(entry.key),
                              subtitle: Text(_getExtraServicePrice(entry.key)),
                              value: entry.value,
                              onChanged: (bool? value) {
                                setState(() {
                                  _extraServices[entry.key] = value ?? false;
                                  _calculateTotals();
                                });
                              },
                              activeColor: primaryGreen,
                              checkColor: Colors.white,
                              contentPadding: EdgeInsets.zero,
                              controlAffinity: ListTileControlAffinity.trailing,
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Payment Method
                    _buildSectionTitle('Payment Method', Icons.payment),
                    const SizedBox(height: 12),
                    Card(
                      elevation: 2,
                      shadowColor: primaryGreen.withOpacity(0.2),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        children: [
                          RadioListTile<String>(
                            title: Row(
                              children: [
                                Icon(Icons.credit_card, color: darkGreen),
                                const SizedBox(width: 12),
                                const Text('Credit/Debit Card'),
                              ],
                            ),
                            value: 'Credit Card',
                            groupValue: _paymentMethod,
                            onChanged: (value) {
                              setState(() {
                                _paymentMethod = value!;
                              });
                            },
                            activeColor: primaryGreen,
                            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          ),
                          Divider(color: Colors.grey.shade200, height: 1),
                          RadioListTile<String>(
                            title: Row(
                              children: [
                                Icon(Icons.account_balance_wallet, color: darkGreen),
                                const SizedBox(width: 12),
                                const Text('Digital Wallet'),
                              ],
                            ),
                            value: 'Digital Wallet',
                            groupValue: _paymentMethod,
                            onChanged: (value) {
                              setState(() {
                                _paymentMethod = value!;
                              });
                            },
                            activeColor: primaryGreen,
                            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          ),
                          Divider(color: Colors.grey.shade200, height: 1),
                          RadioListTile<String>(
                            title: Row(
                              children: [
                                Icon(Icons.attach_money, color: darkGreen),
                                const SizedBox(width: 12),
                                const Text('Pay at Venue'),
                              ],
                            ),
                            value: 'Pay at Venue',
                            groupValue: _paymentMethod,
                            onChanged: (value) {
                              setState(() {
                                _paymentMethod = value!;
                              });
                            },
                            activeColor: primaryGreen,
                            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          ),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Price Details
                    _buildSectionTitle('Booking Summary', Icons.receipt_long),
                    const SizedBox(height: 12),
                    Card(
                      elevation: 3,
                      shadowColor: primaryGreen.withOpacity(0.3),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      widget.venueName,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      _selectedActivity ?? '',
                                      style: TextStyle(
                                        color: primaryGreen,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      DateFormat('EEE, MMM d').format(_selectedDay!),
                                      style: const TextStyle(fontWeight: FontWeight.w500),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      _selectedTimeSlot ?? '',
                                      style: TextStyle(color: darkGreen.withOpacity(0.7)),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const Divider(height: 24),
                            _buildPriceRow(
                              'Base Price (x$_participantCount)',
                              '\$${(_basePrice * _participantCount).toStringAsFixed(2)}',
                            ),
                            if (_participantCount > 3)
                              _buildPriceRow(
                                'Group Discount (10%)',
                                '-\$${((_basePrice * _participantCount) * 0.1).toStringAsFixed(2)}',
                                isDiscount: true,
                              ),
                            if (_extraServicesCost > 0)
                              _buildPriceRow(
                                'Additional Services',
                                '\$${_extraServicesCost.toStringAsFixed(2)}',
                              ),
                            _buildPriceRow(
                              'Service Fee',
                              '\$${_serviceFee.toStringAsFixed(2)}',
                            ),
                            _buildPriceRow(
                              'Tax (10%)',
                              '\$${_tax.toStringAsFixed(2)}',
                            ),
                            const Divider(height: 24),
                            _buildPriceRow(
                              'Total Amount',
                              '\$${totalAmount.toStringAsFixed(2)}',
                              isTotal: true,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                  
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              offset: const Offset(0, -1),
              blurRadius: 4,
            ),
          ],
        ),
        child: SafeArea(
          child: ElevatedButton(
            onPressed: _selectedDay != null && _selectedTimeSlot != null
                ? () => _confirmBooking(context)
                : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryGreen,
              foregroundColor: Colors.white,
              disabledBackgroundColor: Colors.grey.shade300,
              disabledForegroundColor: Colors.grey.shade500,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 0,
            ),
            child: const Text(
              'Confirm Booking',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Widget to display section titles
  Widget _buildSectionTitle(String title, IconData icon) {
    return Row(
      children: [
        Icon(icon, color: primaryGreen, size: 22),
        const SizedBox(width: 8),
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: darkGreen,
          ),
        ),
      ],
    );
  }

  // Widget to display price details
  Widget _buildPriceRow(String label, String value, {bool isTotal = false, bool isDiscount = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              color: isTotal ? darkGreen : Colors.grey.shade700,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              fontSize: isTotal ? 16 : 14,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              color: isDiscount ? Colors.green.shade700 : (isTotal ? darkGreen : Colors.grey.shade800),
              fontWeight: isTotal ? FontWeight.bold : FontWeight.w500,
              fontSize: isTotal ? 16 : 14,
            ),
          ),
        ],
      ),
    );
  }
  
  // Booking progress indicator components
  Widget _buildProgressDot(int step, bool isActive, String label) {
    return Column(
      children: [
        Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            color: isActive ? primaryGreen : Colors.grey.shade300,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              step.toString(),
              style: TextStyle(
                color: isActive ? Colors.white : Colors.grey.shade600,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: isActive ? darkGreen : Colors.grey.shade600,
            fontWeight: isActive ? FontWeight.w500 : FontWeight.normal,
          ),
        ),
      ],
    );
  }

  Widget _buildProgressLine(bool isActive) {
    return Expanded(
      child: Container(
        height: 2,
        color: isActive ? primaryGreen : Colors.grey.shade300,
      ),
    );
  }

  // Get venue icon based on venue type
  IconData _getVenueIcon(String venueType) {
    switch (venueType) {
      case 'Turf':
        return Icons.sports_soccer;
      case 'VR Games':
        return Icons.videogame_asset;
      case 'Indoor Games':
        return Icons.sports_esports;
      default:
        return Icons.place;
    }
  }

  // Get price for extra services
  String _getExtraServicePrice(String service) {
    switch (service) {
      case 'Equipment Rental':
        return 'Add \$10.00';
      case 'Instructor/Coach':
        return 'Add \$25.00';
      case 'Photography Service':
        return 'Add \$15.00';
      case 'Refreshments':
        return 'Add \$8.00';
      default:
        return '';
    }
  }

  // Confirm booking and navigate back to bookings screen
  void _confirmBooking(BuildContext context) {
    // Show loading indicator
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: 60,
                  height: 60,
                  child: CircularProgressIndicator(
                    color: primaryGreen,
                    strokeWidth: 6,
                  ),
                ),
                const SizedBox(height: 24),
                const Text(
                  'Processing your booking...',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Please wait while we confirm your reservation.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.grey.shade700,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
    
    // Simulate API call delay
    Future.delayed(const Duration(seconds: 2), () {
      // Close loading dialog
      Navigator.pop(context);
      
      // Show success dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: primaryGreen.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.check_circle,
                      color: primaryGreen,
                      size: 60,
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Booking Confirmed!',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Your booking at ${widget.venueName} has been confirmed for ${DateFormat('EEEE, MMM d').format(_selectedDay!)} at ${_selectedTimeSlot!}.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.grey.shade700,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Booking ID: #${DateTime.now().millisecondsSinceEpoch.toString().substring(5, 13)}',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: darkGreen,
                    ),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () {
                      // Close dialog and navigate back
                      Navigator.pop(context);
                      Navigator.pop(context, {
                        'booked': true,
                        'venueName': widget.venueName,
                        'date': _selectedDay,
                        'timeSlot': _selectedTimeSlot,
                        'activity': _selectedActivity,
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryGreen,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 0,
                    ),
                    child: const Text(
                      'View My Bookings',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextButton(
                    onPressed: () {
                      // Close dialog only
                      Navigator.pop(context);
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Return to Home',
                      style: TextStyle(
                        color: darkGreen,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    });
  }
}