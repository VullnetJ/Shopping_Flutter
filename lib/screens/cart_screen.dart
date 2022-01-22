import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart.dart' show Cart;
import '../widgets/cart_item.dart';
import '../providers/orders.dart';

class CartScreen extends StatelessWidget {

  static const routeName ='/cart';

  CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(title: Text('Your Cart'),),
      body: Column(
        children: [
          Card(
            margin: EdgeInsets.all(10),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Total', style: TextStyle(fontSize: 18),),
                  Spacer(),

                  Chip(label: Text('\$${cart.totalAmount.toStringAsFixed(2)}'),
                  backgroundColor: Colors.pinkAccent,
                  ),
                  TextButton(
                    onPressed: () {
                      Provider.of<Orders>(context, listen: false).addOrders(
                        cart.items.values.toList(), 
                        cart.totalAmount,
                      );
                      cart.clear();
                    }, 
                    child: Text('Order Now'),
                  ),
                ],
              ),
              ),
            ),
            SizedBox(height: 8,),
          Expanded(child: ListView.builder(
            itemCount: cart.items.length,
            itemBuilder: (ctx, i) =>  CartItem(
              cart.items.values.toList()[i].id,
              cart.items.keys.toList()[i],
              cart.items.values.toList()[i].price,
              cart.items.values.toList()[i].quantity,
              cart.items.values.toList()[i].title,

            ),
          ),
          ),
        ],
      ),
    );
  }
}