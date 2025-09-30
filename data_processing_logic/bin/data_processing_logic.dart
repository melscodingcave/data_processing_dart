import 'dart:io';

void main(List<String> arguments) {
  if (arguments.isEmpty) {
    print('Usage: dart data_processing_logic.dart <inputFile.csv>');
    exit(1);
  }
  final inputFile = arguments.first;
  // print(inputFile);
  // lines = readFile(inputFile)
  final lines = File(inputFile).readAsLinesSync();
  // durationByTag = empty map
  final totalDurationByTag = <String, double>{};
  // lines.removeFirst()
  lines.removeAt(0);
  var totalDuration = 0.0;
  // for (line in lines) {
  for (var line in lines) {
    //   values = line.split(',');
    final values = line.split(',');
    //   duration = values[3];
    final durationStr = values[3].replaceAll('"','');
    final duration = double.parse(durationStr);
    //   tag = values[5];
    final tag = values[5].replaceAll('"', '');
    final previousTotal = totalDurationByTag[tag];
    if (previousTotal == null) {
      totalDurationByTag[tag] = duration;
    } else {
      //   update(durationByTag[tag], duration);
      totalDurationByTag[tag] = previousTotal + duration;
    }
    totalDuration += duration;
    // printAll(durationByTag)
  }
  for (var entry in totalDurationByTag.entries) {
    final durationFormatted = entry.value.toStringAsFixed(1);
    final tag = entry.key == '' ? 'Unallocated' : entry.key;
    print('$tag: ${durationFormatted}h');
  }
  print('Total for all tags: ${totalDuration.toStringAsFixed(1)}h');
}
