import 'dart:io';
// import 'dart:convert';

// ─── Grade Logic ────────────────────────────────────────────────────────────

String getGrade(double score) {
  if (score >= 90) return 'A';
  if (score >= 80) return 'B';
  if (score >= 70) return 'C';
  if (score >= 60) return 'D';
  return 'F';
}

void processStudent(String name, double? score) {
  if (score == null) {
    print('No score for $name');
  } else {
    final grade = getGrade(score);
    print('$name scored $score : Grade $grade');
  }
}

// ─── Excel Reader ───────────────────────────────────────────────
// Dart has no native .xlsx parser, so we read the CSV exported from Excel.

bool convertExcelToCsv(String excelPath, String csvPath) {
  try {
    final result = Process.runSync('python', [
      '-c',
      "import pandas as pd; pd.read_excel('$excelPath').to_csv('$csvPath', index=False)"
    ]);
    if (result.exitCode != 0) {
      print('Error converting Excel to CSV: ${result.stderr}');
      return false;
    }
    return true;
  } catch (e) {
    print('Exception during Excel to CSV conversion: $e');
    return false;
  }
}

void cleanup(String csvPath) {
  try {
    File(csvPath).delete();
  } catch (e) {
    print("Failed to cleanup temporary files");
  }
}

List<Map<String, String?>> readCsv(String path) {
  final lines = File(path).readAsLinesSync();
  if (lines.isEmpty) return [];

  
  final headers = lines.first.split(',').map((h) => h.trim()).toList();
  final rows = <Map<String, String?>>[];

  for (final line in lines.skip(1)) {
    if (line.trim().isEmpty) continue;
    final values = line.split(',').map((v) => v.trim()).toList();
    final row = <String, String?>{};
    for (int i = 0; i < headers.length; i++) {
      final val = i < values.length ? values[i] : '';
      row[headers[i]] = val.isEmpty ? null : val;
    }
    rows.add(row);
  }
  return rows;
}

// ─── Main ────────────────────────────────────────────────────────────────────

void main(List<String> args) {
  if (!convertExcelToCsv(args.isNotEmpty ? args[0] : 'students.xlsx', 'students.csv')) {
    print('Failed to convert Excel to CSV.');
    exit(1);
  }
  
  final csvPath = 'students.csv';

  print('=== Student Grade Calculator (Dart) ===\n');

  final rows = readCsv(csvPath);
  cleanup(csvPath);

  for (final row in rows) {
    final name = row['Name'] ?? 'Unknown';
    final scoreStr = row['Score'];
    final score = (scoreStr != null) ? double.tryParse(scoreStr) : null;
    processStudent(name, score);
  }
}
