import 'package:chat/providers/cart.dart';
import 'package:chat/providers/product.dart';
import '../providers/product.dart';
import 'package:flutter/material.dart';
import '../screens/product_detail_screen.dart';
import 'package:provider/provider.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({Key? key}) : super(key: key);

 

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: false);
    final cart = Provider.of<Cart>(context, listen: false);
    return Consumer<Product>(
      builder: (context, product, child) => ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: GridTile(
          child: GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed(
                  ProductDetailScreen.routeName, 
                  arguments: product.id,
                 );
              },
              child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
          )),
          header: Text(product.title),
          footer: GridTileBar(
            backgroundColor: Colors.black54,
            leading: Consumer<Product>(
              builder: (context, product, child) => IconButton(
                icon: Icon(product.isFavorite? Icons.favorite : Icons.favorite_border),
                onPressed: () {
                  product.toggleFavoriteStatus();
                },
                color: Colors.deepOrange,
              ),
              child: Text('Never changes'),
            ),
            title: Text(
              product.title,
              textAlign: TextAlign.center,
            ),
            trailing: IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () {
                cart.addItem(product.id, product.price, product.title);
                //ScaffoldMessenger.of(context).hideCurrentSnackBar();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Added to your shopping list', ), 
                    duration: Duration(seconds: 5), 
                    action: SnackBarAction(
                      label: 'UNDO', 
                      onPressed: () {
                        cart.removeItem(product.id);
                      }),
                  ),
                  
                  );
              },
              color: Colors.deepOrange,
            ),
          ),
        ),
      ),
    );
  }
}
