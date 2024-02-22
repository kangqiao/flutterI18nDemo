import 'l10n.dart';

/// The translations for English (`en`).
class SEn extends S {
  SEn([String locale = 'en']) : super(locale);

  @override
  String get home => 'Home';

  @override
  String get helloWorld => 'Hello World!';

  @override
  String get english => 'English';

  @override
  String get chinese_simplified => 'Simplified Chinese';

  @override
  String get chinese_traditional => 'Traditional Chinese';

  @override
  String msg_with_param(Object name) {
    return '$name declined the organization type switch';
  }
}
