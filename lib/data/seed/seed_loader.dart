import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;

class SeedLoader {
  const SeedLoader();

  Future<Map<String, dynamic>> loadJsonAsset(String assetPath) async {
    final raw = await rootBundle.loadString(assetPath);
    return jsonDecode(raw) as Map<String, dynamic>;
  }
}
