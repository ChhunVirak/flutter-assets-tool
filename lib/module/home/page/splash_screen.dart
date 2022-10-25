import 'package:flutter/material.dart';
import 'package:flutter_project_tools/module/home/page/homepage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage('assets/splasgh_screen.jpeg'), //bg
        ),
      ),
      child: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          color: Colors.black12,
        ),
        child: GridView.count(
          padding: const EdgeInsets.all(20),
          shrinkWrap: true,
          childAspectRatio: 16 / 9,
          mainAxisSpacing: 20,
          crossAxisCount: 5,
          crossAxisSpacing: 20,
          children: listMenu
              .map(
                (e) => ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Material(
                    color: Colors.black.withOpacity(0.1),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const HomePage(),
                            ));
                      },
                      child: Ink(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.white10),
                        ),
                        child: const Center(
                          child: Text('Assets'),
                        ),
                      ),
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      ),
    )

        // Stack(
        //   children: [
        //     const SizedBox(
        //       width: double.infinity,
        //       height: double.infinity,
        //     ),
        //     Positioned.fill(
        //       child: Image.asset(
        //         'assets/splasgh_screen.jpeg',
        //         fit: BoxFit.cover,
        //       ),
        //     ),

        //     )
        //   ],
        // ),

        );
  }
}

const listMenu = <String>[
  'Tools',
  'Assets',
  'Project',
  'Tools',
  'Assets',
  'Project',
  'Tools',
  'Assets',
  'Project',
  'Tools',
  'Assets',
  'Project',
  'Tools',
  'Assets',
  'Project',
  'Tools',
  'Assets',
  'Project',
  'Tools',
  'Assets',
  'Project',
  'Tools',
  'Assets',
  'Project',
];
