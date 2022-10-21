import 'dart:io';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project_tools/module/home/controller/home_controller.dart';
import 'package:get/get.dart';
import 'package:path/path.dart' as p;

import '../../../widget/card.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
//  var dir = Directory.;
  final _scanCon = Get.put(HomeController());
  final listNavigation = [];

  String dropdownvalue = '';
  List listDirectory = <String>[].obs;

  final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      // backgroundColor: Colors.transparent,
      body: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(
                width: 100,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.white70)),
                // color: Colors.white,
                child: Column(
                  children: const [
                    FlutterLogo(size: 30),
                    SizedBox(height: 50),
                    NavigateButton(
                      icon: CupertinoIcons.home,
                    ),
                    SizedBox(height: 50),
                    NavigateButton(
                      title: 'All File',
                      icon: CupertinoIcons.folder_fill_badge_person_crop,
                    ),
                    SizedBox(height: 50),
                    // NavigateButton(
                    //   icon: CupertinoIcons.home,
                    // ),
                    // SizedBox(height: 50),
                    // NavigateButton(
                    //   title: 'Recents',
                    //   icon: CupertinoIcons.rectangle_fill_on_rectangle_fill,
                    // ),
                    // SizedBox(height: 50),
                    NavigateButton(
                      title: 'Setting',
                      icon: CupertinoIcons.settings,
                    ),
                    Spacer(),
                    AvatarWidget(),
                    SizedBox(height: 20)
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 12,
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  // var path = await FilePicker.platform.getDirectoryPath();

                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Select Your Flutter Project'),
                          const SizedBox(height: 5),
                          SizedBox(
                            height: 40,
                            width: 150,
                            child: DropdownButtonFormField<String>(
                                onTap: () async {
                                  // String? path =
                                  //     await FilePicker.platform.getDirectoryPath();

                                  List tempList = <String>[];

                                  var pa = Directory(
                                      '/Users/virak/App/flutter_project_tools/');
                                  // var pa = sysPath.basename(path ?? '');//get file name
                                  var li = pa.listSync().whereType<Directory>();
                                  li.map((e) {
                                    String fileName = p.basename(e.path);
                                    tempList.add(fileName);
                                    debugPrint('Path : $fileName');
                                  }).toList();
                                  dropdownvalue = tempList.first;

                                  listDirectory = tempList;

                                  setState(() {});

                                  // initialDirectory: '/Users/virak/App');
                                  // if (path != null && path.isNotEmpty) {
                                  //   _textController.text = path;
                                  //   setState(() {});
                                  // }
                                },
                                elevation: 1,
                                decoration: const InputDecoration(
                                  focusColor: Colors.red,
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 10.0, vertical: 0.0),
                                  enabledBorder: OutlineInputBorder(
                                    //<-- SEE HERE
                                    borderSide: BorderSide(
                                        color: Colors.black, width: 2),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    //<-- SEE HERE
                                    borderSide: BorderSide(
                                        color: Colors.black, width: 2),
                                  ),
                                  filled: true,
                                ),
                                value: dropdownvalue,
                                items: listDirectory
                                    .map<DropdownMenuItem<String>>(
                                        (e) => DropdownMenuItem(
                                              value: e,
                                              child: Text(e),
                                            ))
                                    .toList(),
                                onChanged: (String? value) {
                                  setState(() {
                                    dropdownvalue = value!;
                                  });
                                }),
                          ),
                        ],
                      ),
                      const SizedBox(width: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Select Your Asset Folder'),
                          const SizedBox(height: 5),
                          SizedBox(
                            height: 40,
                            width: 150,
                            child: DropdownButtonFormField<String>(
                                onTap: () {
                                  debugPrint('Work');
                                },
                                elevation: 1,
                                decoration: const InputDecoration(
                                  focusColor: Colors.red,
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 10.0, vertical: 0.0),
                                  enabledBorder: OutlineInputBorder(
                                    //<-- SEE HERE
                                    borderSide: BorderSide(
                                        color: Colors.black, width: 2),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    //<-- SEE HERE
                                    borderSide: BorderSide(
                                        color: Colors.black, width: 2),
                                  ),
                                  filled: true,
                                ),
                                value: dropdownvalue,
                                items: listDirectory
                                    .map<DropdownMenuItem<String>>(
                                        (e) => DropdownMenuItem(
                                              value: e,
                                              child: Text(e),
                                            ))
                                    .toList(),
                                onChanged: (String? value) {
                                  setState(() {
                                    dropdownvalue = value!;
                                  });
                                }),
                          ),
                        ],
                      ),
                    ],
                  ),

                  //left Navigator
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Obx(
                            () => Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: ListView.separated(
                                itemCount: _scanCon.listUnused.length,
                                itemBuilder: (context, index) => CardWidget(
                                  title:
                                      "${index + 1}/. ${_scanCon.listUnused[index]}",
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        title: const Text('Warning'),
                                        content: const Text(
                                            'Are you sure to delete this file?'),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: const Text('Cancel'),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              try {
                                                File('/Users/virak/Learning/Dart_Backend/asset_deleter/${_scanCon.listUnused[index]}')
                                                    .delete()
                                                    .then((value) {
                                                  _scanCon.listUnused
                                                      .removeAt(index);
                                                  Navigator.pop(context);
                                                  _scanCon.listUnused.refresh();
                                                });
                                              } catch (e) {
                                                debugPrint('Error : $e');
                                              }
                                            },
                                            child: const Text('Sure'),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                                separatorBuilder: (context, index) =>
                                    const SizedBox(height: 20),
                              ),
                            ),
                          ),
                        ),
                        const VerticalDivider(
                          thickness: 1,
                          color: Colors.black,
                        ),
                        Expanded(
                          child: Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              child: Column(
                                children: [
                                  ElevatedButton(
                                      onPressed: () {
                                        _scanCon.scan();
                                      },
                                      child: const Text('Start')),
                                  const SizedBox(height: 10),
                                  ElevatedButton(
                                      onPressed: () {
                                        _scanCon.stop();
                                      },
                                      child: const Text('Stop'))
                                ],
                              )),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AvatarWidget extends StatelessWidget {
  const AvatarWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(),
      ),
      child: Column(
        children: [
          const Icon(
            Icons.more_horiz_rounded,
          ),
          const SizedBox(height: 5),
          AspectRatio(
            aspectRatio: 1,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(10),
                image: const DecorationImage(
                  image: NetworkImage(
                      'https://aniyuki.com/wp-content/uploads/2022/06/aniyuki-anime-profile-picture-21.jpg'),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class NavigateButton extends StatelessWidget {
  final IconData? icon;
  final String? title;
  final GestureTapCallback? ontap;
  const NavigateButton({
    Key? key,
    this.icon,
    this.title,
    this.ontap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Column(
        children: [
          Icon(
            icon,
            color: Colors.black,
          ),
          Text(
            title ?? 'Home',
            style: const TextStyle(color: Colors.black),
          ),
        ],
      ),
    );
  }
}
