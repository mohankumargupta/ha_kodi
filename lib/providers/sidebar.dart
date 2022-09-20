import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@immutable
class SidebarSelection {
  final int selection;

  const SidebarSelection({required this.selection});

  SidebarSelection copyWith({int? selection}) {
    return SidebarSelection(selection: selection ?? 0);
  }
}

class SidebarNotifier extends StateNotifier<int> {
  SidebarNotifier() : super(0);
}

final sidebarSelectionProvider =
    StateNotifierProvider<SidebarNotifier, int>((ref) => SidebarNotifier());
