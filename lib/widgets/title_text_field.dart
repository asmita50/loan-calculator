import 'package:flutter/material.dart';

class TitleTextField extends StatelessWidget {
  const TitleTextField(
      {super.key,
      required this.textEditingController,
      required this.title,
      required this.hintText});
  final TextEditingController textEditingController;
  final String title;
  final String hintText;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title),
        const SizedBox(
          height: 5,
        ),
        SizedBox(
          height: 60,
          child: TextField(
            controller: textEditingController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              fillColor: const Color.fromARGB(176, 206, 208, 206),
              filled: true,
              border: const OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.all(Radius.circular(20.0))),
              hintText: hintText,
            ),
          ),
        ),
      ],
    );
  }
}
