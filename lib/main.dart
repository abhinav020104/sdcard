import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'File Write Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FileWriteScreen(),
    );
  }
}

class FileWriteScreen extends StatefulWidget {
  @override
  _FileWriteScreenState createState() => _FileWriteScreenState();
}

class _FileWriteScreenState extends State<FileWriteScreen> {
  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('File Write Demo'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Enter text to write',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                // Get the directory for the SD card
                Directory? directory = await getExternalStorageDirectory();
                String filePath = '${directory?.path}/data.txt';

                // Write data to the file
                File file = File(filePath);
                await file.writeAsString(_controller.text);

                // Show a dialog to indicate success
                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: Text('Success'),
                    content: Text('Data has been written to the SD card.'),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('OK'),
                      ),
                    ],
                  ),
                );
              },
              child: Text('Write to SD Card'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
