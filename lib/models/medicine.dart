class Medicine {
  final String id;
  final String name;
  final String composition;
  final String uses;
  final String sideEffects;
  final String imageUrl;
  final String manufacturer;
  final String category;
  final double price;

  Medicine({
    required this.id,
    required this.name,
    required this.composition,
    required this.uses,
    required this.sideEffects,
    required this.imageUrl,
    required this.manufacturer,
    required this.price,
    this.category = 'General',
  });

  Map<String, dynamic> toMap() => {
        'name': name,
        'composition': composition,
        'uses': uses,
        'sideEffects': sideEffects,
        'imageUrl': imageUrl,
        'manufacturer': manufacturer,
        'category': category,
        'price': price,
      };

  factory Medicine.fromMap(Map<String, dynamic> data, String docId) {
    return Medicine(
      id: docId,
      name: data['name'] ?? '',
      composition: data['composition'] ?? '',
      uses: data['uses'] ?? '',
      sideEffects: data['sideEffects'] ?? '',
      imageUrl: data['imageUrl'] ?? '',
      manufacturer: data['manufacturer'] ?? '',
      category: data['category'] ?? 'General',
      price: (data['price'] ?? 0.0).toDouble(),
    );
  }
}
