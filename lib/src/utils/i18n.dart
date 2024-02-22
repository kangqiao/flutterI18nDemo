import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:testapp/generated/l10n.dart';
import 'package:testapp/src/utils/cache.dart';
import 'package:testapp/src/utils/extension.dart';

final localProvider = StateProvider<Locale>((ref) {
  throw UnimplementedError();
});

class I18nManager {
  I18nManager._internal();
  factory I18nManager() => _instance;
  static final I18nManager _instance = I18nManager._internal();
  static I18nManager get instance => _instance;

  static const cacheKeyLanguageCode = 'language-cache-language_code';
  static const cacheKeyCountryCode = 'language-cache-country_code';

  static const Locale defaultLocale = Locale('zh'); // 默认是intl_zh.arb (繁体)

  List<Locale> get supportedLocales => S.supportedLocales;

  Locale getCacheLocale() {
    final languageCode = CacheManager().getString(cacheKeyLanguageCode);
    if (languageCode != null && languageCode.trim().isNotEmpty) {
      final countryCode = CacheManager().getString(cacheKeyCountryCode);
      final cacheLocale = supportedLocales.firstWhere(
        (item) {
          final itemLang = item.languageCode;
          if (itemLang.equalsIgnoreCase(languageCode)) {
            if ('zh'.equalsIgnoreCase(itemLang)) {
              if (countryCode != null && countryCode.trim().isNotEmpty) {
                // 中文情况下: 如果缓存的countryCode不为空, 则需要精确比较.
                return item.countryCode?.equalsIgnoreCase(countryCode) == true;
              }
            } else {
              return true;
            }
          }
          return false;
        },
        orElse: () => defaultLocale,
      );
      return cacheLocale;
    }
    return defaultLocale;
  }

  Future<void> switchLocale(Locale locale, WidgetRef ref) async {
    final curLocale = ref.read(localProvider);
    if (curLocale != locale) {
      ref.read(localProvider.notifier).state = locale;
      CacheManager().setString(cacheKeyLanguageCode, locale.languageCode);
      CacheManager().setString(cacheKeyCountryCode, locale.countryCode ?? '');
    }
  }

  String convert(Locale locale) {
    if (locale.languageCode.equalsIgnoreCase('en')) {
      return "English";
    } else if (locale.languageCode.equalsIgnoreCase('zh')) {
      final countryCode = locale.countryCode;
      if (countryCode != null && countryCode.equalsIgnoreCase('CN')) {
        return "中文(简体)";
      } else {
        return "中文(繁體)";
      }
    } else {
      return "";
    }
  }
}
