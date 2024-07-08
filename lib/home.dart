import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:uts/service_fb/service_fb.dart';
import 'package:uts/ui/main_view.dart';
import 'package:uts/ui/screens/login_screen.dart';
import "package:uts/ui/screens/sing_up_screen.dart";
import 'cart_item/cart_provider.dart';
import 'checkout.dart';
import 'package:uts/searching.dart';
import 'data.dart';
import 'package:uts/upload_buku.dart';
import "package:uts/cart_item/cart_item.dart";
import "package:uts/cart_item/cart_page.dart";

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List<CartItem> cart = [
    CartItem(Book("title", "writer", "price", "image", 3, 1), 3)
  ];

  void removeFromCart(Book book) {
    setState(() {
      cart.removeWhere((item) => item.book == book);
    });
  }

  void viewCart() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CartPage(cart: cart)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      elevation: .5,
      leading: IconButton(
        icon: Icon(Icons.menu),
        onPressed: () {
          _scaffoldKey.currentState?.openDrawer();
        },
      ),
      title: Text('Toko Buku Bekas'),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.search),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SearchPage()),
            );
          },
        ),
        IconButton(
          icon: Icon(Icons.file_upload),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
          },
        ),
        IconButton(
          icon: Icon(Icons.shopping_cart),
          onPressed: viewCart,
        ),
      ],
    );

    createTile(Book book) => Hero(
          tag: book.title,
          child: Material(
            elevation: 15.0,
            shadowColor: Colors.purple.shade900,
            child: InkWell(
              onTap: () {
                // Navigator.pushNamed(context, 'detail/${book.title}');
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => Detail(book),
                  ),
                );
              },
              child: Column(
                children: [
                  Expanded(
                    child: Image(
                      image: AssetImage(book.image),
                      fit: BoxFit.cover,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.add_shopping_cart),
                    onPressed: () async {
                      ServiceFb().addcart(price: book.price, title: book.title);
                      // await Provider.of<CartProvider>(context, listen: false)
                      //     .addToCart(book);
                      // CartPage(cart: [CartItem(book, 1)]);
                    },
                  ),
                ],
              ),
            ),
          ),
        );

    final grid = CustomScrollView(
      primary: false,
      slivers: <Widget>[
        SliverPadding(
          padding: EdgeInsets.all(16.0),
          sliver: SliverGrid.count(
            childAspectRatio: 2 / 3,
            crossAxisCount: 3,
            mainAxisSpacing: 20.0,
            crossAxisSpacing: 20.0,
            children: books.map((book) => createTile(book)).toList(),
          ),
        )
      ],
    );

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Theme.of(context).primaryColor,
      appBar: appBar,
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              child: Center(
                child: Text(
                  'Toko Buku Bekas',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              decoration: BoxDecoration(
                color: Colors.purple.shade900,
              ),
            ),
            ListTile(
              title: Text('Kembali ke Login'),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => Home()),
                );
              },
            ),
            ListTile(
              title: Text('Sign Up'),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => Home()),
                );
              },
            ),
          ],
        ),
      ),
      body: grid,
    );
  }
}
