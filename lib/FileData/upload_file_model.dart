import 'dart:io';
import 'package:flutter_tst/FileData/file_model.dart';
import 'package:flutter_tst/utils/upload_file.dart';

class UploadFileModel extends FileModel {
  late FileUploadStatus uploadstatus;
  late int totalSize = 0;
  late int totalUploaded = 0;
  late UploadFile uploadFile;
  String uploadedFileUrl = "";
  UploadFileModel() {
    totalSize = 0;
    totalUploaded = 0;
    uploadFile = UploadFile();
    uploadstatus = FileUploadStatus.waiting;
  }
  UploadFileModel.clone(UploadFileModel original) {
    initialize(original.file);
    uploadstatus = original.uploadstatus;
    totalSize = original.totalSize;
    totalUploaded = original.totalUploaded;
    uploadFile = original.uploadFile;
    uploadedFileUrl = original.uploadedFileUrl;
  }
  @override
  Future<void> initialize(File fileToAdd) async {
    await super.initialize(fileToAdd);
  }

  Future<void> upload() async {
    uploadstatus = FileUploadStatus.started;
    uploadedFileUrl =
        await uploadFile.uploadFile(file, (sentBytes, totalBytes) {
      uploadstatus = FileUploadStatus.uploading;
      totalSize = totalBytes;
      totalUploaded = sentBytes;
    }, (String fileUrl) {
      uploadedFileUrl = fileUrl;
      uploadstatus = FileUploadStatus.uploaded;
    });
  }
}

enum FileUploadStatus { waiting, started, uploading, uploaded, uploaderror }
