import 'package:flutter/material.dart';
import 'package:system_delivery/application/use_case/widgets/main_admin/grocery_provider.dart';
import 'grocery_provider.dart';

class GroceryStoreCart extends StatelessWidget {
  const GroceryStoreCart({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = GroceryProvider.of(context)!.bloc;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Carrito',
                  style: Theme.of(context).textTheme.headline4!.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: bloc.cart.length,
                    itemBuilder: (context, index) {
                      final item = bloc.cart[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.white,
                              foregroundImage: NetworkImage(item.product.image),
                            ),
                            const SizedBox(width: 15),
                            Text(
                              item.quantity.toString(),
                              style: TextStyle(color: Colors.white),
                            ),
                            const SizedBox(width: 10),
                            Text('x', style: TextStyle(color: Colors.white)),
                            const SizedBox(width: 10),
                            Text(item.product.name,
                                style: TextStyle(color: Colors.white)),
                            Spacer(),
                            Text(('\$ ${item.product.price * item.quantity}'),
                                style: TextStyle(color: Colors.white)),
                            IconButton(
                                icon: Icon(
                                  Icons.delete,
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  bloc.deleteProduct(item);
                                })
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              Text(
                'Total',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Spacer(),
              Text(
                '\$${bloc.totalPriceElements()}',
                style: Theme.of(context).textTheme.headline4!.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Color(0xFFF4C459),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              child: Text(
                'Agregar al carrito',
                style: TextStyle(color: Colors.black),
              ),
            ),
            onPressed: null,
          ),
        ),
      ],
    );
  }
}
