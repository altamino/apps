import 'package:flutter/material.dart';

class ListDecoration extends StatelessWidget {
  const ListDecoration({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            border: Border.all(
                color: Colors.blue,
                width: 6
            ),
            borderRadius: const BorderRadius.all(Radius.circular(5))
        ),
        height: 50
    );
  }
}