class ProductModel {
  final String id;
  final String name;
  final String imageUrl;
  final String category;
  final double price;
  final double rating;
  final int stock;
  final String sellerId;

  const ProductModel({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.price,
    required this.rating,
    required this.category,
    required this.stock,
    required this.sellerId,
  });
}

class CartItem {
  final ProductModel product;
  int quantity;

  CartItem({required this.product, this.quantity = 1});
}

final List<ProductModel> dummyProducts = [
  const ProductModel(
    id: '1',
    name: 'Headphone Bluetooth Pro',
    imageUrl:
        'https://images.unsplash.com/photo-1505740420928-5e560c06d30e',
    price: 450000,
    rating: 4.8,
    category: 'Elektronik',
    stock: 25,
    sellerId: 'seller1',
  ),

  const ProductModel(
    id: '2',
    name: 'Kaos Polos Premium',
    imageUrl:
        'https://images.unsplash.com/photo-1521572163474-6864f9cf17ab',
    price: 85000,
    rating: 4.5,
    category: 'Fashion',
    stock: 100,
    sellerId: 'seller2',
  ),

  const ProductModel(
    id: '3',
    name: 'Sepatu Sneakers Casual',
    imageUrl:
        'https://images.unsplash.com/photo-1549298916-b41d501d3772',
    price: 320000,
    rating: 4.7,
    category: 'Fashion',
    stock: 40,
    sellerId: 'seller3',
  ),

  const ProductModel(
    id: '4',
    name: 'Tas Ransel Laptop',
    imageUrl:
        'https://images.unsplash.com/photo-1553062407-98eeb64c6a62',
    price: 275000,
    rating: 4.6,
    category: 'Aksesoris',
    stock: 60,
    sellerId: 'seller4',
  ),

  const ProductModel(
    id: '5',
    name: 'Smartwatch Series 5',
    imageUrl:
        'https://images.unsplash.com/photo-1516574187841-cb9cc2ca948b',
    price: 890000,
    rating: 4.9,
    category: 'Elektronik',
    stock: 15,
    sellerId: 'seller1',
  ),

  const ProductModel(
    id: '6',
    name: 'Buku Flutter Lengkap',
    imageUrl:
        'https://images.unsplash.com/photo-1512820790803-83ca734da794',
    price: 120000,
    rating: 4.4,
    category: 'Buku',
    stock: 200,
    sellerId: 'seller5',
  ),
];