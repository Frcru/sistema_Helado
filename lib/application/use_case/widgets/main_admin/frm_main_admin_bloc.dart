import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:system_delivery/application/use_case/widgets/main_admin/grocery_product.dart';

//logica de estados
enum GroceryState {
  normal,
  details,
  cart,
}

class GroceryStoreBloc with ChangeNotifier {
  GroceryState groceryState = GroceryState.normal;
  List<GroceryProduct> catalog = List.unmodifiable(groceryProducts);
  List<GroceryProductItem> cart = [];

  void changeToNormal() {
    groceryState = GroceryState.normal;
    notifyListeners();
  }

  void changeToCart() {
    groceryState = GroceryState.cart;
    notifyListeners();
  }

  void deleteProduct(GroceryProductItem productItem) {
    cart.remove(productItem);
    notifyListeners();
  }

  void addProduct(GroceryProduct product) {
    for (GroceryProductItem item in cart) {
      if (item.product.name == product.name) {
        item.increment();
        notifyListeners();
        return;
      }
    }
    cart.add(
      GroceryProductItem(product: product),
    );
    notifyListeners();
  }

  int totalCartElements() => cart.fold<int>(
      0, (previousValue, element) => previousValue + element.quantity);
  double totalPriceElements() => cart.fold<double>(
      0.0,
      (previousValue, element) =>
          previousValue + (element.quantity * element.product.price));
}

//Logica para productos que se van agregando a carrito
class GroceryProductItem {
  GroceryProductItem({this.quantity = 1, required this.product});
  int quantity;
  final GroceryProduct product;

  void increment() {
    quantity++;
  }

  void decrement() {}
}

// Logica de widgets para formularios principales
// class frmMainUtilities {
//   const backgroundColor = Color.fromARGB(255, 254, 253, 252);
// double cartBarheight = 100;
//   const _panelTransition = Duration(milliseconds: 500);

// final bloc = GroceryStoreBloc();

//   void _onVerticalGesture(DragUpdateDetails details) {
//     print(details.primaryDelta);
//     if (details.primaryDelta! < -5) {
//       bloc.changeToCart();
//     } else if (details.primaryDelta! > 8) {
//       bloc.changeToNormal();
//     }
//   }

//   double _getTopForWhitePanel(GroceryState state, Size size) {
//     if (state == GroceryState.normal) {
//       return -cartBarheight + kToolbarHeight;
//     } else if (state == GroceryState.cart) {
//       return -(size.height - kToolbarHeight - cartBarheight / 2);
//     }
//     return 0.0;
//   }

//   double _getTopForBlackPanel(GroceryState state, Size size) {
//     if (state == GroceryState.normal) {
//       return size.height - cartBarheight / 2;
//     } else if (state == GroceryState.cart) {
//       return cartBarheight / 2;
//     }
//     return 0.0;
//   }

//   double _getTopForAppBar(GroceryState state) {
//     if (state == GroceryState.normal) {
//       return 0.0;
//     } else if (state == GroceryState.cart) {
//       return -cartBarheight;
//     }
//     return 0.0;
//   }
// }