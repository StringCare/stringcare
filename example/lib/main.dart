import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stringcare/stringcare.dart';
import 'package:flutter/services.dart' show ByteData, rootBundle;
import 'dart:typed_data';

import 'presenter.dart';
import 'r.dart';

void main() {
  Stringcare.supportedLangs = ["en", "es"];
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
      supportedLocales: [
        Locale('en', 'US'),
        Locale('es', 'ES'),
      ],
      localizationsDelegates: Stringcare.delegates,
      localeResolutionCallback: Stringcare.localeResolutionCallback,
      home: MyAppPage(presenter: widget.presenter)
    );
  }
}

class MyAppPage extends StatefulWidget {
  final Presenter presenter;

  MyAppPage(
      {Key key,
      this.presenter})
      : super(key: key);

  @override
  MyAppPageState createState() => MyAppPageState();
}

class MyAppPageState extends State<MyAppPage> {
  String _platformVersion = 'Unknown';
  Uint8List image;
  String asyncValue = "";

  @override
  void initState() {
    super.initState();
    initPlatformState();
    initImageState();
    Stringcare.translateWithLang("en", R.string.hello_format, values: ["Tom"]).then((value) {
      setState(() {
        asyncValue = value;
      });
    });
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      platformVersion = await Stringcare.platformVersion;
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  Future<void> initImageState() async {
    var data = await Stringcare.revealAsset(R.assets.images_voyager_jpeg);
    setState(() {
      image = data;
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
                        Text(Stringcare.testHash([])),
                        ListTile(
                          title: Text("Test sign"),
                        ),
                        Text(Stringcare.testSign([])),
                        ListTile(
                          title: Text("Lang resource"),
                        ),
                        Text(Stringcare.translate(context, R.string.hello_there)),
                        ListTile(
                          title: Text("Lang pattern resource"),
                        ),
                        Text(Stringcare.translate(context, R.string.hello_format, values: ["Tom"])),
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
                        Text(widget.presenter.sameSignatureTestEmoji
                            .toString()),
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
                        Text(widget.presenter.sameSignatureTestLorem
                            .toString()),
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
                if (image != null)
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
                          Image(
                              width: 400,
                              height: 400,
                              image: MemoryImage(image),
                              fit: BoxFit.fitHeight),
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