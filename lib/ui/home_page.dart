import 'package:flutter/material.dart';

import 'widgets/side_menu.dart';
import 'widgets/chats_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Nulla'),
          bottom: const TabBar(
              tabs: [
                Tab(text: 'Сообщества'),
                Tab(text: 'Чаты')
              ]
          ),
        ),
        body: SideMenu(
          menuItems: [
            IconButton(
              onPressed: (){
               debugPrint('123');
              },
              icon: const Icon(Icons.co2)
            ),
            IconButton(
                onPressed: (){
                  debugPrint('124');
                },
                icon: const Icon(Icons.dangerous)
            ),
          ],
          child: const TabBarView(
              children: [
                Text('Сообщества'),
                ChatsList()
              ]
          ),
        )
      ),

    );
  }
}