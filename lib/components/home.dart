import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MyHomePage extends ConsumerWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Material(
        child: Column(
      children: [
        SizedBox(
          height: 50.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
                child: Text("LHS"),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
                child: Text("RHS"),
              ),
            ],
          ),
        ),
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: ColoredBox(
                      color: Colors.blueGrey.withOpacity(0.2),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: SingleChildScrollView(
                          child: Column(children: const [
                            ListTile(
                                leading: Icon(Icons.home),
                                title: Text(
                                  "Areas",
                                  style: TextStyle(fontSize: 30.0),
                                ),
                                tileColor: Colors.cyan,
                                iconColor: Colors.white,
                                textColor: Colors.white),
                            ListTile(
                              leading: Icon(Icons.home),
                              title: Text("Devices"),
                            ),
                          ]),
                        ),
                      ),
                    ),
                  )),
              const Expanded(flex: 4, child: Center(child: Text("maincontent")))
            ],
          ),
        ),
        SizedBox(
          height: 40.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: const [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
                child: Text("copyight 2022 Mohan Gupta"),
              ),
            ],
          ),
        ),
      ],
    ));
  }
}
