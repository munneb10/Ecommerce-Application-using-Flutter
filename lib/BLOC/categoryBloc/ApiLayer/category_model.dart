class Category {
  String categoryId;
  String categoryName;
  Category({required this.categoryId, required this.categoryName});
  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(categoryId: json['_id'], categoryName: json['category']);
  }
  Map toJson() => {'_id': categoryId, 'category': categoryName};
}
