import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart'; // For the premium iOS-style switch

class ProfileSettingsPage extends StatefulWidget {
  const ProfileSettingsPage({super.key});

  @override
  State<ProfileSettingsPage> createState() => _ProfileSettingsPageState();
}

class _ProfileSettingsPageState extends State<ProfileSettingsPage> {
  bool _notificationsEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A), // Strict deep dark theme
      body: Column(
        children: [
          // --- HEADER & PROFILE INFO ---
          _buildProfileHeader(),

          const SizedBox(height: 10),

          // --- APP SETTINGS SECTION ---
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  const Text(
                    "APP SETTINGS",
                    style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w900, letterSpacing: 1.5),
                  ),
                  const SizedBox(height: 25),

                  // Setting 1: Notifications (with Toggle)
                  _build3DSettingTile(
                    icon: Icons.notifications_none_rounded,
                    title: "Push Notifications",
                    trailing: CupertinoSwitch(
                      value: _notificationsEnabled,
                      activeColor: Colors.white,
                      trackColor: const Color(0xFF2A2A2A),
                      thumbColor: _notificationsEnabled ? Colors.black : Colors.white70,
                      onChanged: (bool value) {
                        setState(() {
                          _notificationsEnabled = value;
                        });
                      },
                    ),
                    onTap: () {}, // Handled by switch
                  ),
                  const SizedBox(height: 16),

                  // Setting 2: Privacy & Security
                  _build3DSettingTile(
                    icon: Icons.lock_outline_rounded,
                    title: "Privacy & Security",
                    onTap: () {
                      // Navigate to security
                    },
                  ),
                  const SizedBox(height: 16),

                  // Setting 3: Data Backup
                  _build3DSettingTile(
                    icon: Icons.cloud_upload_outlined,
                    title: "Data Backup",
                    onTap: () {
                      // Navigate to backup
                    },
                  ),
                  const SizedBox(height: 16),

                  // Setting 4: Help & Support
                  _build3DSettingTile(
                    icon: Icons.help_outline_rounded,
                    title: "Help & Support",
                    onTap: () {
                      // Navigate to support
                    },
                  ),
                  const SizedBox(height: 35),

                  // --- LOGOUT BUTTON ---
                  _build3DContainer(
                    padding: EdgeInsets.zero,
                    child: ElevatedButton(
                      onPressed: () {
                        // Logout logic
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        minimumSize: const Size(double.infinity, 60),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.logout_rounded, color: Colors.redAccent, size: 20),
                          SizedBox(width: 10),
                          Text(
                            "LOG OUT",
                            style: TextStyle(color: Colors.redAccent, fontSize: 15, fontWeight: FontWeight.bold, letterSpacing: 1.5),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================
  // WIDGET BUILDERS
  // ==========================================

  Widget _buildProfileHeader() {
    return SizedBox(
      height: 300, // Space for banner + avatar + text
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          // 1. Dark Top Banner
          Container(
            height: 160,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: const LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [Color(0xFF1A1A1A), Color(0xFF0F0F0F)]),
              boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.5), blurRadius: 20, offset: const Offset(0, 10))],
              borderRadius: const BorderRadius.vertical(bottom: Radius.circular(30)),
            ),
          ),

          // 2. Circular Avatar (Cat from your image)
          Positioned(
            top: 100,
            child: Container(
              padding: const EdgeInsets.all(6), // The "cut out" gap
              decoration: const BoxDecoration(
                color: Color(0xFF0A0A0A), // Matches background
                shape: BoxShape.circle,
              ),
              child: Container(
                height: 90,
                width: 90,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.8), blurRadius: 15, offset: const Offset(0, 8))],
                  image: const DecorationImage(
                    image: NetworkImage('https://placekitten.com/200/200'), // Replace with your actual asset
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),

          // 3. User Details
          Positioned(
            top: 215,
            child: Column(
              children: [
                // Username + Edit Icon
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "@user_vikash",
                      style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(width: 8),
                    GestureDetector(
                      onTap: () {
                        // Edit profile logic
                      },
                      child: const Icon(Icons.edit_rounded, color: Colors.white54, size: 16),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                // Email
                const Text(
                  "testmail000@gmail.com",
                  style: TextStyle(color: Colors.white54, fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 0.5),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Helper: 3D Setting Tile
  Widget _build3DSettingTile({required IconData icon, required String title, required VoidCallback onTap, Widget? trailing}) {
    return _build3DContainer(
      padding: EdgeInsets.zero,
      child: ListTile(
        onTap: onTap,
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.03),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.white.withOpacity(0.05)),
          ),
          child: Icon(icon, color: Colors.white70, size: 22),
        ),
        title: Text(
          title,
          style: const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w600),
        ),
        trailing: trailing ?? const Icon(Icons.arrow_forward_ios_rounded, color: Colors.white24, size: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
    );
  }

  // Helper: The core 3D Neumorphic logic
  Widget _build3DContainer({required Widget child, EdgeInsetsGeometry? padding}) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: const LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [Color(0xFF1E1E1E), Color(0xFF121212)]),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.8), offset: const Offset(6, 6), blurRadius: 12),
          BoxShadow(color: Colors.white.withOpacity(0.03), offset: const Offset(-2, -2), blurRadius: 8),
        ],
        border: Border.all(color: Colors.white.withOpacity(0.02), width: 1),
      ),
      child: child,
    );
  }
}
