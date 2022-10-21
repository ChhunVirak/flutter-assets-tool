import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CardWidget extends StatelessWidget {
  final String? title;
  final VoidCallback? onPressed;
  const CardWidget({Key? key, this.title, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      hoverColor: Colors.green,
      title: Text(title ?? 'Unknown'),
      trailing: IconButton(
        onPressed: onPressed,
        icon: const Icon(CupertinoIcons.delete_simple),
      ),
    );
  }
}
