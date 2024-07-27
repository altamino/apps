import 'package:flutter/material.dart';
import 'package:nulla_pc/amino/client.dart';

import 'widgets/side_menu.dart';
import 'widgets/chats_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  late Future<List<Widget>> _buttonsFuture;

  @override
  void initState() {
    super.initState();
    _buttonsFuture = _createButtons();
  }

  Future<List<Widget>> _createButtons() async {
    Client client = Client();
    List<Widget> widgets = [];
    Map<String, dynamic> communityInformation = await client.subClients();
    for (int i = 0; i < communityInformation.length; i++) {
      widgets.add(
        IconButton(
          onPressed: () {
            debugPrint('Community button pressed');
          },
          icon: const Icon(Icons.directions_boat),
        ),
      );
    }
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
              Tab(text: 'Чаты'),
            ],
          ),
        ),
        body: FutureBuilder<List<Widget>>(
          future: _buttonsFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return const Center(child: Text('Error loading communities'));
            } else {
              List<Widget> buttons = snapshot.data ?? [];
              return SideMenu(
                menuItems: buttons + [
                  IconButton(
                    onPressed: () {
                      debugPrint('Add button pressed');
                    },
                    icon: const Icon(Icons.add),
                  ),
                ],
                child: const TabBarView(
                  children: [
                    Center(child: Text('Посты')),
                    ChatsList(),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
