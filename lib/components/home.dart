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
              NavigationRail(
                  backgroundColor: Colors.pinkAccent,
                  //labelType: NavigationRailLabelType.all,
                  extended: true,
                  //minExtendedWidth: 300.0,

                  //minWidth: 300.0,
                  selectedIconTheme: const IconThemeData(size: 80),
                  unselectedIconTheme: const IconThemeData(size: 80),
                  destinations: const [
                    NavigationRailDestination(
                        padding: EdgeInsets.only(
                            left: 50.0, right: 50.0, bottom: 20.0, top: 100.0),
                        icon: Icon(Icons.breakfast_dining),
                        label: Padding(
                          padding: EdgeInsets.only(left: 50.0, right: 50.0),
                          child: Text("Area"),
                        )),
                    NavigationRailDestination(
                        padding: EdgeInsets.only(
                            left: 50.0, right: 50.0, bottom: 20.0, top: 20.0),
                        icon: Icon(Icons.devices_other),
                        label: Padding(
                          padding: EdgeInsets.only(left: 50.0, right: 50.0),
                          child: Text("Device"),
                        )),
                  ],
                  selectedIndex: 0),
              const Expanded(child: Text("RHSdasdadasdasdadda"))
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
