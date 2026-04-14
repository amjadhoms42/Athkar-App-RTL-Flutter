class ExcelSheet {
  const ExcelSheet({
    required this.name,
    required this.headers,
    required this.rows,
  });

  final String name;
  final List<String> headers;
  final List<Map<String, dynamic>> rows;
}

abstract class ExcelWorkbookReader {
  Future<List<ExcelSheet>> readWorkbook(String filePath);
}
