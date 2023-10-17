import 'package:chandlier/data/models/chekcout/checkout_model.dart';
import 'package:chandlier/data/models/universal_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CheckOutService {


  Future<UniversalData> addCheckout({required CheckoutModel checkOutModel}) async {
    try {
      DocumentReference newProduct = await FirebaseFirestore.instance
          .collection("checkout")
          .add(checkOutModel.toJson());

      await FirebaseFirestore.instance
          .collection("checkout")
          .doc(newProduct.id)
          .update({
        "checkoutId": newProduct.id,
      });

      return UniversalData(data: "Checkout added!");
    } on FirebaseException catch (e) {
      return UniversalData(error: e.code);
    } catch (error) {
      return UniversalData(error: error.toString());
    }
  }


  Future<UniversalData> deleteCheckout({required String id}) async {
    try {
      await FirebaseFirestore.instance
          .collection("checkout")
          .doc(id)
          .delete();

      return UniversalData(data: "Checkout deleted!");
    } on FirebaseException catch (e) {
      return UniversalData(error: e.code);
    } catch (error) {
      return UniversalData(error: error.toString());
    }
  }

  Stream<List<CheckoutModel>> getCheckout() =>
      FirebaseFirestore.instance.collection("checkout").snapshots().map(
            (event1) => event1.docs
            .map((doc) => CheckoutModel.fromJson(doc.data()))
            .toList(),
      );
}