import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class HomeSidebarMenuItem {
  IconData icon;
  String title;

  HomeSidebarMenuItem({required this.icon, required this.title});
}

final homeSidebarMenuItems = [
  HomeSidebarMenuItem(icon: Icons.home, title: "Dashboard"),
  HomeSidebarMenuItem(icon: Icons.flag, title: "Devices"),
  HomeSidebarMenuItem(icon: Icons.ac_unit, title: "Sensors"),
  HomeSidebarMenuItem(icon: MdiIcons.remoteTv, title: "Controls"),
  HomeSidebarMenuItem(icon: Icons.home, title: "Energy"),
  HomeSidebarMenuItem(icon: Icons.flag, title: "Weather"),
  HomeSidebarMenuItem(icon: Icons.settings, title: "Settings"),
  HomeSidebarMenuItem(icon: Icons.flag, title: "Developer Tools"),
  HomeSidebarMenuItem(icon: Icons.settings, title: "Automations"),
];
