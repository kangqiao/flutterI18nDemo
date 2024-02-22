import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_ume_plus/flutter_ume_plus.dart'; // UME framework
import 'package:flutter_ume_kit_ui_plus/flutter_ume_kit_ui_plus.dart';
import 'package:flutter_ume_kit_device_plus/flutter_ume_kit_device_plus.dart';
import 'package:flutter_ume_kit_perf_plus/flutter_ume_kit_perf_plus.dart';
import 'package:flutter_ume_kit_show_code_plus/flutter_ume_kit_show_code_plus.dart';
import 'package:flutter_ume_kit_console_plus/flutter_ume_kit_console_plus.dart';
import 'package:flutter_ume_kit_dio_plus/flutter_ume_kit_dio_plus.dart';
import 'package:flutter_ume_kit_channel_monitor_plus/flutter_ume_kit_channel_monitor_plus.dart';

import 'src/app.dart';
import 'src/utils/cache.dart';
import 'src/utils/i18n.dart';

final dio = Dio();
Future<void> main() async {
  PluginManager.instance
    ..register(const WidgetInfoInspector())
    ..register(const WidgetDetailInspector())
    ..register(const ColorSucker())
    ..register(AlignRuler())
    ..register(const ColorPicker())
    ..register(const TouchIndicator())
    ..register(Performance())
    ..register(const ShowCode())
    ..register(const MemoryInfoPage())
    ..register(CpuInfoPage())
    ..register(const DeviceInfoPanel())
    ..register(Console())
    ..register(DioInspector(dio: dio))
    ..register(ChannelPlugin());

  await CacheManager().init();

  final locale = I18nManager().getCacheLocale();

  runApp(UMEWidget(
    enable: true,
    child: ProviderScope(
      overrides: [
        localProvider.overrideWith((ref) => locale),
      ],
      child: const MyApp(),
    ),
  ));
}
