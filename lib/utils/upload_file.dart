// import 'dart:html';
import 'dart:async';
import 'dart:io';
import 'package:flutter_tst/utils/host.dart';
import 'package:dio/dio.dart';

class FailedToUpload implements Exception {}

typedef OnUploadProgressCallback = void Function(int sentBytes, int totalBytes);
typedef OnUpload = void Function(String fileName);

class UploadFile {
  Future<String> uploadFile(File fileToUpload,
      OnUploadProgressCallback uploadprogress, OnUpload onUpload) async {
    Dio dio = Dio();
    FormData formdata = FormData.fromMap(
        {"image": await MultipartFile.fromFile(fileToUpload.path)});
    var response = await dio.post(
        'http://${port.portnumber}:3000/fileupload/addfile',
        data: formdata, onSendProgress: (int sent, int total) {
      uploadprogress(sent, total);
      // String percentage = (sent / total * 100).toStringAsFixed(2);
      // var progress =
      //     "$sent Bytes of $total Bytes - " + percentage + " % uploaded";
      // print(progress);
      //update the progress
    }, options: Options(headers: {'Content-Type': 'multipart/form-data'}));

    if (response.statusCode == 200) {
      onUpload(response.data);
      return response.data;
      //print response from server
    } else {
      print("Error during connection to server.");
    }
    return '';
  }
}
