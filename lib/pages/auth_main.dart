import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'email.dart';
import 'mobile.dart';

const kPageTitle = 'Settings';
const kTabFgColor = Colors.white;
const kLabels = ["Mobile", "Email"];
const kTabBgColor = Color.fromRGBO(161, 19, 18, 1);
const kTabActiveBgColor = Color.fromRGBO(221, 63, 53, 1);

class AuthMain extends StatefulWidget {
  const AuthMain({super.key});

  @override
  State<AuthMain> createState() => _AuthMainState();
}

class _AuthMainState extends State<AuthMain>
    with SingleTickerProviderStateMixin {
  late TabController _controller;

  @override
  void initState() {
    _controller = TabController(
      length: 2,
      vsync: this,
      initialIndex: 0,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/background.png',
            fit: BoxFit.cover,
          ),
          Column(
            children: [
              const SizedBox(height: 50),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset('assets/images/logo.png', height: 60),
                      const SizedBox(height: 10),
                      const Divider(
                          color: Colors.white,
                          thickness: 2,
                          indent: 0,
                          endIndent: 240),
                      const Text("Welcome",
                          style: TextStyle(
                            fontSize: 26,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          )),
                      const Text("Sign in to continue",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          )),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ),
              MyTabBar(
                fontSize: 14,
                labels: kLabels,
                controller: _controller,
                backgroundColor: kTabBgColor,
                foregroundColor: kTabFgColor,
                activeForegroundColor: kTabFgColor,
                activeBackgroundColor: kTabActiveBgColor,
              ),
              Expanded(
                child: TabBarView(
                  controller: _controller,
                  physics: const NeverScrollableScrollPhysics(),
                  children: const [
                    MobileView(),
                    EmailView(),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class MyTabBar extends StatefulWidget {
  final double? fontSize;
  final List<String> labels;
  final Color backgroundColor;
  final Color foregroundColor;
  final TabController controller;
  final Color? activeBackgroundColor;
  final Color? activeForegroundColor;

  const MyTabBar({
    super.key,
    this.fontSize,
    required this.labels,
    required this.controller,
    this.activeBackgroundColor,
    this.activeForegroundColor,
    required this.backgroundColor,
    required this.foregroundColor,
  });

  @override
  State<MyTabBar> createState() => _MyTabBarState();
}

class _MyTabBarState extends State<MyTabBar> {
  List<int> ids = [1, 0];

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 100 / 14,
      child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.red, widget.backgroundColor],
        )),
        child: Stack(
          fit: StackFit.expand,
          children: ids.map((id) {
            final active = widget.controller.index == id;
            return MyTab(
                active: active,
                reversed: id == 1,
                label: widget.labels[id],
                fontSize: widget.fontSize!,
                backgroundColor: widget.backgroundColor,
                foregroundColor: widget.foregroundColor,
                activeBackgroundColor: widget.activeBackgroundColor!,
                activeForegroundColor: widget.activeForegroundColor!,
                onTap: () {
                  widget.controller.animateTo(id);
                  ids = ids.reversed.toList();
                  setState(() {});
                });
          }).toList(),
        ),
      ),
    );
  }
}

class MyTab extends StatefulWidget {
  final bool active;
  final bool reversed;
  final String? label;
  final double? fontSize;
  final VoidCallback? onTap;
  final Color backgroundColor;
  final Color foregroundColor;
  final Color? activeBackgroundColor;
  final Color? activeForegroundColor;

  const MyTab({
    super.key,
    this.label,
    this.onTap,
    this.fontSize,
    required this.active,
    this.reversed = false,
    this.activeBackgroundColor,
    this.activeForegroundColor,
    required this.backgroundColor,
    required this.foregroundColor,
  });

  @override
  State<MyTab> createState() => _MyTabState();
}

class _MyTabState extends State<MyTab> {
  Color get bgColor => widget.active
      ? widget.activeBackgroundColor ?? widget.foregroundColor
      : widget.backgroundColor;

  Color get fgColor => widget.active
      ? widget.activeForegroundColor ?? widget.backgroundColor
      : widget.foregroundColor;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: IgnorePointer(
            child: widget.reversed
                ? Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.rotationY(math.pi),
                    child: CustomPaint(
                        painter:
                            MtzCustomPainter(color: [bgColor, Colors.red])),
                  )
                : CustomPaint(
                    painter: MtzCustomPainter(color: [bgColor, Colors.red])),
          ),
        ),
        Align(
          alignment:
              widget.reversed ? Alignment.centerRight : Alignment.centerLeft,
          child: FractionallySizedBox(
            widthFactor: .5,
            heightFactor: 1,
            child: TextButton(
              onPressed: widget.active ? null : widget.onTap,
              child: Text(
                widget.label!,
                style: const TextStyle(
                  decorationThickness: 2,
                  color: Colors.transparent,
                  decorationColor: Colors.white,
                  decoration: TextDecoration.underline,
                  shadows: [Shadow(color: Colors.white, offset: Offset(0, -5))],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class MtzCustomPainter extends CustomPainter {
  final List<Color> color;

  MtzCustomPainter({super.repaint, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    Shader shader = LinearGradient(
      colors: color,
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ).createShader(Rect.fromLTWH(
      0,
      0,
      size.width,
      size.height,
    ));

    Paint paint = Paint()
      ..shader = shader
      ..style = PaintingStyle.fill;

    Path path = Path();
    path.moveTo(0, 0);
    path.lineTo(0, size.height);
    path.lineTo(
      size.width * 0.60,
      size.height,
    );
    path.conicTo(
      size.width * 0.50,
      size.height,
      size.width * 0.50,
      size.height * 0.50,
      2,
    );
    path.conicTo(
      size.width * 0.50,
      0,
      size.width * 0.40,
      0,
      2,
    );
    path.lineTo(0, 0);
    path.close();
    canvas.drawShadow(
      path,
      Colors.black,
      20,
      false,
    );
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
