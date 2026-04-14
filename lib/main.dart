import 'package:flutter/material.dart';

void main() {
  runApp(const AthkarContentSyncCoreApp());
}

class AthkarContentSyncCoreApp extends StatelessWidget {
  const AthkarContentSyncCoreApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Athkar Content Sync Core',
      theme: ThemeData(useMaterial3: true),
      home: const Scaffold(
        body: Center(
          child: Text('athkar_content_sync_core foundation ready'),
        ),
      ),
    );
  }
}
