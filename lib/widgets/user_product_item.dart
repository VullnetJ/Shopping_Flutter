import '../screens/edit_product_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/products.dart';


class UserProductItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;
  UserProductItem(this.title, this.imageUrl, this.id, {Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      leading: CircleAvatar(
        backgroundImage: imageUrl.isNotEmpty 
        ? NetworkImage(imageUrl)
        : null,
      ),
      
      trailing: Container(
        width: 100,
        child: Row(
          children: [
            IconButton(
              onPressed: (){
                Navigator.of(context).pushNamed(EditProductScreen.routeName, arguments: id);
              }, 
              icon: Icon(Icons.edit), color: Theme.of(context).primaryColor),
            IconButton(
              onPressed: (){
                Provider.of<Products>(context, listen: false).deleteProduct(id);
              }, 
              icon: Icon(Icons.delete),color: Theme.of(context).errorColor)
        ],),
      ),
    );
  }
}