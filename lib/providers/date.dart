import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

@immutable
class Date {
  final String date;

  const Date({required this.date});

  static String getCurrentTime() {
    final now = DateTime.now();
    final formattedNow = DateFormat.MMMEd().format(now).replaceAll(",", "");
    return formattedNow;
  }
}

class DateNotifier extends StateNotifier<String> {
  DateNotifier() : super(Date.getCurrentTime());
}

final dateSelectionProvider =
    StateNotifierProvider<DateNotifier, String>((ref) => DateNotifier());
