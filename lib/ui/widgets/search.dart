import 'package:flutter/material.dart';
import 'package:nulla_pc/amino/client.dart';
import 'package:nulla_pc/ui/chat_page.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  SearchState createState() => SearchState();
}

class SearchState extends State<Search> {
  late Future<List<Widget>> _searchResult;
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();

  Future<List<Widget>> _formResult() async {
    List<Widget> result = [];
    Client client = Client();
    Map<String, String> response = await client.searchChats(_searchController.text);

    for(int i = 0; i < result.length; i++) {
      result.add(
        TextButton(
            onPressed: () {
              client.chatId = response.keys.toList()[i];
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) {
                        return const Chat();
                      }
                  )
              );
            },
            child: Text(response.values.toList()[i])
        )
      );
    }
    return result;
  }

  @override
  void initState() {
    super.initState();
    _searchResult = _formResult();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
                child: TextField(
                  controller: _searchController,
                )
            ),
            IconButton(
                onPressed: () {
                  setState(() {
                    _searchResult = _formResult();
                  });
                },
                icon: const Icon(Icons.search)
            )
          ],
        ),
        Expanded(
            child: FutureBuilder<List<Widget>>(
              future: _searchResult,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                      child: CircularProgressIndicator()
                  );
                } else if (snapshot.hasError) {
                  return const Center(
                      child: Text('Error loading messages')
                  );
                } else {
                  List<Widget> results = snapshot.data ?? [];
                  return ListView.builder(
                      itemCount: results.length,
                      controller: _scrollController,
                      itemBuilder: (BuildContext context, int index) {
                        return results[index];
                      }
                  );
                }
              },
            )
        )
      ]
    );
  }
}