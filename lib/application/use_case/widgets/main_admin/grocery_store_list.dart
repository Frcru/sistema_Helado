import 'package:flutter/material.dart';
import 'package:system_delivery/application/use_case/widgets/main_admin/grocery_provider.dart';
import 'package:system_delivery/application/use_case/widgets/main_admin/grocery_store_details.dart';
import 'package:system_delivery/application/use_case/widgets/main_admin/staggered_dual_view.dart';

import 'main_view.dart';

class GroceryStoreList extends StatelessWidget {
  const GroceryStoreList({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = GroceryProvider.of(context)?.bloc;
    return Container(
      padding: EdgeInsets.only(top: cartBarheight + 35, left: 15, right: 15),
      color: backgroundColor,
      child: StaggeredDualView(
        offsetPercent: 0.3,
        aspecRatio: 0.7,
        spacing: 20,
        itemBuilder: (context, index) {
          final product = bloc.catalog[index];
          return GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                PageRouteBuilder(
                  transitionDuration: const Duration(milliseconds: 900),
                  pageBuilder: (context, animation, __) {
                    return FadeTransition(
                      opacity: animation,
                      child: GroceryStoreDetails(
                        product: product,
                        onProductAdded: () {
                          bloc.addProduct(product);
                        },
                      ),
                    );
                  },
                ),
              );
            },
            child: Card(
              clipBehavior: Clip.hardEdge,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              elevation: 10,
              shadowColor: Colors.black54,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Hero(
                        tag: 'list_${product.name}',
                        child: Image.network(
                          product.image,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    Text(
                      '\$${product.price}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      product.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      product.weight,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
        itemCount: bloc!.catalog.length,
      ),
    );
  }
}
