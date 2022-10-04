import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ha_kodi/models/home_sidebar.dart';
import 'package:ha_kodi/providers/date.dart';
import 'package:ha_kodi/providers/sidebar.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:timer_builder/timer_builder.dart';
import 'package:collection/collection.dart';

import 'devices.dart';

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
                                child: Column(children: [
                              SizedBox(
                                  height: 56.0,
                                  child: Row(children: [
                                    Opacity(
                                      opacity: 0.5,
                                      child: SvgPicture.asset(
                                        "assets/images/Home_Assistant_Logo.svg",
                                        alignment: Alignment.topRight,
                                        width: 65.0,
                                      ),
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.only(left: 28.0),
                                      child: Text("HA Kodi"),
                                    )
                                  ])),
                              Padding(
                                padding: const EdgeInsets.only(
                                    bottom: 36.0, top: 36.0),
                                child: SizedBox(
                                    height: 90.0,
                                    child: Center(
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Expanded(
                                                flex: 1,
                                                child: TextButton(
                                                  onPressed: () {},
                                                  style: TextButton.styleFrom(
                                                      shape:
                                                          const CircleBorder(),
                                                      padding:
                                                          const EdgeInsets.all(
                                                              15.0),
                                                      backgroundColor: Colors
                                                          .lightBlueAccent
                                                          .withAlpha(160)),
                                                  child: Icon(MdiIcons.help,
                                                      color: Colors.white
                                                          .withAlpha(180),
                                                      size: 40.0),
                                                )),
                                            Expanded(
                                                flex: 1,
                                                child: TextButton(
                                                  onPressed: () {},
                                                  style: TextButton.styleFrom(
                                                      shape:
                                                          const CircleBorder(),
                                                      padding:
                                                          const EdgeInsets.all(
                                                              15.0),
                                                      backgroundColor:
                                                          Colors.transparent),
                                                  child: Icon(Icons.settings,
                                                      color: Colors.white
                                                          .withAlpha(160),
                                                      size: 40.0),
                                                )),
                                            Expanded(
                                                flex: 1,
                                                child: TextButton(
                                                  onPressed: () {},
                                                  style: TextButton.styleFrom(
                                                      shape:
                                                          const CircleBorder(),
                                                      padding:
                                                          const EdgeInsets.all(
                                                              15.0),
                                                      backgroundColor:
                                                          Colors.transparent),
                                                  child: Icon(Icons.search,
                                                      color: Colors.white
                                                          .withAlpha(160),
                                                      size: 40.0),
                                                )),
                                          ]),
                                    )),
                              ),
                              ...homeSidebarMenuItems
                                  .mapIndexed((index, element) =>
                                      index == selectedMenu
                                          ? HighlightedSidebarMenuItem(
                                              icon: element.icon,
                                              title: element.title)
                                          : SidebarMenuItem(
                                              icon: element.icon,
                                              title: element.title))
                                  .toList()
                            ])),
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
                          Expanded(
                              child: Padding(
                            padding: const EdgeInsets.only(
                                left: 100.0,
                                right: 200.0,
                                top: 30.0,
                                bottom: 200.0),
                            child: DecoratedBox(
                              decoration: BoxDecoration(color: Colors.black),
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Center(
                                      child: Text("Devices",
                                          style: TextStyle(fontSize: 38.0)),
                                    ),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Devices(),
                                    )
                                  ]),
                            ),
                          ))
                        ])),
                  ],
                ),
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
      {required this.icon, required this.title, required this.selected});

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
