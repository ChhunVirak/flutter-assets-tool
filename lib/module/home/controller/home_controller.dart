import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final listUnused = <String>[].obs;

  bool forceStop = false;

  Future<void> start() async {
    await scan();
  }

  Future<void> stop() async {
    forceStop = true;
  }

  Future test() async {
    await Future.delayed(const Duration(seconds: 10));
  }

  Future scan() async {
    forceStop = false;
    listUnused.clear();
    Directory assdir = Directory('/Users/virak/App/cic-app/assets');
    var listasset = assdir.listSync(recursive: true).whereType<File>();

    List<String> assetpaths = [];

    for (var a in listasset) {
      var p = a.path;
      // print(p);
      if (p.endsWith('png') ||
          p.endsWith('svg') ||
          p.endsWith('jpg') ||
          p.endsWith('jpeg')) {
        assetpaths.add(p);
      }
    }

    var dir = Directory('/Users/virak/App/cic-app/lib');
    var listFile = dir.listSync(recursive: true).whereType<File>();

    ///check path in all file
    Future<bool> iscontain(String sortpath) async {
      for (var a in listFile) {
        var p = a.path;
        if (p.endsWith('dart')) {
          var content = await File(p).readAsString();
          // for (var line in content) {}
          bool contain = content.contains(sortpath);
          if (contain) {
            return true;
          }
        }
      }
      return false;
    }

    ///scan every assets
    for (String asset in assetpaths) {
      if (!forceStop) {
        debugPrint('start');
        String sortpath = asset.substring(asset.indexOf('assets'));
        bool yesContain = await iscontain(sortpath);
        if (!yesContain) {
          listUnused.add(sortpath);
          listUnused.refresh();

          debugPrint(sortpath);
        }
      } else {
        break;
      }
    }
  }
}
