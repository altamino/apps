import 'package:flutter/material.dart';

import 'widgets/side_menu.dart';
import 'widgets/chats_list.dart';

import '../main.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  List<Widget> createButtons() {
    List<Widget> widgets = [];
    Future<List<List<String>>> communityInformation = account.getCommunities();
    communityInformation.then((value) {
      for (int i = 0; i < value.length; i++){
        widgets.add(
            IconButton(
                onPressed: () {
                  debugPrint('123');
                },
                icon: const Icon(Icons.directions_boat)
            )
        );
      }
    });

    debugPrint(widgets.toString());
    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Nulla'),
          bottom: const TabBar(
              tabs: [
                Tab(text: 'Посты'),
                Tab(text: 'Чаты')
              ]
          ),
        ),
        body: SideMenu(
          menuItems: createButtons() + [
            IconButton(
                onPressed: () {
                  debugPrint('123');
                },
                icon: const Icon(Icons.add)
            )
          ],
          child: const TabBarView(
              children: [
                Text('Посты'),
                ChatsList()
              ]
          ),
        )
      ),

    );
  }
}