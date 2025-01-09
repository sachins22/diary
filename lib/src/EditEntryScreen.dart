import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:diary/src/api_service.dart'; // Ensure this import is correct

class EditEntryScreen extends StatefulWidget {
  final Map<String, dynamic> entry;
  const EditEntryScreen({Key? key, required this.entry}) : super(key: key);

  @override
  _EditEntryScreenState createState() => _EditEntryScreenState();
}

class _EditEntryScreenState extends State<EditEntryScreen> {
  late TextEditingController _titleController;
  late TextEditingController _contentController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.entry['title']);
    _contentController = TextEditingController(text: widget.entry['content']);
  }

  Future<void> updateEntry() async {
    final updatedEntry = {
      'title': _titleController.text,
      'content': _contentController.text,
      'date': widget.entry['date'], // Assuming date is unchanged
    };

    await ApiService.updateEntry(widget.entry['_id'], updatedEntry);
    Navigator.pop(context); // Return to the previous screen
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Entry'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: updateEntry,
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: _contentController,
              decoration: InputDecoration(labelText: 'Content'),
              maxLines: 4,
            ),
          ],
        ),
      ),
    );
  }
}
