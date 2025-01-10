import 'package:tripleup3x/home/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:tripleup3x/pages/contest.dart';
import 'package:tripleup3x/pages/Profile.dart'; // Import the Profile page

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _page = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _buildAppBar(),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 100 * 85,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  blurRadius: 10,
                  spreadRadius: 5,
                  color: Colors.black26,
                )
              ],
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Align(
                      alignment: Alignment.topRight,
                      child: buildIcon('menu', false)),
                ),
                _buildButtons(),
                SizedBox(height: 10),
                Expanded(
                  child: IndexedStack(
                    index: _page,
                    children: [
                      ListView(
                        shrinkWrap: true,
                        padding: EdgeInsets.only(bottom: 100),
                        children: List.generate(2, (index) => _buildContext()),
                      ),
                      ListView(
                        shrinkWrap: true,
                        padding: EdgeInsets.only(bottom: 100),
                        children: List.generate(
                            2, (index) => ColoredBox(color: Colors.red)),
                      ),
                      ListView(
                        shrinkWrap: true,
                        padding: EdgeInsets.only(bottom: 100),
                        children: List.generate(2, (index) => SizedBox()),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  /// center-top button live | upcoming | completed
  Widget _buildButtons() {
    return Container(
      height: 55,
      margin: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Color.fromRGBO(158, 32, 27, 1),
        boxShadow: [
          BoxShadow(
              blurRadius: 5,
              spreadRadius: 2,
              color: Colors.black38,
              offset: Offset(-1, 4))
        ],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 5),
        child: Row(
          children: [
            Expanded(
                child: GestureDetector(
              onTap: () => setState(() => _page = 0),
              child: Center(
                  child: Text('LIVE',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold))),
            )),
            VerticalDivider(width: 2),
            Expanded(
                child: GestureDetector(
              onTap: () => setState(() => _page = 1),
              child: Center(
                  child: Text('UPCOMING',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold))),
            )),
            VerticalDivider(width: 2),
            Expanded(
                child: GestureDetector(
              onTap: () => setState(() => _page = 2),
              child: Center(
                  child: Text('COMPLETED',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold))),
            )),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 100 * 20,
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.fitWidth,
          image: AssetImage('assets/background.png'),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 40),
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ProfilePage()),
                    );
                  },
                  child: buildIcon('profile'),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset('assets/images/logo.png', height: 40),
                      const Divider(
                        indent: 0,
                        thickness: 2,
                        endIndent: 110,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 10),
                buildIcon('notification'),
                SizedBox(width: 10),
                buildIcon('wallet'),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                "Hello, Admin ",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildContext() {
    return Container(
      height: 200,
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
              blurRadius: 5,
              spreadRadius: 2,
              color: Colors.black38,
              offset: Offset(-1, 1))
        ],
      ),
      child: Column(
        children: [
          _buildTopRow(),
          _buildCenterContent(),
          _buildBtmRow(),
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
                    stops: [.5, .5],
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight,
                    colors: [
                      Color.fromRGBO(158, 32, 27, 1),
                      Colors.transparent, // top Right part
                    ],
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(right: 5.0),
            child: Text("02:00",
                style: TextStyle(
                    color: Colors.black, fontWeight: FontWeight.bold)),
          )
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

  Widget _buildBtmRow() {
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
          _buildBtnChip('assets/flag.png', 'ENTER', true),
        ],
      ),
    );
  }

  Widget _buildBtnChip(String assets, String text, [bool navigate = false]) {
    return Expanded(
      child: GestureDetector(
        onTap: navigate
            ? () {
                // Navigate to ContestPage when "ENTER" is clicked
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ContestPage()),
                );
              }
            : null, // No action if navigate is false
        child: SizedBox(
          height: 30,
          child: ColoredBox(
            color: Color.fromRGBO(47, 50, 95, 1),
            child: ColoredBox(
              color:
                  navigate ? Colors.white.withOpacity(0.4) : Colors.transparent,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(assets, height: 14, width: 14),
                  SizedBox(width: 5),
                  Text(text,
                      style: TextStyle(color: Colors.white, fontSize: 11))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
