// ignore_for_file: file_names

import 'package:flutter_tst/BLOC/ApiClients/image_url_api.dart';
import 'package:flutter_tst/FileData/upload_file_model.dart';

class ImageFileModel {
  List<UploadFileModel> _imageFiles = [];
  ImageFileModel();
  ImageFileModel.clone(ImageFileModel original) {
    for (var image in original.getFiles()) {
      _imageFiles.add(UploadFileModel.clone(image));
    }
  }
  void addFile(UploadFileModel fileToAdd) {
    _imageFiles.add(fileToAdd);
  }

  void removeFile(UploadFileModel fileToRemove) {
    _imageFiles.remove(fileToRemove);
  }

  UploadFileModel getByIndex(index) {
    return _imageFiles[index];
  }

  List<UploadFileModel> getFiles() {
    return _imageFiles;
  }

  Future<void> uploadImages() async {
    for (var image in _imageFiles) {
      await image.upload();
    }
  }
}
