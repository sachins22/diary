import 'package:diary/src/api_service.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class AddScreen extends StatefulWidget {
  final Function loadEntries;
  const AddScreen({Key? key, required this.loadEntries}) : super(key: key);

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();

  void saveEntry() async {
    final String title = titleController.text.trim();
    final String content = contentController.text.trim();

    if (title.isEmpty || content.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
       const SnackBar(content: Text('Please fill in both the title and content.')),
      );
      return;
    }

    // Generate a unique id
    final String id = const Uuid().v4();

    final Map<String, dynamic> newEntry = {
      'id': id, // Include the id field
      'title': title,
      'content': content,
      'date': DateTime.now().toLocal().toString().split(' ')[0],
    };

    try {
      await ApiService.createEntry(newEntry);
      widget.loadEntries();
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to save entry: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Entry')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 60),
              child: TextField(
                controller: titleController,
                decoration: InputDecoration(labelText: 'Title'),
              ),
            ),
            TextField(
              controller: contentController,
              decoration: InputDecoration(labelText: 'Content'),
              maxLines: null,
              minLines: 5,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: saveEntry,
              child: Text('Save Entry'),
            ),
          ],
        ),
      ),
    );
  }
}
