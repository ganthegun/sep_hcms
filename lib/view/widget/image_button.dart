import 'package:flutter/material.dart';

class ImageButton extends StatelessWidget {
  final String title;
  final String imagePath;
  final Function() callback;

  const ImageButton(
      {super.key,
        required this.title,
        required this.imagePath,
        required this.callback});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: title == "Report"
          ? const EdgeInsets.fromLTRB(30, 30, 30, 0)
          : const EdgeInsets.fromLTRB(30, 30, 0, 0),
      height: 150,
      child: Column(
        mainAxisAlignment:
        MainAxisAlignment.start, // this is the default setting
        children: [
          InkWell(
            onTap: callback,
            borderRadius: BorderRadius.circular(20),
            splashFactory: InkRipple.splashFactory,
            splashColor: Colors.black.withOpacity(0.2),
            child: Ink(
              width: 90,
              height: 90,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 168, 196, 108),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Image.asset(
                imagePath,
                color: Colors.white,
              ),
            ),
          ),
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}