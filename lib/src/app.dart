import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:testapp/generated/l10n.dart';

import 'utils/i18n.dart';

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: 'TestApp',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      locale: ref.watch(localProvider),
      localizationsDelegates: S.localizationsDelegates,
      supportedLocales: S.supportedLocales,
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends ConsumerStatefulWidget {
  const MyHomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyHomePageState();
}

class _MyHomePageState extends ConsumerState<MyHomePage> {
  @override
  void initState() {
    super.initState();
  }

  void _switchLanguage(Locale locale) async {
    I18nManager().cacheLanguage(locale, ref);
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(s.home),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              s.helloWorld,
            ),
            Text(
              s.msg_with_param('张三'),
            ),
            const SizedBox(height: 100),
            ...I18nManager().supportedLocales.map((Locale locale) {
              return TextButton(
                key: ValueKey(locale),
                onPressed: () {
                  _switchLanguage(locale);
                },
                child: Text(
                  I18nManager().convert(locale),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
