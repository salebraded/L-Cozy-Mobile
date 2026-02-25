import 'package:flutter/material.dart';
import '../Login page/login_screen.dart'; // 🌟 Make sure you import this for the logout button!

class StudentProfileScreen extends StatefulWidget {
  const StudentProfileScreen({Key? key}) : super(key: key);

  @override
  State<StudentProfileScreen> createState() => _StudentProfileScreenState();
}

class _StudentProfileScreenState extends State<StudentProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6F9), // App background
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Screen Header
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Profile",
                  style: TextStyle(
                    fontSize: 28, 
                    fontWeight: FontWeight.bold, 
                    color: Color(0xFF34495E)
                  ),
                ),
              ),
              const SizedBox(height: 30),

              // Avatar & User Info
              Center(
                child: Column(
                  children: [
                    Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        const CircleAvatar(
                          radius: 50,
                          backgroundColor: Color(0xFF3498DB),
                          child: Icon(Icons.person, size: 50, color: Colors.white),
                        ),
                        Container(
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(
                            color: Color(0xFF34495E),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.edit, size: 16, color: Colors.white),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      "Sarah Jenkins",
                      style: TextStyle(
                        fontSize: 22, 
                        fontWeight: FontWeight.bold, 
                        color: Color(0xFF34495E)
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      "sarah.jenkins@student.edu",
                      style: TextStyle(
                        fontSize: 14, 
                        color: Color(0xFF7F8C8D)
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),

              // Menu Sections
              _buildMenuSection(
                "Account Settings",
                [
                  _buildMenuItem(Icons.person_outline, "Personal Information"),
                  _buildMenuItem(Icons.lock_outline, "Change Password"),
                  _buildMenuItem(Icons.notifications_none, "Notifications"),
                ],
              ),
              const SizedBox(height: 25),

              _buildMenuSection(
                "Preferences",
                [
                  _buildMenuItem(Icons.language, "Language", trailingText: "English"),
                  _buildMenuItem(Icons.dark_mode_outlined, "Dark Mode", isToggle: true),
                ],
              ),
              const SizedBox(height: 25),

              _buildMenuSection(
                "Support",
                [
                  _buildMenuItem(Icons.help_outline, "Help Center"),
                  _buildMenuItem(Icons.description_outlined, "Terms & Conditions"),
                ],
              ),
              const SizedBox(height: 40),

              // Logout Button
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () {
                    // Logs the user out and clears the navigation stack so they can't hit "back"
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => const LoginScreen()),
                      (Route<dynamic> route) => false,
                    );
                  },
                  icon: const Icon(Icons.logout, color: Color(0xFFE74C3C)),
                  label: const Text(
                    "Log Out",
                    style: TextStyle(
                      fontSize: 16, 
                      fontWeight: FontWeight.bold, 
                      color: Color(0xFFE74C3C)
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    side: const BorderSide(color: Color(0xFFE74C3C), width: 2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  // HELPER METHOD: Builds a grouped section of menu items
  Widget _buildMenuSection(String title, List<Widget> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16, 
            fontWeight: FontWeight.bold, 
            color: Color(0xFF7F8C8D)
          ),
        ),
        const SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.02),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            children: items,
          ),
        ),
      ],
    );
  }

  // HELPER METHOD: Builds individual menu rows
  Widget _buildMenuItem(IconData icon, String title, {String? trailingText, bool isToggle = false}) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: const Color(0xFFF4F6F9),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color: const Color(0xFF34495E), size: 20),
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.w600, 
          color: Color(0xFF34495E)
        ),
      ),
      trailing: isToggle
          ? Switch(
              value: false, // Placeholder for dark mode state
              onChanged: (value) {
                print("Toggle changed: $value");
              },
              activeColor: const Color(0xFF3498DB),
            )
          : Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (trailingText != null)
                  Text(
                    trailingText,
                    style: const TextStyle(color: Color(0xFF7F8C8D), fontSize: 14),
                  ),
                if (trailingText != null) const SizedBox(width: 8),
                const Icon(Icons.arrow_forward_ios, size: 14, color: Color(0xFFBDC3C7)),
              ],
            ),
      onTap: isToggle ? null : () {
        print("$title tapped!");
      },
    );
  }
}