import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: WebView(
        initialUrl: 'your_uri',
        javascriptMode: JavascriptMode.unrestricted,
        navigationDelegate: (NavigationRequest request) async {
          final url = request.url;
          // use for handle intent to open app
          if (url.startsWith('intent://') && Platform.isAndroid) {
            await IntentPluginService.openApp(url);
            return NavigationDecision.prevent;
          }
          return NavigationDecision.navigate;
        },
      ),
    );
  }
}

class IntentPluginService {
  static const platform = MethodChannel('intent_scheme');

  static Future openApp(String url) async {
    try {
      await platform.invokeMethod('openApplication', {'data': url});
    } on PlatformException catch (e) {
      debugPrint(e.toString());
    }
  }
}
