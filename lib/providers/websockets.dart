import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:web_socket_channel/io.dart';

import '../components/areas.dart';

const deviceMessageID = 1;
const areaMessageID = 2;
final haIPAddress = "192.168.20.98:8123";

final haWebsocketProvider = Provider((ref) {
  final channel = IOWebSocketChannel.connect('ws://$haIPAddress/api/websocket');
  channel.sink.add(
      '{"type":"auth", "access_token": "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiIzZWM3ZDQ5OWRjNDg0NTdhYjAyZmQ5Mjk4MTNmOGY0MCIsImlhdCI6MTY2NDAwMzI2OSwiZXhwIjoxOTc5MzYzMjY5fQ.C3U4RkiPgHYCj7Brd2OGvNqS_aIoXFI0q7G2sMm2T4U"}');
  channel.sink
      .add('{"type": "config/device_registry/list", "id":$deviceMessageID }');
  channel.sink
      .add('{"type": "config/area_registry/list", "id":$areaMessageID }');

  //ref.onDispose(() => channel.sink.close());
  return channel;
});

final haDeviceStreamProvider = StreamProvider((ref) async* {
  final ws = ref.watch(haWebsocketProvider).stream.asBroadcastStream();

  await for (final value in ws) {
    final Map<String, dynamic> message = jsonDecode(value);
    final messageType = message["type"];
    if (messageType == "result") {
      final int messageID = message["id"];
      final List<dynamic> result = message["result"];

      switch (messageID) {
        case deviceMessageID:
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
          ref.read(deviceListProvider.notifier).replaceList(actualData);
          break;

        case areaMessageID:
          var actualData = <Areas>[];
          for (final area in result) {
            final areaName = area["name"];
            String? picture;
            if (area["picture"] != null) {
              picture = "http://$haIPAddress${area["picture"]}";
            }
            actualData.add(Areas(areaName, picture));
          }

          break;
        default:
          break;
      }
    }

    yield value.toString();
  }
});

class DeviceListNotifier extends StateNotifier<List<String>> {
  DeviceListNotifier(super.state);

  void replaceList(List<String> list) {
    super.state = list;
  }
}

final StateNotifierProvider<DeviceListNotifier, List<String>>
    deviceListProvider =
    StateNotifierProvider<DeviceListNotifier, List<String>>((ref) {
  //final notifier = ref.watch(haDeviceStreamProvider);
  /*   
  late final DeviceListNotifier returnValue;
  notifier.when(data: (data) {
    final Map<String, dynamic> message = jsonDecode(data);
    final messageType = message["type"];

    if (messageType == "result") {
      final int messageID = message["id"];
      final List<dynamic> result = message["result"];

      switch (messageID) {
        case deviceMessageID:
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

          returnValue = DeviceListNotifier(actualData);
          break;
        case areaMessageID:
          returnValue = DeviceListNotifier(["aa"]);
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
  */
  return DeviceListNotifier([]);
});
