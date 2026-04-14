import '../../core/storage/local_database.dart';

class InMemoryLocalDatabase implements LocalDatabase {
  final Map<String, Map<String, Map<String, dynamic>>> _boxes =
      <String, Map<String, Map<String, dynamic>>>{};

  @override
  Future<void> init() async {}

  @override
  Future<void> put(String box, String key, Map<String, dynamic> value) async {
    final targetBox = _boxes.putIfAbsent(
      box,
      () => <String, Map<String, dynamic>>{},
    );
    targetBox[key] = value;
  }

  @override
  Future<Map<String, dynamic>?> get(String box, String key) async {
    return _boxes[box]?[key];
  }

  @override
  Future<List<Map<String, dynamic>>> getAll(String box) async {
    final targetBox = _boxes[box];
    if (targetBox == null) return <Map<String, dynamic>>[];
    return targetBox.values.toList(growable: false);
  }

  @override
  Future<void> delete(String box, String key) async {
    _boxes[box]?.remove(key);
  }

  @override
  Future<void> clearBox(String box) async {
    _boxes[box]?.clear();
  }
}
