import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ha_kodi/models/home_sidebar.dart';

@immutable
class SidebarSelection {
  final int selection;
  final int totalSidebarItem;

  const SidebarSelection(
      {required this.selection, required this.totalSidebarItem});

  /*
  SidebarSelection copyWith({int? selection}) {
    return SidebarSelection(selection: selection ?? 0);
  }
  */
}

class SidebarNotifier extends StateNotifier<int> {
  SidebarNotifier() : super(0);

  void moveUp() {
    int newState = state - 1;
    if (newState < 0) newState = homeSidebarMenuItems.length - 1;
    state = newState;
  }

  void moveDown() {
    int newState = state + 1;
    if (newState >= homeSidebarMenuItems.length) {
      newState = 0;
    }
    state = newState;
  }
}

final sidebarSelectionProvider =
    StateNotifierProvider<SidebarNotifier, int>((ref) => SidebarNotifier());
