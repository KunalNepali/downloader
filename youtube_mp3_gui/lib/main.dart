import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'YouTube MP3 Downloader',
      theme: ThemeData(primarySwatch: Colors.red),
      home: DownloaderScreen(),
    );
  }
}

class DownloaderScreen extends StatefulWidget {
  @override
  _DownloaderScreenState createState() => _DownloaderScreenState();
}

class _DownloaderScreenState extends State<DownloaderScreen> {
  TextEditingController _urlController = TextEditingController();
  String _statusMessage = '';
  bool _isLoading = false;

  Future<void> downloadMp3() async {
    setState(() {
      _isLoading = true;
      _statusMessage = "Downloading...";
    });

    final url = _urlController.text;

    final response = await http.post(
      Uri.parse('http://127.0.0.1:5000/download'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'url': url}),
    );

    setState(() {
      _isLoading = false;
      if (response.statusCode == 200) {
        _statusMessage = 'Download completed!';
      } else {
        _statusMessage = 'Error: ${jsonDecode(response.body)['message']}';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('YouTube to MP3')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Lottie.asset('assets/hb1pvoDfyO.json', height: 150),
            TextField(
              controller: _urlController,
              decoration: InputDecoration(
                labelText: 'YouTube URL',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: downloadMp3,
              child: Text('Download MP3'),
            ),
            SizedBox(height: 20),
            Text(_statusMessage),
            if (_isLoading) CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
