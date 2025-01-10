import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:tripleup3x/home/screens/home.dart';
import 'package:flutter/material.dart';
import 'screens/mycon.dart';
import 'screens/more.dart';
import 'screens/wallet.dart';
import 'screens/sidebar.dart'; // Import the Sidebar widget

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _page = 0;
  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  List<Widget> screens = [
    Home(),
    MyCon(),
    WalletPage(),
    MorePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Sidebar(), // Integrate the sidebar (Drawer)
      body: Stack(
        children: [screens[_page], _buildBottomNavbar()],
      ),
    );
  }

  Widget _buildBtmNavItem(String assets, String name, bool visibility) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Visibility(visible: visibility, child: SizedBox(height: 10)),
        Image.asset(assets, height: 30),
        Visibility(
          visible: visibility,
          child: Text(name,
              style: TextStyle(
                  color: Color.fromRGBO(82, 15, 15, 1), fontSize: 12)),
        )
      ],
    );
  }

  Widget _buildBottomNavbar() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: CurvedNavigationBar(
        index: 0,
        height: 75,
        key: _bottomNavigationKey,
        items: <Widget>[
          _buildBtmNavItem('assets/home.png', "Home", _page != 0),
          _buildBtmNavItem('assets/badge.png', "My Contests", _page != 1),
          _buildBtmNavItem('assets/wallet.png', "Wallet", _page != 2),
          _buildBtmNavItem('assets/setting.png', "Setting", _page != 3),
        ],
        animationCurve: Curves.ease,
        backgroundColor: Colors.transparent,
        maxWidth: MediaQuery.of(context).size.width,
        color: Color.fromRGBO(178, 178, 178, 1),
        buttonBackgroundColor: Color.fromRGBO(178, 178, 178, 1),
        onTap: (index) {
          setState(() {
            _page = index;
          });
        },
        letIndexChange: (index) => true,
      ),
    );
  }
}

Widget buildIcon(String asset, [bool colored = true]) {
  return Container(
    width: 45,
    height: 45,
    decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: !colored ? null : Color.fromRGBO(82, 15, 15, 1)),
    child: Center(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Image.asset(
          'assets/$asset.png',
          fit: BoxFit.fill,
          color: !colored ? Colors.black : Colors.white,
        ),
      ),
    ),
  );
}
