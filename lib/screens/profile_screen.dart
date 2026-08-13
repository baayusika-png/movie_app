import 'package:flutter/material.dart';
import 'package:movie_app/providers/auth_provider.dart';
import 'package:movie_app/widgets/login_required.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  Widget profileItem(IconData icon, String title) {
    return Material(
      color: const Color(0xFF1E1E1E),
      child: ListTile(
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
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();

    if (!auth.isLoggedIn) {
      return const Scaffold(
        backgroundColor: Color(0xFF121212),
        body: LoginRequired(
          title: "Login to Access Profile",
          subtitle: "Sign in to view and edit your profile.",
        ),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 20),

            CircleAvatar(
              radius: 65,
              backgroundImage: auth.image != null
                  ? NetworkImage(auth.image!)
                  : null,
              child: auth.image == null
                  ? const Icon(Icons.person, size: 60, color: Colors.white)
                  : null,
            ),

            const SizedBox(height: 20),

            Text(
              auth.name ?? "No Name",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 34,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              auth.email ?? "No Email",
              style: const TextStyle(color: Color(0xFFF6C7C7), fontSize: 18),
            ),

            const SizedBox(height: 30),

            Material(
              color: const Color(0xFF1E1E1E),
              borderRadius: BorderRadius.circular(18),
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

            SizedBox(
              width: double.infinity,
              height: 60,
              child: ElevatedButton.icon(
                onPressed: () {
                  context.read<AuthProvider>().logout();
                },
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
      ),
    );
  }
}
