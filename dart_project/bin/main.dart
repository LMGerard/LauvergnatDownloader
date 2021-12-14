import 'package:http/http.dart';
import 'dart:io';

final path = Platform.environment['USERPROFILE']! + r'\Desktop\Maths\';
void main(List<String> arguments) async {
  final uri =
      Uri.parse('http://ronan.lauvergnat.fr/Enseignements_actuels_RL.html');
  final body = (await get(uri)).body;

  final documents = RegExp("([^\"]*.pdf)")
      .allMatches(body)
      .map((e) => body.substring(e.start, e.end));

  for (var e in documents) {
    print('Downloading $e');
    final url = Uri.parse("http://ronan.lauvergnat.fr/" + e);
    final nPath = url.pathSegments.getRange(0, url.pathSegments.length - 1);
    Directory(path + nPath.join('/')).createSync(recursive: true);

    File(path + url.path).writeAsBytesSync((await get(url)).bodyBytes);
  }
  await Process.start('start', [path], runInShell: true);
}
