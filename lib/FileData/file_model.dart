// ignore_for_file: non_constant_identifier_names, unused_field, library_prefixes
import 'dart:io';
import 'package:path/path.dart' as fileUtil;
import 'dart:math';

typedef OnUploadProgressCallback = void Function(int sentBytes, int totalBytes);

class FileModel {
  late File _file;
  late String _fileId;
  late int _fileSize;
  String _filePath = '';
  late String _fileName;
  Future<void> initialize(File fileToAdd) async {
    _file = fileToAdd;
    _fileId = Random().nextInt(9220).toString() +
        DateTime.now().millisecondsSinceEpoch.toString() +
        fileToAdd.path;
    _fileSize = await fileToAdd.length();
    _filePath = _file.path;
    _fileName = fileUtil.basename(_file.path);
  }

  File get file => _file;
  String get FileId => _fileId;
  int get FileSize => _fileSize;
  String get FilePath => _filePath;
  String get FileName => _fileName;
}
