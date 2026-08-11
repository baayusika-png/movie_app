import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  Widget profileItem(IconData icon, String title) {
    return ListTile(
      leading: Icon(icon, color: const Color(0xFFF6C7C7), size: 28),
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: const Icon(
        Icons.chevron_right,
        color: Color(0xFF9EC5FE),
        size: 28,
      ),
      onTap: () {},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF121212),
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const SizedBox(height: 20),

          // Profile Image
          const CircleAvatar(
            radius: 65,
            backgroundImage: NetworkImage(
              "https://images.unsplash.com/photo-1500648767791-00dcc994a43d?w=500",
            ),
          ),

          const SizedBox(height: 20),

          // Name
          const Text(
            "Alex Mercer",
            style: TextStyle(
              color: Colors.white,
              fontSize: 34,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 8),

          // Email
          const Text(
            "alex.mercer@example.com",
            style: TextStyle(color: Color(0xFFF6C7C7), fontSize: 18),
          ),

          const SizedBox(height: 30),

          // Menu Card
          Container(
            decoration: BoxDecoration(
              color: const Color(0xFF1E1E1E),
              borderRadius: BorderRadius.circular(18),
            ),
            child: Column(
              children: [
                profileItem(Icons.account_circle_outlined, "Account Details"),
                profileItem(Icons.payment_outlined, "Payment Methods"),
                profileItem(Icons.notifications_none, "Notifications"),
                profileItem(Icons.settings_outlined, "App Settings"),
                profileItem(Icons.help_outline, "Help & Support"),
              ],
            ),
          ),

          const Spacer(),

          // Logout Button
          SizedBox(
            width: double.infinity,
            height: 60,
            child: ElevatedButton.icon(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(35),
                ),
              ),
              icon: const Icon(Icons.logout, color: Colors.white),
              label: const Text(
                "Logout",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
