import 'package:diary/src/api_service.dart';
import 'package:flutter/material.dart';
import 'package:diary/src/add_screen.dart';
import 'package:diary/src/viewEntryScreen.dart';

class HomePages extends StatefulWidget {
  const HomePages({Key? key}) : super(key: key);

  @override
  State<HomePages> createState() => _HomePagesState();
}

class _HomePagesState extends State<HomePages> {
  List<Map<String, dynamic>> entries = [];

  @override
  void initState() {
    super.initState();
    loadEntries();
  }

  Future<void> loadEntries() async {
    try {
      final List<dynamic> fetchedEntries = await ApiService.getAllEntries();
      setState(() {
        entries = List<Map<String, dynamic>>.from(fetchedEntries);
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load entries: $e')),
      );
    }
  }

  void deleteSpecificEntry(String id) async {
    try {
      await ApiService.deleteEntry(id);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Entry deleted successfully')),
      );
      loadEntries(); // Refresh entries after deletion
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error deleting entry: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Diary Entries')),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddScreen(loadEntries: loadEntries),
            ),
          ).then((_) => loadEntries()); // Reload entries when returning
        },
        child: Icon(Icons.add),
      ),
      body: entries.isEmpty
          ? Center(child: Text('No diary entries yet. Add one!'))
          : ListView.builder(
              itemCount: entries.length,
              itemBuilder: (context, index) {
                final entry = entries[index];
                return MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: ListTile(
                    title: Text(entry['title']),
                    subtitle: Text(entry['date']),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Viewentryscreen(entry: entry),
                        ),
                      );
                    },
                    trailing: IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        deleteSpecificEntry(entry['id']);
                      },
                    ),
                  ),
                );
              },
            ),
    );
  }
}
