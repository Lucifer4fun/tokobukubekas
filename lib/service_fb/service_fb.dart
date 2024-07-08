import 'package:cloud_firestore/cloud_firestore.dart';

class ServiceFb {
  var db = FirebaseFirestore.instance;

  addcart({String? title, String? price, String? pages}) async {
    print("Cart");
    var dataBuku = {
      "title": title,
      "price": price,
      "pages": pages,
    };
    var hasil = await db.collection("cart").add(dataBuku).then(
          (value) => print("buku masuk cart"),
        );
  }
}
