import 'package:flutter/material.dart';
import "dart:math" as math;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Word weight',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  final TextEditingController inp1 = TextEditingController();
  final TextEditingController inp2 = TextEditingController();

  late Animation<double> _animation;

  late AnimationController _animationController;

  int inp1Count = 0, inp2Count = 0;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(duration: const Duration(seconds: 1), vsync: this);
    setRotation(0);
  }

  void setRotation(int degrees) {
    final angle = degrees * math.pi / 180;
    _animation =
        Tween<double>(begin: 0, end: angle).animate(_animationController);
  }

  void findAngle() {
    int angle = inp2Count - inp1Count;
    setRotation(angle);
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Test app"), centerTitle: true),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.4,
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: inp1,
                      maxLines: null,
                      minLines: null,
                      expands: true,
                      textAlignVertical: TextAlignVertical.top,
                      onChanged: (value) {
                        setState(() {
                          inp1Count =
                              value.replaceAll(RegExp("\\s+"), "").length;
                        });
                        findAngle();
                        _animationController.forward();
                      },
                      decoration: const InputDecoration(
                        hintText: "Type here...",
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black, width: 1.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black, width: 1.0),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: TextField(
                      controller: inp2,
                      maxLines: null,
                      minLines: null,
                      expands: true,
                      textAlignVertical: TextAlignVertical.top,
                      onChanged: (value) {
                        setState(() {
                          inp2Count =
                              value.replaceAll(RegExp("\\s+"), "").length;
                        });
                        findAngle();
                        _animationController.forward();
                      },
                      decoration: const InputDecoration(
                        hintText: "Type here...",
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black, width: 1.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black, width: 1.0),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.5,
              alignment: Alignment.center,
              child: AnimatedBuilder(
                animation: _animation,
                child: Container(
                  width: double.infinity,
                  margin: const EdgeInsets.all(10),
                  color: Colors.blue,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        color: Colors.white,
                        margin: const EdgeInsets.all(10),
                        width: 60,
                        padding: const EdgeInsets.all(10),
                        child: Text(
                          inp1Count.toString(),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Container(
                        color: Colors.white,
                        margin: const EdgeInsets.all(10),
                        width: 60,
                        padding: const EdgeInsets.all(10),
                        child: Text(
                          inp2Count.toString(),
                          textAlign: TextAlign.center,
                        ),
                      )
                    ],
                  ),
                ),
                builder: (context, child) => Transform.rotate(
                  angle: _animation.value,
                  child: child,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
