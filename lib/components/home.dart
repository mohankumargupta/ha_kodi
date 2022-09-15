import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MyHomePage extends ConsumerWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Material(
        child: Column(
      children: [
        ColoredBox(
          color: Colors.black.withOpacity(0.5),
          child: SizedBox(
            height: 65.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                  child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12.0, vertical: 5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SvgPicture.asset(
                            "assets/images/Home_Assistant_Logo.svg",
                            alignment: Alignment.topRight,
                            width: 65.0,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: Text(
                              "Home Assistant KODI",
                              style: TextStyle(fontSize: 25.0),
                            ),
                          )
                        ],
                      )),
                  //child: ListTile(
                  //  contentPadding: EdgeInsets.all(20.0),
                  //  leading: SvgPicture.asset(
                  //    "assets/images/Home_Assistant_Logo.svg",
                  //    alignment: Alignment.centerLeft,
                  //  ),
                  //  title: Text("boo"),
                  //),

                  //child: SvgPicture.asset(
                  //  "assets/images/Home_Assistant_Logo.svg",
                  //  alignment: Alignment.centerLeft,
                  //)
                ),
                Flexible(
                  child: const Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
                    child: Text(
                      "RHS",
                    ),
                  ),
                ),
              ],
            ),
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
              const Expanded(
                  flex: 4,
                  child: Center(
                    child: Text(
                      "maincontent",
                      style: TextStyle(color: Colors.black),
                    ),
                  ))
            ],
          ),
        ),
        ColoredBox(
          color: Colors.black.withOpacity(0.5),
          child: SizedBox(
            height: 65.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: const [
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
                  child: Text("copyight 2022 Mohan Gupta"),
                ),
              ],
            ),
          ),
        ),
      ],
    ));
  }
}
