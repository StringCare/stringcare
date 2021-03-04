import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stringcare/stringcare.dart';

import 'presenter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  final presenter = Presenter();

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';

  @override
  void initState() {
    super.initState();
    initPlatformState();
    widget.presenter.prepareImages();
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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
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
                            title: Text("Obfuscation emojis"),
                          ),
                          Text(widget.presenter.obfuscatedEmoji),
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
                          Text(widget.presenter.obfuscatedLorem),
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
