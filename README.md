# Student Grade Calculator

A Dart command-line application that reads student data from an Excel file, calculates letter grades based on numerical scores, and displays the results.

## Features

- Reads student data from Excel (.xlsx) files
- Automatically converts Excel to CSV using Python pandas
- Calculates letter grades (A, B, C, D, F) based on standard grading scale
- Handles missing scores gracefully
- Cleans up temporary files automatically

## Prerequisites

- [Dart SDK](https://dart.dev/get-dart) installed
- Python 3 installed with pandas library:
  ```bash
  pip install pandas openpyxl
  ```

## Installation

1. Clone this repository or download the source code
2. Ensure all prerequisites are installed
3. No additional Dart packages are required (uses only core libraries)

## Usage

### Input File Format

Create an Excel file (`students.xlsx` by default) with the following structure:

| Name       | Score |
|------------|-------|
| John Doe   | 85.5  |
| Jane Smith | 92.0  |
| Bob Johnson| 78.3  |

The Excel file must contain:
- A **'Name'** column for student names
- A **'Score'** column for numerical scores

### Running the Program

Basic usage (uses default 'students.xlsx'):
```bash
dart main.dart
```

Specify a different Excel file:
```bash
dart main.dart path/to/your/file.xlsx
```

### Output Example

```
=== Student Grade Calculator (Dart) ===

John Doe scored 85.5 : Grade B
Jane Smith scored 92.0 : Grade A
Bob Johnson scored 78.3 : Grade C
Alice Brown scored 45.0 : Grade F
Charlie Wilson: No score
```

## Grading Scale

| Score Range | Grade |
|-------------|-------|
| 90 - 100    | A     |
| 80 - 89     | B     |
| 70 - 79     | C     |
| 60 - 69     | D     |
| Below 60    | F     |

## How It Works

1. **Excel Conversion**: Uses Python pandas to convert the input Excel file to CSV format
2. **CSV Parsing**: Reads the CSV file and parses headers and data rows
3. **Grade Calculation**: Converts scores to letter grades using the grading scale
4. **Output**: Displays formatted results for each student
5. **Cleanup**: Automatically removes the temporary CSV file

## Code Structure

- `getGrade()`: Converts numerical score to letter grade
- `processStudent()`: Handles individual student output formatting
- `convertExcelToCsv()`: Uses Python to convert Excel to CSV
- `readCsv()`: Parses CSV file into structured data
- `cleanup()`: Removes temporary files
- `main()`: Orchestrates the entire process

## Error Handling

- Gracefully handles missing scores
- Validates Excel to CSV conversion
- Cleans up temporary files even on errors
- Handles malformed CSV data

## Limitations

- Requires Python and pandas for Excel conversion
- Assumes standard CSV format with comma separators
- Does not support direct .xlsx parsing in pure Dart

## Customization

You can modify the grading scale by editing the `getGrade()` function:

```dart
String getGrade(double score) {
  // Modify thresholds as needed
  if (score >= 90) return 'A';
  if (score >= 80) return 'B';
  if (score >= 70) return 'C';
  if (score >= 60) return 'D';
  return 'F';
}
```

## License

This project is open source and available under the MIT License.
by Bindzi Kevin Elyse