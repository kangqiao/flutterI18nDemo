import 'l10n.dart';

/// The translations for Chinese (`zh`).
class SZh extends S {
  SZh([String locale = 'zh']) : super(locale);

  @override
  String get home => '首頁';

  @override
  String get helloWorld => '你好, 世界!';

  @override
  String get english => '英語';

  @override
  String get chinese_simplified => '簡體中文';

  @override
  String get chinese_traditional => '繁體中文';

  @override
  String msg_with_param(Object name) {
    return '$name拒絕了組織類型切換';
  }
}

/// The translations for Chinese, as used in China (`zh_CN`).
class SZhCn extends SZh {
  SZhCn(): super('zh_CN');

  @override
  String get home => '首页';

  @override
  String get helloWorld => '你好, 世界!';

  @override
  String get english => '英语';

  @override
  String get chinese_simplified => '简体中文';

  @override
  String get chinese_traditional => '繁体中文';

  @override
  String msg_with_param(Object name) {
    return '$name拒绝了组织类型切换';
  }
}
