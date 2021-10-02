import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WebViewScreeen extends StatelessWidget {
  late final String url;
  WebViewScreeen(this.url);

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
    );
    // return WebviewScaffold(
    //       url: url,
    //   allowFileURLs : true,
    //       appBar: AppBar(
    //         title:Text("Widget webview"),
    //       ),
    // );
  }
}
