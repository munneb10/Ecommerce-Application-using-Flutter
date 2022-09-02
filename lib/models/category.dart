class Category {
  final int categoryId;
  final String categoryName;
  final int productCount;
  const Category(
      {required this.categoryId,
      required this.categoryName,
      required this.productCount});
  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
        categoryId: json['category_id'],
        categoryName: json['category_name'],
        productCount: json['total_products']);
  }
}
