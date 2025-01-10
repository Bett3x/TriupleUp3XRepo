import 'package:flutter/material.dart';
import 'Refer.dart'; // Import Refer.dart

class Sidebar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(30),
            bottomRight: Radius.circular(30),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10,
              spreadRadius: 2,
              offset: Offset(-2, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            // Header Section
            Container(
              color: Color(0xFF8B0000), // Dark Red color
              padding:
                  EdgeInsets.only(top: 50, bottom: 20, left: 20, right: 20),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.white,
                    child: Image.asset(
                      'assets/icons/Profile.png',
                      height: 40,
                      width: 40,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Admin",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 5),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // Wallet Section
            Container(
              margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 5,
                    spreadRadius: 2,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Image.asset(
                    'assets/wallet.png',
                    height: 30,
                    width: 30,
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      "Wallet",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Add Cash logic
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          Colors.green, // Green color for "Add Cash"
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      "+ ADD CASH",
                      style: TextStyle(fontSize: 12, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            // Total Balance Text
            Text(
              "Total Balance: Rs. xx",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 20),
            // Menu Options in a Container with Shadow
            Container(
              margin: EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 5,
                    spreadRadius: 2,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                children: [
                  _buildMenuItem(
                    context,
                    icon: 'assets/icons/invite_friends.png',
                    title: "Refer & Earn",
                    onTap: () {
                      // Navigate to Refer.dart
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ReferPage()),
                      );
                    },
                  ),
                  _buildDivider(),
                  _buildMenuItem(
                    context,
                    icon: 'assets/icons/how_to_play.png',
                    title: "How To Play",
                    onTap: () {
                      // Navigate to How To Play screen
                    },
                  ),
                  _buildDivider(),
                  _buildMenuItem(
                    context,
                    icon: 'assets/icons/contact_us.png',
                    title: "Contact & Support",
                    onTap: () {
                      // Navigate to Contact Us screen
                    },
                  ),
                  _buildDivider(),
                  _buildMenuItem(
                    context,
                    icon: 'assets/icons/Leaderboard.png',
                    title: "Leader Board",
                    onTap: () {
                      // Navigate to Leader Board screen
                    },
                  ),
                  _buildDivider(),
                  _buildMenuItem(
                    context,
                    icon: 'assets/setting.png',
                    title: "Settings",
                    onTap: () {
                      // Navigate to Settings screen
                    },
                  ),
                  _buildDivider(),
                  _buildMenuItem(
                    context,
                    icon: 'assets/icons/More.png',
                    title: "More",
                    onTap: () {
                      // Navigate to More options screen
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem(BuildContext context,
      {required String icon,
      required String title,
      required VoidCallback onTap}) {
    return ListTile(
      leading: Image.asset(
        icon,
        height: 25,
        width: 25,
      ),
      title: Text(
        title,
        style: TextStyle(fontSize: 16, color: Colors.black),
      ),
      onTap: onTap,
    );
  }

  Widget _buildDivider() {
    return Divider(
      thickness: 1,
      color: Colors.grey[300],
      indent: 15,
      endIndent: 15,
    );
  }
}
