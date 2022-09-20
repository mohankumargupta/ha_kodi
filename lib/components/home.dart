import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ha_kodi/models/home_sidebar.dart';
import 'package:ha_kodi/providers/date.dart';
import 'package:ha_kodi/providers/sidebar.dart';
import 'package:intl/intl.dart';
import 'package:timer_builder/timer_builder.dart';
import 'package:collection/collection.dart';

class MyHomePage extends ConsumerWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int selectedMenu = ref.watch(sidebarSelectionProvider);
    String date = ref.watch(dateSelectionProvider);

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            //listTileTheme: const ListTileThemeData(dense: true),
            textTheme: const TextTheme(
                bodyLarge: TextStyle(color: Colors.white),
                bodyMedium: TextStyle(color: Colors.white),
                bodySmall: TextStyle(color: Colors.white))),
        home: Scaffold(
          body: CallbackShortcuts(
            bindings: {
              const SingleActivator(LogicalKeyboardKey.keyC, control: true):
                  () {
                exit(0);
              },
              const SingleActivator(LogicalKeyboardKey.arrowUp): () {
                ref.read(sidebarSelectionProvider.notifier).moveUp();
              },
              const SingleActivator(LogicalKeyboardKey.arrowDown): () {
                ref.read(sidebarSelectionProvider.notifier).moveDown();
              },
              const SingleActivator(LogicalKeyboardKey.arrowLeft): () {},
              const SingleActivator(LogicalKeyboardKey.arrowRight): () {},
            },
            child: Focus(
              autofocus: true,
              child: DecoratedBox(
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/images/background.png"),
                        fit: BoxFit.cover)),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                        flex: 1,
                        child: ColoredBox(
                          //color: Colors.black.withOpacity(0.5),
                          color: const Color.fromARGB(255, 14, 20, 22),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 1.0, bottom: 10.0, top: 10.0),
                            child: SingleChildScrollView(
                                child: Column(
                                    children: homeSidebarMenuItems
                                        .mapIndexed((index, element) =>
                                            index == selectedMenu
                                                ? HighlightedSidebarMenuItem(
                                                    icon: element.icon,
                                                    title: element.title)
                                                : SidebarMenuItem(
                                                    icon: element.icon,
                                                    title: element.title))
                                        .toList())
                                /*
                              child: Column(children: const [
                                HighlightedSidebarMenuItem(
                                    icon: Icons.home, title: "Devices"),
                                SidebarMenuItem(
                                    icon: Icons.home, title: "Sensors"),
                              ])
                              */

                                ),
                          ),
                        )),
                    Expanded(
                        flex: 4,
                        child: Column(children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: SizedBox(
                                      height: 50.0,
                                      child: TimerBuilder.periodic(
                                        const Duration(seconds: 5),
                                        builder: (BuildContext context) {
                                          final now = DateTime.now();
                                          final formattedNow = DateFormat()
                                              .add_jm()
                                              .format(now)
                                              .replaceAll(",", "");
                                          return Text(
                                            formattedNow,
                                            style:
                                                const TextStyle(fontSize: 38.0),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 8.0, right: 8.0),
                                    child: SizedBox(
                                      height: 40,
                                      child: Text(date,
                                          style:
                                              const TextStyle(fontSize: 20.0)),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ])),
                  ],
                ),

                /*
                Column(
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
                                      Opacity(
                                        opacity: 0.5,
                                        child: SvgPicture.asset(
                                          "assets/images/Home_Assistant_Logo.svg",
                                          alignment: Alignment.topRight,
                                          width: 65.0,
                                        ),
                                      ),
                                      const Padding(
                                        padding: EdgeInsets.only(left: 10.0),
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
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0, vertical: 0.0),
                                child: TimerBuilder.periodic(
                                  const Duration(seconds: 1),
                                  builder: (BuildContext context) {
                                    final now = DateTime.now();
                                    final formattedNow = DateFormat.MMMEd()
                                        .add_jm()
                                        .format(now)
                                        .replaceAll(",", "");
                                    return Text(
                                      formattedNow,
                                      style: const TextStyle(fontSize: 18.0),
                                    );
                                  },
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
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20.0, vertical: 0.0),
                              child: Text("copyight 2022 Mohan Gupta"),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                */
              ),
            ),
          ),
        ));
  }
}

class _SidebarMenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool selected;

  const _SidebarMenuItem(
      {super.key,
      required this.icon,
      required this.title,
      required this.selected});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: ListTile(
          //minVerticalPadding: 0,
          contentPadding: const EdgeInsets.all(0),
          horizontalTitleGap: 15.0,
          dense: true,
          visualDensity: const VisualDensity(horizontal: 0, vertical: 4),
          leading: IconButton(
            color: Colors.white,
            padding: const EdgeInsets.all(12.0),
            onPressed: null,
            icon: Icon(
              icon,
              color: Colors.white.withAlpha(selected ? 240 : 150),
            ),
            iconSize: 40.0,
          ),
          title: Text(
            title,
            style: const TextStyle(
              fontSize: 30.0,
            ),
          ),
          tileColor: Colors.cyan,
          textColor: Colors.white.withAlpha(selected ? 220 : 190)),
    );
  }
}

class HighlightedSidebarMenuItem extends StatelessWidget {
  final IconData icon;
  final String title;

  const HighlightedSidebarMenuItem(
      {super.key, required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
        position: DecorationPosition.background,
        decoration: BoxDecoration(
          color: Colors.lightBlueAccent.withAlpha(160),
        ),
        child: _SidebarMenuItem(icon: icon, title: title, selected: true));
  }
}

class SidebarMenuItem extends StatelessWidget {
  final IconData icon;
  final String title;

  const SidebarMenuItem({super.key, required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    return _SidebarMenuItem(icon: icon, title: title, selected: false);
  }
}
