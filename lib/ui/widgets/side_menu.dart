import 'package:flutter/material.dart';

class SideMenu extends StatelessWidget {
  final Widget child;
  final List<Widget> menuItems;
  const SideMenu({required this.child, required this.menuItems, super.key});

  @override
  Widget build(BuildContext context){
    return Row(
      children: [
        Column(
          children: menuItems,
        ),
        Expanded(child: child)
      ],
    );
  }
}