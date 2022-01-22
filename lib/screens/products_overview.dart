import 'package:chat/providers/cart.dart';
import '../widgets/app_drawer.dart';
import 'package:flutter/material.dart';
import '../widgets/products_grid.dart';
import 'package:provider/provider.dart';
import '../widgets/badge.dart';
import './cart_screen.dart';

enum FilterOptions {
  // assigning labels to integers.
  Favorites, 
  All,
}
class ProdcutsOverviewScreen extends StatefulWidget {
  const ProdcutsOverviewScreen({Key? key}) : super(key: key);


  @override
  State<ProdcutsOverviewScreen> createState() => _ProdcutsOverviewScreenState();
}

class _ProdcutsOverviewScreenState extends State<ProdcutsOverviewScreen> {
  
  var _showOnlyFavorites = false;
  
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Business App'),
        actions: <Widget>[
          PopupMenuButton(
            onSelected: (FilterOptions  selectedValue) {
              setState(() {
                if (selectedValue == FilterOptions.Favorites) {
                _showOnlyFavorites = true;
              } else {
                _showOnlyFavorites = false;
              }
              });
            },
            icon: Icon(Icons.more_vert),
            itemBuilder: (_) => [
              PopupMenuItem(child: Text("Only Favorites"), value: FilterOptions.Favorites,),
              PopupMenuItem(child: Text("Show All"), value: FilterOptions.All,),
            ],
          ),
          Consumer<Cart>(
            builder: (_, cart, ch) => Badge( 
              value: cart.itemCount.toString(), 
              color: Colors.orangeAccent, 
              child: ch as Widget,
            ),
              child: IconButton(
                onPressed: (){
                  Navigator.of(context).pushNamed(CartScreen.routeName);
                }, 
                icon: Icon(Icons.shopping_cart)),
           
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: ProductsGrid(_showOnlyFavorites),
    );
  }
}

