import '../../../FileData/upload_file_model.dart';

abstract class ProductEvent {}

class ChangeTitle extends ProductEvent {
  ChangeTitle(this.title);
  String title;
}

class ChangeDesc extends ProductEvent {
  ChangeDesc(this.desc);
  String desc;
}

class ChangePrice extends ProductEvent {
  ChangePrice(this.price);
  double price;
}

class ChangeQuantity extends ProductEvent {
  ChangeQuantity(this.quan);
  int quan;
}

class ChangeCategory extends ProductEvent {
  ChangeCategory(this.id);
  String id;
}

class ChangeUser extends ProductEvent {
  ChangeUser(this.id);
  String id;
}

class AddImage extends ProductEvent {
  AddImage(this.link);
  String link;
}

class AddVideo extends ProductEvent {
  AddVideo(this.vidLink, this.imgLink);
  String vidLink;
  String imgLink;
}

class AddUploadImage extends ProductEvent {
  AddUploadImage(this.image);
  UploadFileModel image;
}

class RemoveUploadImage extends ProductEvent {
  RemoveUploadImage(this.image);
  UploadFileModel image;
}

class AddUploadVideo extends ProductEvent {
  AddUploadVideo(this.thumbnailImage, this.video);
  UploadFileModel thumbnailImage;
  UploadFileModel video;
}

class RemoveUploadVideo extends ProductEvent {
  RemoveUploadVideo(this.thumbnailImage, this.video);
  UploadFileModel thumbnailImage;
  UploadFileModel video;
}

class ChangeAttr extends ProductEvent {
  ChangeAttr(this.attr);
  Map<String, dynamic> attr;
}

class ChangeAttrVal extends ProductEvent {
  ChangeAttrVal(this.attrVal);
  Map<String, int> attrVal;
}
