import 'package:flutter/material.dart';

class MorePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            // Logo Header without background
            const SizedBox(height: 40), // Top padding
            Image.asset(
              'assets/images/logo.png',
              height: 60,
            ),
            const SizedBox(height: 10),

            // White Container stretched fully with curvier edges
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30), // Curvier edges
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 5,
                      spreadRadius: 1,
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    const Text(
                      'More',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 15),

                    // Rectangular Container for Quick Access Buttons
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 10),
                      decoration: BoxDecoration(
                        color: Colors.grey[200], // Light grey background
                        borderRadius:
                            BorderRadius.circular(10), // Rounded edges
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          QuickAccessButton(
                            icon: 'assets/icons/how_to_play.png',
                            label: 'How to Play',
                          ),
                          QuickAccessButton(
                            icon: 'assets/icons/tds_dashboard.png',
                            label: 'TDS Dashboard',
                          ),
                          QuickAccessButton(
                            icon: 'assets/icons/billing_dashboard.png',
                            label: 'Billing Dashboard',
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 15),

                    // Single Square Container for Menu Items with fixed height
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 15),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border:
                            Border.all(color: Colors.black12), // Adding border
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 5,
                            spreadRadius: 1,
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          menuItem('Invite Friends',
                              'assets/icons/invite_friends.png'),
                          Divider(color: Colors.black12, thickness: 1),
                          menuItem('About Us', 'assets/icons/about_us.png'),
                          Divider(color: Colors.black12, thickness: 1),
                          menuItem('FAQs', 'assets/icons/faqs.png'),
                          Divider(color: Colors.black12, thickness: 1),
                          menuItem('Gaming Controls',
                              'assets/icons/gaming_controls.png'),
                          Divider(color: Colors.black12, thickness: 1),
                          menuItem('Policies', 'assets/icons/policies.png'),
                          Divider(color: Colors.black12, thickness: 1),
                          menuItem('Verify Account',
                              'assets/icons/verify_account.png'),
                          Divider(color: Colors.black12, thickness: 1),
                          menuItem('Contact Us', 'assets/icons/contact_us.png'),
                          Divider(color: Colors.black12, thickness: 1),
                          menuItem('Settings', 'assets/icons/settings.png'),
                        ],
                      ),
                    ),

                    // Logout Button
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const Icon(Icons.logout, color: Colors.red),
                          const SizedBox(width: 5),
                          const Text(
                            'Logout',
                            style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget menuItem(String title, String iconPath) {
    return Row(
      children: [
        Image.asset(
          iconPath,
          width: 24,
          height: 24,
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            title,
            style: const TextStyle(fontSize: 14),
          ),
        ),
        const Icon(Icons.arrow_forward_ios, size: 16),
      ],
    );
  }
}

class QuickAccessButton extends StatelessWidget {
  final String icon;
  final String label;

  const QuickAccessButton({Key? key, required this.icon, required this.label})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 5,
                spreadRadius: 1,
              ),
            ],
          ),
          child: Image.asset(
            icon,
            width: 40,
            height: 40,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          label,
          style: const TextStyle(fontSize: 12),
        ),
      ],
    );
  }
}
