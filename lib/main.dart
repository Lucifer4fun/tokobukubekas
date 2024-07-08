import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:uts/cart_item/cart_provider.dart';
import 'package:uts/cart_item/cart_page.dart';
import 'package:uts/data.dart';
import 'package:uts/detail.dart';
import 'package:uts/admin/auth_service.dart';
import 'package:uts/ui/screens/login_screen.dart';
import 'firebase_options.dart';
import 'home.dart';
import 'package:uts/splashscreen/splashscreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CartProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Toko Buku Bekas',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
          primarySwatch: Colors.blue,
        ),
        home: const SplashScreen(title: 'Flutter Demo Home Page'),
        routes: {
          '/cart': (context) =>
              CartPage(cart: Provider.of<CartProvider>(context).items),
        },
      ),
    );
  }
}
