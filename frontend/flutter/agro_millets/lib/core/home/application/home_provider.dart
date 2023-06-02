import 'package:agro_millets/models/millet_item.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final homeProvider =
    ChangeNotifierProvider<HomeProvider>((ref) => HomeProvider());

class HomeProvider extends ChangeNotifier {
  List<MilletItem> _items = [];

  List<MilletItem> getItems() => [..._items];
  List<Map<String,String>> getItemsCategories() => [{'vegetables': 'VEGETABLES'},
    {'fruits': 'FRUITS'},
    {'cereals': 'CEREALS'},
    {'livestock': 'LIVE STOCKS'},
    {'oil': 'OIL SEEDS'},
    {'pulses': 'PULSES'},
    {'cash': 'CASH CROP'},];
  List<Map<String,String>> getQuantityTypes() => [{'kg': 'K.G'},
    {'litre': 'Litre'},
    {'count': 'Count'},
   ];
  void updateItems(List<MilletItem> items) {
    if (listEquals(items, _items)) return;
    _items = items;
    notifyListeners();
  }
}
