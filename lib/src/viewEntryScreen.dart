import 'package:flutter/material.dart';



class Viewentryscreen extends StatelessWidget {
  final Map<String, dynamic> entry;
  const Viewentryscreen({Key? key, required this.entry}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(entry['title'])),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(entry['title'],
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text(entry['date'],
                style: TextStyle(fontSize: 14, color: Colors.grey)),
            SizedBox(height: 16),
            Text(entry['content'], style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
