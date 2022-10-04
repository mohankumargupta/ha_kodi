import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:web_socket_channel/io.dart';

const deviceMessageID = 1;

final haWebsocketProvider = Provider((ref) {
  final channel =
      IOWebSocketChannel.connect('ws://192.168.20.98:8123/api/websocket');
  channel.sink.add(
      '{"type":"auth", "access_token": "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiIzZWM3ZDQ5OWRjNDg0NTdhYjAyZmQ5Mjk4MTNmOGY0MCIsImlhdCI6MTY2NDAwMzI2OSwiZXhwIjoxOTc5MzYzMjY5fQ.C3U4RkiPgHYCj7Brd2OGvNqS_aIoXFI0q7G2sMm2T4U"}');
  channel.sink
      .add('{"type": "config/device_registry/list", "id":$deviceMessageID }');

  ref.onDispose(() => channel.sink.close());
  return channel;
});

final haDeviceStreamProvider = StreamProvider((ref) async* {
  final ws = ref.watch(haWebsocketProvider).stream.asBroadcastStream();

  await for (final value in ws) {
    yield value.toString();
  }
});

class DeviceListNotifier extends StateNotifier<List<String>> {
  DeviceListNotifier(super.state);
}

final deviceListProvider =
    StateNotifierProvider<DeviceListNotifier, List<String>>((ref) {
  final notifier = ref.watch(haDeviceStreamProvider);

  late final DeviceListNotifier returnValue;
  notifier.when(data: (data) {
    final Map<String, dynamic> message = jsonDecode(data);
    final messageType = message["type"];

    if (messageType == "result") {
      final int messageID = message["id"];
      final List<dynamic> result = message["result"];
      final devices = result
          .where((element) =>
              element["model"] != "Home Assistant Add-on" &&
              element["model"] != null &&
              element["manufacturer"] != "hacs.xyz" &&
              element["manufacturer"] != "Home Assistant")
          .toList();

      var actualData = <String>[];
      for (final device in devices) {
        final name = device["name"];
        final model = device["model"];
        final manufacturer = device["manufacturer"];
        actualData.add('$name $model $manufacturer');
      }

      switch (messageID) {
        case deviceMessageID:
          returnValue = DeviceListNotifier(actualData);
          break;
        default:
          returnValue = DeviceListNotifier([]);
      }
    } else {
      returnValue = DeviceListNotifier([]);
    }
  }, error: (e, st) {
    returnValue = DeviceListNotifier([]);
  }, loading: () {
    returnValue = DeviceListNotifier([]);
  });

  return returnValue;
});
