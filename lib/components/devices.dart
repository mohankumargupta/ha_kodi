import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ha_kodi/providers/websockets.dart';

class Devices extends ConsumerWidget {
  const Devices({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final deviceMessage = ref.watch(deviceListProvider);
    final _hadevices = ref.watch(haDeviceStreamProvider);

    return Column(
      children: deviceMessage.map((e) => Text(e)).toList(),

      /*devices
            .map((e) => Text(
                  e,
                  style: TextStyle(fontSize: 28.0),
                ))
            .toList()
            */
    );
  }
}
