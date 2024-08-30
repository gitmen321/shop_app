import 'package:flutter/material.dart';
import 'package:shop_app/models/saved_items.dart';


class SavedProvider with ChangeNotifier {

  final List<SavedItems> _saved = [];


  List<SavedItems> get saved {
    return [..._saved];
  }
  
  void addSaved(String productId, String title, String company, double price, String imageUrl) {
    
    int existingIndex = _saved.indexWhere((item) => item.id == productId);

    if (existingIndex == -1) {
      _saved.add(SavedItems(
        id: productId,
        title: title,
        company: company,
        price: price,
       
        imageUrl: imageUrl,
      ));
    } else {

      _saved.remove(_saved[existingIndex]);
      
      
    }
    notifyListeners();
  }
  void removeSaved(Map<String, Object> productId) {
    _saved.removeWhere((item) => item.id == productId);
    notifyListeners();
}



}
