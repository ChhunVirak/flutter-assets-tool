import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final listUnused = <String>[].obs;

  Future? f;

  Future<void> start() async {
    f = await scan();
  }

  Future<void> stop() async {
    f?.asStream().listen((event) {}).cancel();
  }

  Future scan() async {
    listUnused.clear();
    Directory assdir =
        Directory('/Users/virak/Learning/Dart_Backend/asset_deleter/assets');
    var listasset = assdir.listSync(recursive: true).whereType<File>();

    List<String> assetpaths = [];

    for (var a in listasset) {
      var p = a.path;
      // print(p);
      if (p.endsWith('md') ||
          p.endsWith('svg') ||
          p.endsWith('jpg') ||
          p.endsWith('jpeg')) {
        assetpaths.add(p);
      }
    }

    var dir = Directory('/Users/virak/Learning/Dart_Backend/asset_deleter/lib');
    var listFile = dir.listSync(recursive: true).whereType<File>();
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

    ///list
    // List<String> png = [];
    // List<String> jpg = [];
    // List<String> jpeg = [];
    // List<String> svg = [];

    for (String asset in assetpaths) {
      String sortpath = asset.substring(asset.indexOf('assets'));
      bool yesContain = await iscontain(sortpath);
      if (!yesContain) {
        listUnused.add(sortpath);
        listUnused.refresh();
        // if (sortpath.endsWith('png')) {
        //   png.add(sortpath);
        // }
        // if (sortpath.endsWith('jpg')) {
        //   jpg.add(sortpath);
        // }
        // if (sortpath.endsWith('jpeg')) {
        //   jpeg.add(sortpath);
        // }
        // if (sortpath.endsWith('svg')) {
        //   svg.add(sortpath);
        // }

        debugPrint(sortpath);
      }
    }
  }
}
