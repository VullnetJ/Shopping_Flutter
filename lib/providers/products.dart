
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import './product.dart';

class Products with ChangeNotifier{
  // reference to a point in memory, direct access. 
  final List<Product> _items = [
    Product(
      id: 'p1',
      title: 'Great Escavator',
      description: ' An escavator',
      price: 20.99,
      imageUrl:
          'https://cdn.pixabay.com/photo/2021/10/25/17/16/nature-6741602__480.jpg',
    ),
    Product(
      id: 'p2',
      title: 'Iphone 13',
      description: ' A cool iphone',
      price: 820.99,
      imageUrl:
          'https://cdn.pixabay.com/photo/2021/09/25/17/43/iphone-13-6655517__340.jpg',
    ),
    Product(
      id: 'p3',
      title: 'Laptop',
      description: 'A great laptop',
      price: 2029.99,
      imageUrl:
          'https://cdn.pixabay.com/photo/2016/11/21/16/27/laptop-1846277__340.jpg',
    ),
  ];

  final _showFarvoritesOnly = false;

  // return a copy. 
  List<Product> get items {
    if(_showFarvoritesOnly) {
      return _items.where((prodItem) => prodItem.isFavorite).toList();
    }
    return [..._items]; 
     
  } 

  List<Product> get favoriteItems {
    return _items.where((prodItem) => prodItem.isFavorite).toList();
  }


  Product findById(String id) {
    return _items.firstWhere((element) => element.id == id);
  }

  // void showFavoritesOnly(){
  //   _showFarvoritesOnly = true;
  //   notifyListeners();
  // }
  // void showAll() {
  //   _showFarvoritesOnly = false;
  //   notifyListeners();
  // }


  void addProduct(Product product) {
    // _items.add(value);
    // establishes a communication channel between this class and 
    // and widgets are notified. 

    var url = 'https://chat-d5146-default-rtdb.europe-west1.firebasedatabase.app/products.json';
    http.post(Uri.parse(url), body: json.encode({
      'title': product.title,
      'description': product.description,
      'imageUrl': product.imageUrl,
      'price': product.price,
      'isFavorite': product.isFavorite,
    }),);

    final newProduct = Product(
      title: product.title, 
      description: product.description, 
      price: product.price,
      imageUrl: product.imageUrl, 
      id: DateTime.now().toString(),
    );
    _items.add(newProduct);
     notifyListeners();
  }

  void updateProduct (String id, Product newProduct ) {
    final prodIndex =_items.indexWhere((prod) => prod.id == id);
    if(prodIndex >=0) {
      _items[prodIndex] = newProduct;
    notifyListeners();
    } else {
      print('..');
    }
  }
  void deleteProduct(String id) {
    _items.removeWhere((prod) => prod.id==id);
    notifyListeners();
  }

}