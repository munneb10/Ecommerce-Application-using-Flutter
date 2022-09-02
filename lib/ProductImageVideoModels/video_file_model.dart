// ignore_for_file: avoid_function_literals_in_foreach_calls
import 'package:flutter_tst/BLOC/ApiClients/video_url_api.dart';
import 'package:flutter_tst/FileData/upload_file_model.dart';

class VideoFileModel {
  late List<Map<String, UploadFileModel>> _videoImageFiles = [];
  VideoUrlApi videoUrlUpload = VideoUrlApi();
  VideoFileModel() {
    _videoImageFiles = [];
  }

  VideoFileModel.clone(VideoFileModel original) {
    for (var vidImg in original.getVideos()) {
      _videoImageFiles.add({
        'video': UploadFileModel.clone(vidImg['video']!),
        'image': UploadFileModel.clone(vidImg['image']!)
      });
    }
  }
  void addFile(UploadFileModel vidFile, UploadFileModel imgFile) {
    _videoImageFiles.add({'video': vidFile, 'image': imgFile});
  }

  void removeFile(UploadFileModel vidFile, UploadFileModel imgFile) {
    for (Map video in _videoImageFiles) {
      if (video['video']?.FileId == vidFile.FileId &&
          video['image']?.FileId == imgFile.FileId) {
        _videoImageFiles.remove(video);
        break;
      }
    }
  }

  Future<void> uploadVideo() async {
    for (var video in _videoImageFiles) {
      await video['video']?.upload();
      await video['image']?.upload();
    }
  }

  Map<String, UploadFileModel> getByIndex(int index) {
    return _videoImageFiles[index];
  }

  List<Map<String, UploadFileModel>> getVideos() {
    return _videoImageFiles;
  }
}
