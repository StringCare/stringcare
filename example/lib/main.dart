import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stringcare/stringcare.dart';

import 'presenter.dart';
import 'r.dart';

void main() {
  Stringcare().locales = [
    Locale('en', ''),
    Locale('es', ''),
    Locale('es', 'AR'),
    Locale('es', 'ES'),
    Locale('es', 'US')
  ];
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  final presenter = Presenter();

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      navigatorKey: Stringcare().navigatorKey,
      supportedLocales: Stringcare().locales,
      localizationsDelegates: Stringcare().delegates,
      localeResolutionCallback: Stringcare().localeResolutionCallback,
      home: MyAppPage(presenter: widget.presenter),
    );
  }
}

class MyAppPage extends StatefulWidget {
  final Presenter presenter;

  MyAppPage({
    Key? key,
    required this.presenter,
  }) : super(key: key);

  @override
  MyAppPageState createState() => MyAppPageState();
}

class MyAppPageState extends State<MyAppPage> {
  String _platformVersion = 'Unknown';
  String asyncValue = "";

  @override
  void initState() {
    super.initState();
    initPlatformState();
    R.strings.hello_format.getLang("es-ES", values: ["Tom"]).then((value) {
      setState(() {
        asyncValue = value;
      });
    });
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String? platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      platformVersion = await Stringcare().platformVersion;
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    var obEmoji = widget.presenter.obfuscatedEmoji.split(",");
    return Scaffold(
      appBar: AppBar(
        title: const Text('Plugin example app'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(15),
            child: Column(
              children: [
                Text('Running on: $_platformVersion\n'),
                Padding(padding: EdgeInsets.all(8)),
                Material(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0)),
                  child: Container(
                    padding: EdgeInsets.all(15),
                    child: Column(
                      children: [
                        ListTile(
                          title: Text("Test hash"),
                        ),
                        Text(Stringcare().testHash([])),
                        ListTile(
                          title: Text("Test sign"),
                        ),
                        Text(Stringcare().testSign([])),
                        ListTile(
                          title: Text("Lang resource"),
                        ),
                        Text(R.strings.hello_there.string()),
                        ListTile(
                          title: Text("Lang pattern resource"),
                        ),
                        Text(
                          R.strings.hello_format.string(
                            values: ["Tom"],
                          ),
                        ),
                        ListTile(
                          title: Text("Retrieving specific lang"),
                        ),
                        Text(asyncValue),
                        ListTile(
                          title: Text("Obfuscation blank"),
                        ),
                        Text(widget.presenter.obfuscatedBlank),
                        Padding(padding: EdgeInsets.all(8)),
                        ListTile(
                          title: Text("Reveal blank"),
                        ),
                        Text("'${widget.presenter.revealedBlank}'"),
                      ],
                    ),
                  ),
                ),
                Padding(padding: EdgeInsets.all(8)),
                Material(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0)),
                  child: Container(
                    padding: EdgeInsets.all(15),
                    child: Column(
                      children: [
                        ListTile(
                          title: Text("Obfuscation hello"),
                        ),
                        Text(widget.presenter.obfuscatedHello),
                        Padding(padding: EdgeInsets.all(8)),
                        ListTile(
                          title: Text("Reveal hello"),
                        ),
                        Text(widget.presenter.revealedHello),
                      ],
                    ),
                  ),
                ),
                Padding(padding: EdgeInsets.all(8)),
                Material(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0)),
                  child: Container(
                    padding: EdgeInsets.all(15),
                    child: Column(
                      children: [
                        ListTile(
                          title: Text("Obfuscation emojis"),
                        ),
                        Text(obEmoji
                            .getRange(
                                0, obEmoji.length > 30 ? 30 : obEmoji.length)
                            .toString()),
                        Padding(padding: EdgeInsets.all(8)),
                        ListTile(
                          title: Text("Reveal emojis"),
                        ),
                        Text(widget.presenter.revealedEmoji),
                        Padding(padding: EdgeInsets.all(8)),
                        ListTile(
                          title: Text("Signature emojis"),
                        ),
                        Text(widget.presenter.signatureEmoji),
                        Padding(padding: EdgeInsets.all(8)),
                        ListTile(
                          title: Text("Readable obfuscated emojis"),
                        ),
                        Text(widget.presenter.readableEmoji),
                        Padding(padding: EdgeInsets.all(8)),
                        ListTile(
                          title: Text("Same signatureTest"),
                        ),
                        Text(
                            widget.presenter.sameSignatureTestEmoji.toString()),
                        Padding(padding: EdgeInsets.all(8)),
                        ListTile(
                          title: Text("Other signatureTest"),
                        ),
                        Text(widget.presenter.otherSignatureTestEmoji
                            .toString()),
                      ],
                    ),
                  ),
                ),
                Padding(padding: EdgeInsets.all(8)),
                Material(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0)),
                  child: Container(
                    padding: EdgeInsets.all(15),
                    child: Column(
                      children: [
                        ListTile(
                          title: Text("Obfuscation lorem"),
                        ),
                        Text(widget.presenter.obfuscatedLorem
                            .split(",")
                            .getRange(0, 30)
                            .toString()),
                        Padding(padding: EdgeInsets.all(8)),
                        ListTile(
                          title: Text("Reveal lorem"),
                        ),
                        Text(widget.presenter.revealedLorem),
                        Padding(padding: EdgeInsets.all(8)),
                        ListTile(
                          title: Text("Signature lorem"),
                        ),
                        Text(widget.presenter.signatureLorem),
                        Padding(padding: EdgeInsets.all(8)),
                        ListTile(
                          title: Text("Readable obfuscated lorem"),
                        ),
                        Text(widget.presenter.readableLorem),
                        Padding(padding: EdgeInsets.all(8)),
                        ListTile(
                          title: Text("Same signatureTest"),
                        ),
                        Text(
                            widget.presenter.sameSignatureTestLorem.toString()),
                        Padding(padding: EdgeInsets.all(8)),
                        ListTile(
                          title: Text("Other signatureTest"),
                        ),
                        Text(widget.presenter.otherSignatureTestLorem
                            .toString()),
                      ],
                    ),
                  ),
                ),
                Padding(padding: EdgeInsets.all(8)),
                Material(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0)),
                  child: Container(
                    padding: EdgeInsets.all(15),
                    child: Column(
                      children: [
                        ListTile(
                          title: Text("Reveal voyager"),
                        ),
                        ScImageAsset(
                          name: R.assets.images_voyager_jpeg,
                          height: 400,
                          width: 400,
                        ),
                        Container(
                          height: 400,
                          width: 400,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.none,
                              image: ScAssetImageProvider(
                                  R.assets.images_voyager_jpeg),
                              repeat: ImageRepeat.repeat,
                            ),
                          ),
                          child: Text("Voyager"),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(padding: EdgeInsets.all(8)),
                Material(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0)),
                  child: Container(
                    padding: EdgeInsets.all(15),
                    child: Column(
                      children: [
                        ListTile(
                          title: Text("Reveal SVG"),
                        ),
                        ScSvg(
                          R.assets.images_coding_svg,
                          height: 400,
                          width: 400,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
