import 'dart:io';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Hive TypeId Integrity Check', () {
    final libDir = Directory('lib/src/models');
    if (!libDir.existsSync()) return;

    final typeIds = <int, String>{};
    final regex = RegExp(r'@HiveType\(typeId:\s*(\d+)\)');

    final files = libDir.listSync(recursive: true).whereType<File>();
    
    for (var file in files) {
      if (!file.path.endsWith('.dart')) continue;
      
      final content = file.readAsStringSync();
      final matches = regex.allMatches(content);

      for (var match in matches) {
        final id = int.parse(match.group(1)!);
        final fileName = file.path.split('/').last;

        if (typeIds.containsKey(id)) {
          fail('Duplicate Hive TypeId detected: $id\n'
               'Found in: $fileName AND ${typeIds[id]}\n'
               'Fix this by changing one of the TypeIds to a unique number.');
        }
        typeIds[id] = fileName;
      }
    }
  });
}
