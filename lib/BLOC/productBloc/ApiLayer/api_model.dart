class ApiModel {
  late String title;
  late String desc;
  late int price;
  late int quantity;
  late String category;
  late String user;
  late List<String> imagesLink;
  late List<Map<String, String>> videosLink;
  late Map<String, int> attrVal;
  late Map<String, dynamic> attr;
  ApiModel(
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
  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "Desc": desc,
      "price": price,
      "quantity": quantity,
      "category": category,
      "user": user,
      "attributes": attr,
      "attributesValues": attrVal,
      "images": imagesLink as List<String>,
      "videos": videosLink
    };
  }

  factory ApiModel.fromJson(Map<String, dynamic> data) {
    return ApiModel(
        title: data['title'],
        desc: data['Desc'],
        price: data['price'],
        quantity: data['quantity'],
        category: data['category'],
        user: data['user'],
        attr: data['attributes'],
        attrVal: data['attributesValues'] as Map<String, int>,
        imagesLink: data['images'],
        videosLink: data['videos']);
  }
}
