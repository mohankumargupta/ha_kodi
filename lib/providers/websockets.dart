import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:web_socket_channel/io.dart';

final DEVICE_MESSAGE_ID = 1;

final haWebsocketProvider = Provider((ref) {
  final channel =
      IOWebSocketChannel.connect('ws://192.168.20.98:8123/api/websocket');
  channel.sink.add(
      '{"type":"auth", "access_token": "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiIzZWM3ZDQ5OWRjNDg0NTdhYjAyZmQ5Mjk4MTNmOGY0MCIsImlhdCI6MTY2NDAwMzI2OSwiZXhwIjoxOTc5MzYzMjY5fQ.C3U4RkiPgHYCj7Brd2OGvNqS_aIoXFI0q7G2sMm2T4U"}');
  channel.sink
      .add('{"type": "config/device_registry/list", "id":$DEVICE_MESSAGE_ID }');

  ref.onDispose(() => channel.sink.close());
  return channel;
});

final haDeviceStreamProvider = StreamProvider((ref) async* {
  final ws = ref.watch(haWebsocketProvider).stream.asBroadcastStream();

  await for (final value in ws) {
    yield value.toString();
  }
});

class DeviceListNotifier extends StateNotifier<String> {
  DeviceListNotifier(super.state);
}

final deviceListProvider =
    StateNotifierProvider<DeviceListNotifier, String>((ref) {
  final notifier = ref.watch(haDeviceStreamProvider);

  late final DeviceListNotifier returnValue;
  notifier.when(data: (data) {
    returnValue = DeviceListNotifier(data);
  }, error: (e, st) {
    returnValue = DeviceListNotifier("error");
  }, loading: () {
    returnValue = DeviceListNotifier("loading");
  });

  return returnValue;
});
