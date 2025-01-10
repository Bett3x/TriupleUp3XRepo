import 'package:flutter/material.dart';
import 'package:tripleup3x/pages/contest.dart'; // Import ContestPage from Home.dart

class MyCon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/background.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // White Container with 80% height
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.8,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Column(
                children: [
                  // Text at the Top Center
                  SizedBox(height: 20),
                  Text(
                    "Your Contest Will be Visible Here",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20),
                  // Display Two Contest Containers
                  Expanded(
                    child: ListView.builder(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      itemCount: 2, // Only two containers
                      itemBuilder: (context, index) {
                        return _buildContext(
                            context); // Pass context for navigation
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Logo Positioned Outside the White Container on the Left Side
          Positioned(
            top: MediaQuery.of(context).size.height * 0.2 - 120,
            left: 20,
            child: Image.asset(
              'assets/images/logo.png',
              width: 120, // Larger logo width
              height: 120, // Larger logo height
              fit: BoxFit.contain,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContext(BuildContext context) {
    return Container(
      height: 200,
      margin: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 5,
            spreadRadius: 2,
            color: Colors.black38,
            offset: Offset(-1, 1),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildTopRow(),
          _buildCenterContent(),
          _buildBtmRow(context), // Pass context for "ENTER" button navigation
        ],
      ),
    );
  }

  Widget _buildTopRow() {
    return Container(
      height: 40,
      color: Colors.red.shade100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                height: 20,
                width: 100,
                color: Color.fromRGBO(158, 32, 27, 1),
                child: Padding(
                  padding: EdgeInsets.only(left: 5),
                  child: Text("CONTEST", style: TextStyle(color: Colors.white)),
                ),
              ),
              Container(
                height: 20,
                width: 20,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    stops: [0.5, 0.5],
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight,
                    colors: [
                      Color.fromRGBO(158, 32, 27, 1),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(right: 5.0),
            child: Text(
              "02:00",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCenterContent() {
    return Expanded(
      child: Center(
        child: Text("Question -------- ------- ------ --------"),
      ),
    );
  }

  Widget _buildBtmRow(BuildContext context) {
    return SizedBox(
      height: 30,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildBtnChip('assets/money.png', 'Entry Fees Rs.50'),
          ColoredBox(
            color: Color.fromRGBO(47, 50, 95, 1),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 0),
              child: VerticalDivider(width: 1, thickness: 1),
            ),
          ),
          _buildBtnChip('assets/trophy.png', 'Winning Rs.10000'),
          ColoredBox(
            color: Color.fromRGBO(47, 50, 95, 1),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 0),
              child: VerticalDivider(width: 1, thickness: 1),
            ),
          ),
          _buildBtnChip(
            'assets/flag.png',
            'ENTER',
            true,
            context, // Pass context for navigation
          ),
        ],
      ),
    );
  }

  Widget _buildBtnChip(String assets, String text,
      [bool navigate = false, BuildContext? context]) {
    return Expanded(
      child: GestureDetector(
        onTap: navigate
            ? () {
                // Navigate to ContestPage when "ENTER" is clicked
                Navigator.push(
                  context!,
                  MaterialPageRoute(builder: (context) => ContestPage()),
                );
              }
            : null, // No action if navigate is false
        child: SizedBox(
          height: 30,
          child: ColoredBox(
            color: Color.fromRGBO(47, 50, 95, 1),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(assets, height: 14, width: 14),
                SizedBox(width: 5),
                Text(text, style: TextStyle(color: Colors.white, fontSize: 11)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
