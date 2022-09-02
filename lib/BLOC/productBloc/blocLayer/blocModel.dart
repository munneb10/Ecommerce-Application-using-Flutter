import 'dart:async';
import 'dart:ui';

import 'package:flutter_tst/BLOC/productBloc/RepoLayer/repo.dart';

import '../../../FileData/upload_file_model.dart';
import '../../../ProductImageVideoModels/image_file_model.dart';
import '../../../ProductImageVideoModels/video_file_model.dart';
import '../RepoLayer/repoModel.dart';

enum ProuctUploadStatus { waiting, uploaded, failed }

class blocModel {
  late String title;
  late String desc;
  late double price;
  late int quantity;
  late String category;
  late String user;
  late Map<String, int> attrVal;
  late Map<String, dynamic> attr;
  late ImageFileModel images;
  late VideoFileModel videos;
  late VoidCallback? onProductUploading;
  late VoidCallback? onProductUploaded;
  late ProuctUploadStatus uploadStatus = ProuctUploadStatus.waiting;
  blocModel(
      {required this.title,
      required this.desc,
      required this.price,
      required this.quantity,
      required this.category,
      required this.user,
      required this.images,
      required this.videos,
      required this.attr,
      required this.attrVal});

  void addImage(UploadFileModel image) {
    images.addFile(image);
  }

  blocModel.clone(blocModel original) {
    Map<String, dynamic> newattr = {};
    newattr.addAll(original.attr);
    Map<String, int> newattrval = {};
    newattrval.addAll(original.attrVal);

    title = original.title;
    desc = original.desc;
    price = original.price;
    quantity = original.quantity;
    category = original.category;
    user = original.user;
    images = ImageFileModel.clone(original.images);
    videos = VideoFileModel.clone(original.videos);
    attr = newattr;
    attrVal = newattrval;
  }

  void removeImage(UploadFileModel image) {
    images.removeFile(image);
  }

  void addVideo(UploadFileModel video, UploadFileModel image) {
    videos.addFile(video, image);
  }

  void removeVideo(UploadFileModel video, UploadFileModel image) {
    videos.removeFile(video, image);
  }

  List<Map> getVideos() {
    return videos.getVideos();
  }

  UploadFileModel getImageByIndex(int index) {
    return images.getByIndex(index);
  }

  Map<String, UploadFileModel> getVideoByIndex(int index) {
    return videos.getByIndex(index);
  }

  List<UploadFileModel> getImages() {
    return images.getFiles();
  }

  blocModel copyWith({
    String? title,
    String? desc,
    double? price,
    int? quantity,
    String? category,
    String? user,
    Map<String, int>? attrVal,
    Map<String, dynamic>? attr,
    ImageFileModel? images,
    VideoFileModel? videos,
  }) {
    return blocModel(
        title: title ?? this.title,
        desc: desc ?? this.desc,
        price: price ?? this.price,
        quantity: quantity ?? this.quantity,
        category: category ?? this.category,
        user: user ?? this.user,
        attrVal: attrVal ?? this.attrVal,
        attr: attr ?? this.attr,
        images: images ?? this.images,
        videos: videos ?? this.videos);
  }

  RepoModel toRepo() {
    List<Map<String, String>> videosLink = [];
    for (Map<String, UploadFileModel> videoLink in videos.getVideos()) {
      videosLink.add({
        "thumbnail_image": videoLink['image']!.uploadedFileUrl,
        "video": videoLink['video']!.uploadedFileUrl
      });
    }
    List<String> imagesLink = [];
    for (UploadFileModel img in images.getFiles()) {
      imagesLink.add(img.uploadedFileUrl);
    }
    return RepoModel(
        title: title,
        desc: desc,
        price: price,
        quantity: quantity,
        category: category,
        user: user,
        attr: attr,
        attrVal: attrVal,
        imagesLink: imagesLink,
        videosLink: videosLink);
  }

  Future<void> upload(ProductRepo repo) async {
    Timer timer = Timer.periodic(
        const Duration(milliseconds: 1), (Timer t) => onProductUploading!());
    onProductUploading!();
    await images.uploadImages();
    await videos.uploadVideo();
    repo.uploadProduct(toRepo());
    uploadStatus = ProuctUploadStatus.uploaded;
    timer.cancel();
    onProductUploaded!();
  }
}
