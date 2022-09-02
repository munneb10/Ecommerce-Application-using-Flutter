import 'package:flutter_tst/BLOC/productBloc/ApiLayer/api_model.dart';

class RepoModel {
  late String title;
  late String desc;
  late double price;
  late int quantity;
  late String category;
  late String user;
  late List<String> imagesLink;
  late List<Map<String, String>> videosLink;
  late Map<String, int> attrVal;
  late Map<String, dynamic> attr;
  RepoModel(
      {required this.title,
      required this.desc,
      required this.price,
      required this.quantity,
      required this.category,
      required this.user,
      required this.imagesLink,
      required this.videosLink,
      required this.attr,
      required this.attrVal});
  ApiModel toApiModel() {
    return ApiModel(
        title: title,
        desc: desc,
        price: price.toInt(),
        quantity: quantity,
        category: category,
        user: user,
        attr: attr,
        attrVal: attrVal,
        imagesLink: imagesLink,
        videosLink: videosLink);
  }
}
