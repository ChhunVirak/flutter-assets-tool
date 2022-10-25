import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project_tools/module/home/controller/home_controller.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';

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

  String projectPath = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.transparent,
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // var path = await FilePicker.platform.getDirectoryPath();

            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Select Your Flutter Project'),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () async {
                            var a = await FilePicker.platform
                                .getDirectoryPath(lockParentWindow: true);
                            var b = await getTemporaryDirectory();
                            debugPrint('Success $a : ${b.parent.parent.path}');
                          },
                          icon: const Icon(Icons.file_present_rounded),
                        ),
                        SizedBox(
                          height: 35,
                          width: 150,
                          child: TextFormField(
                            onTap: () async {},
                            decoration: const InputDecoration(
                              focusColor: Colors.red,
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 10.0, vertical: 0.0),
                              enabledBorder: OutlineInputBorder(
                                //<-- SEE HERE
                                borderSide:
                                    BorderSide(color: Colors.black, width: 1),
                              ),
                              focusedBorder: OutlineInputBorder(
                                //<-- SEE HERE
                                borderSide:
                                    BorderSide(color: Colors.black, width: 1),
                              ),
                              filled: true,
                            ),
                            onChanged: (value) {
                              setState(() {
                                projectPath = value;
                              });
                            },
                          ),
                        ),
                      ],
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
                      height: 35,
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
                              borderSide:
                                  BorderSide(color: Colors.black, width: 1),
                            ),
                            focusedBorder: OutlineInputBorder(
                              //<-- SEE HERE
                              borderSide:
                                  BorderSide(color: Colors.black, width: 1),
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
                SizedBox(
                  height: 30,
                  child: ElevatedButton(
                      onPressed: () {
                        _scanCon.start();
                      },
                      child: const Text('Start')),
                ),
                const SizedBox(width: 10),
                SizedBox(
                  height: 30,
                  child: ElevatedButton(
                      onPressed: () {
                        _scanCon.stop();
                        // dropdownvalue = '';
                        // listDirectory.clear();
                        // if (projectPath.isNotEmpty) {
                        //   try {
                        //     List tempList = <String>[];

                        //     var pa = Directory(projectPath);
                        //     // var pa = sysPath.basename(path ?? '');//get file name
                        //     var li = pa.listSync().whereType<Directory>();
                        //     li.map((e) {
                        //       String fileName = p.basename(e.path);
                        //       tempList.add(fileName);
                        //       debugPrint('Path : $fileName');
                        //     }).toList();
                        //     if (!tempList.contains('lib')) {
                        //       ScaffoldMessenger.of(context).showSnackBar(
                        //         const SnackBar(
                        //           behavior: SnackBarBehavior.floating,
                        //           content: Text("This isn't a Flutter Project"),
                        //         ),
                        //       );
                        //     } else {
                        //       dropdownvalue = tempList.first;
                        //       listDirectory = tempList;
                        //     }
                        //   } catch (e) {
                        //     ScaffoldMessenger.of(context).showSnackBar(
                        //       SnackBar(
                        //         behavior: SnackBarBehavior.floating,
                        //         content: Text(e.toString()),
                        //       ),
                        //     );
                        //   }
                        // } else {
                        //   ScaffoldMessenger.of(context).showSnackBar(
                        //     const SnackBar(
                        //       behavior: SnackBarBehavior.floating,
                        //       content: Text('Project not found'),
                        //     ),
                        //   );
                        // }

                        // setState(() {});
                      },
                      child: const Text('Stop')),
                )
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
                        padding: const EdgeInsets.symmetric(horizontal: 20),
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
                                            _scanCon.listUnused.removeAt(index);
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
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: Column(
                          children: const [],
                        )),
                  ),
                ],
              ),
            )
          ],
        ),
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
    return IconButton(
      iconSize: 50,
      onPressed: ontap,
      icon: Column(
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
