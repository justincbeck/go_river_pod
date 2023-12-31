import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:go_riverpod_poc/router/router.dart';
import 'package:stack_trace/stack_trace.dart' as stack_trace;

Future main() async {
  // turn off the # in the URLs on the web
  usePathUrlStrategy();

  // load .env for Smarty Streets API
  await dotenv.load(fileName: '.env');

  runApp(
    ProviderScope(
      child: Builder(builder: (context) {
        FlutterError.demangleStackTrace = (StackTrace stack) {
          if (stack is stack_trace.Trace) return stack.vmTrace;
          if (stack is stack_trace.Chain) return stack.toTrace().vmTrace;

          return stack;
        };

        return const MyApp();
      }),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      routerConfig: ref.watch(routerProvider),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.indigo),
    );
  }
}
