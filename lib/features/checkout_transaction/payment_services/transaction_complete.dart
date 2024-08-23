import 'package:flutter/material.dart';
import 'package:shop_app/features/checkout_transaction/payment_services/pdf_reciept.dart';
import 'package:shop_app/models/cart_items.dart';

  
void onTransactionComplete(BuildContext context, List<CartItem> cartItems ) async {
  
  double totalPrice = 0;

  for (var i = 0; i < cartItems.length; i++) {

    totalPrice += cartItems[i].price;
    
  }

  
  const transactionId = 'TXN123456';
  final purchaseDate = DateTime.now();

  await generatePdfReciept(
      cartItems: cartItems,
      totalPrice: totalPrice,
      transactionId: transactionId,
      purchaseDate: purchaseDate, context: context);
}
