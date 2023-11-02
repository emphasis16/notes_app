import 'package:flutter/material.dart';

class ShimmerNotes extends StatelessWidget {
  const ShimmerNotes({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ...List.generate(
          6,
          (index) => Container(
            width: MediaQuery.of(context).size.width,
            height: 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.grey,
            ),
            margin: const EdgeInsets.only(bottom: 25),
          ),
        ),
      ],
    );
  }
}
