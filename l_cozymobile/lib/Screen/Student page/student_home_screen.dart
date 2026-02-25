import 'package:flutter/material.dart';

class StudentHomeScreen extends StatefulWidget {
  const StudentHomeScreen({Key? key}) : super(key: key);

  @override
  State<StudentHomeScreen> createState() => _StudentHomeScreenState();
}

class _StudentHomeScreenState extends State<StudentHomeScreen> {
  // Tracks the currently selected tab in the Bottom Navigation Bar
  int _selectedIndex = 0;

  // Mock data for the dormitory feed
  final List<Map<String, dynamic>> _dorms = [
    {
      "name": "Sunrise Student Living",
      "location": "0.5 miles from campus",
      "price": "\$450 / month",
      "rating": 4.8,
      "availableBeds": 2,
    },
    {
      "name": "The Hub Residences",
      "location": "1.2 miles from campus",
      "price": "\$350 / month",
      "rating": 4.5,
      "availableBeds": 5,
    },
    {
      "name": "Cozy Corner Dorms",
      "location": "0.8 miles from campus",
      "price": "\$400 / month",
      "rating": 4.9,
      "availableBeds": 1,
    }
  ];

  // Handles Bottom Nav tapping
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6F9), // App background
      
      // 🌟 MAIN BODY: Switches content based on Bottom Nav selection 🌟
      body: SafeArea(
        child: _selectedIndex == 0 
            ? _buildHomeFeed() 
            : Center(
                child: Text(
                  "Content for Tab $_selectedIndex coming soon!",
                  style: const TextStyle(color: Color(0xFF7F8C8D), fontSize: 16),
                ),
              ),
      ),

      // 🌟 BOTTOM NAVIGATION BAR 🌟
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: const Color(0xFF3498DB), // Student Blue Accent
        unselectedItemColor: const Color(0xFF7F8C8D),
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed, // Prevents items from shifting
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), activeIcon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite_outline), activeIcon: Icon(Icons.favorite), label: 'Saved'),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_today_outlined), activeIcon: Icon(Icons.calendar_today), label: 'Bookings'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), activeIcon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }

  // 🌟 HELPER METHOD: Builds the main Home Feed 🌟
  Widget _buildHomeFeed() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Custom Header (Greeting + Profile Pic placeholder)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "Hello, Sarah 👋",
                    style: TextStyle(fontSize: 16, color: Color(0xFF7F8C8D)),
                  ),
                  SizedBox(height: 4),
                  Text(
                    "Find your perfect dorm",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF34495E)),
                  ),
                ],
              ),
              const CircleAvatar(
                radius: 24,
                backgroundColor: Color(0xFF3498DB),
                child: Icon(Icons.person, color: Colors.white),
              )
            ],
          ),
          const SizedBox(height: 25),

          // Search & Filter Bar
          Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search dorms, locations...',
                    prefixIcon: const Icon(Icons.search, color: Color(0xFF7F8C8D)),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(vertical: 0), // Centers text vertically
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF34495E),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: IconButton(
                  icon: const Icon(Icons.tune, color: Colors.white),
                  onPressed: () {
                    // TODO: Open Filter Bottom Sheet
                    print("Filter tapped!");
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 25),

          // Horizontal Categories
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildCategoryChip("All", true),
                _buildCategoryChip("Near Campus", false),
                _buildCategoryChip("Top Rated", false),
                _buildCategoryChip("Budget", false),
                _buildCategoryChip("Solo Rooms", false),
              ],
            ),
          ),
          const SizedBox(height: 25),

          // Section Title
          const Text(
            "Recommended for you",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF34495E)),
          ),
          const SizedBox(height: 15),

          // ListView of Dorms
          ListView.builder(
            shrinkWrap: true, // Needed because it's inside a SingleChildScrollView
            physics: const NeverScrollableScrollPhysics(), // Disables inner scrolling
            itemCount: _dorms.length,
            itemBuilder: (context, index) {
              return _buildDormCard(_dorms[index]);
            },
          ),
        ],
      ),
    );
  }

  // 🌟 HELPER METHOD: Builds Category Chips 🌟
  Widget _buildCategoryChip(String label, bool isSelected) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFF3498DB) : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: isSelected ? const Color(0xFF3498DB) : const Color(0xFFE0E0E0)),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: isSelected ? Colors.white : const Color(0xFF7F8C8D),
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  // 🌟 HELPER METHOD: Builds Individual Dorm Cards 🌟
  Widget _buildDormCard(Map<String, dynamic> dorm) {
    return GestureDetector(
      onTap: () {
        // TODO: Navigate to Dormitory Details Screen
        print("Tapped on ${dorm['name']}");
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Placeholder for Dorm Image
            Container(
              height: 160,
              decoration: const BoxDecoration(
                color: Color(0xFFBDC3C7),
                borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
              ),
              child: const Center(
                child: Icon(Icons.image_outlined, size: 50, color: Colors.white),
              ),
            ),
            
            // Dorm Info
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          dorm['name'],
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF34495E)),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Row(
                        children: [
                          const Icon(Icons.star, color: Colors.amber, size: 18),
                          const SizedBox(width: 4),
                          Text(
                            dorm['rating'].toString(),
                            style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF34495E)),
                          ),
                        ],
                      )
                    ],
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      const Icon(Icons.location_on_outlined, size: 16, color: Color(0xFF7F8C8D)),
                      const SizedBox(width: 4),
                      Text(
                        dorm['location'],
                        style: const TextStyle(color: Color(0xFF7F8C8D), fontSize: 13),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        dorm['price'],
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF3498DB)),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: const Color(0xFFE8F8F5),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          "${dorm['availableBeds']} Beds Left",
                          style: const TextStyle(color: Color(0xFF1ABC9C), fontWeight: FontWeight.bold, fontSize: 12),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}