// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:system_delivery/application/use_case/widgets/main_admin/frm_main_admin_bloc.dart';
import 'package:system_delivery/application/use_case/widgets/main_admin/grocery_provider.dart';
import 'package:system_delivery/application/use_case/widgets/main_admin/grocery_store_cart.dart';
import 'package:system_delivery/application/use_case/widgets/main_admin/grocery_store_list.dart';
import 'package:system_delivery/application/use_case/widgets/main_admin/main_view.dart';

const backgroundColor = Color.fromARGB(255, 254, 253, 252);
double cartBarheight = 100;
const panelTransition = Duration(milliseconds: 500);

final bloc = GroceryStoreBloc();

void onVerticalGesture(DragUpdateDetails details) {
  print(details.primaryDelta);
  if (details.primaryDelta! < -5) {
    bloc.changeToCart();
  } else if (details.primaryDelta! > 8) {
    bloc.changeToNormal();
  }
}

double getTopForWhitePanel(GroceryState state, Size size) {
  if (state == GroceryState.normal) {
    return -cartBarheight + kToolbarHeight;
  } else if (state == GroceryState.cart) {
    return -(size.height - kToolbarHeight - cartBarheight / 2);
  }
  return 0.0;
}

double getTopForBlackPanel(GroceryState state, Size size) {
  if (state == GroceryState.normal) {
    return size.height - cartBarheight;
  } else if (state == GroceryState.cart) {
    return cartBarheight / 2;
  }
  return 0.0;
}

double getTopForAppBar(GroceryState state) {
  if (state == GroceryState.normal) {
    return 0.0;
  } else if (state == GroceryState.cart) {
    return -cartBarheight;
  }
  return 0.0;
}

class frmMain_admin extends StatefulWidget {
  const frmMain_admin({super.key});

  @override
  State<frmMain_admin> createState() => _frmMain_adminState();
}

class _frmMain_adminState extends State<frmMain_admin> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GroceryProvider(
      bloc: bloc,
      child: AnimatedBuilder(
        animation: bloc,
        builder: (context, _) {
          return Scaffold(
            backgroundColor: Colors.black,
            body: Stack(
              children: [
                AnimatedPositioned(
                  duration: panelTransition,
                  curve: Curves.decelerate,
                  left: 0,
                  right: 0,
                  top: getTopForWhitePanel(bloc.groceryState, size),
                  height: size.height - kToolbarHeight,
                  child: WListaProductos(),
                ),
                AnimatedPositioned(
                  duration: panelTransition,
                  curve: Curves.decelerate,
                  left: 0,
                  right: 0,
                  top: getTopForBlackPanel(bloc.groceryState, size),
                  height: size.height - kToolbarHeight,
                  child: GestureDetector(
                    onVerticalDragUpdate: onVerticalGesture,
                    child: Wcarrito(bloc: bloc),
                  ),
                ),
                AnimatedPositioned(
                  duration: panelTransition,
                  curve: Curves.decelerate,
                  left: 0,
                  right: 0,
                  top: getTopForAppBar(bloc.groceryState),
                  child: AppBarGrocery(),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class WListaProductos extends StatelessWidget {
  const WListaProductos({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(30),
        bottomRight: Radius.circular(30),
      ),
      child: Container(
        decoration: BoxDecoration(
            //color: Color.fromARGB(255, 241, 192, 192),
            ),
        child: GroceryStoreList(),
      ),
    );
  }
}

class Wcarrito extends StatelessWidget {
  const Wcarrito({
    Key? key,
    required this.bloc,
  }) : super(key: key);

  final GroceryStoreBloc bloc;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromARGB(255, 0, 0, 0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: AnimatedSwitcher(
                duration: panelTransition,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 25.0),
                  child: SizedBox(
                    height: kToolbarHeight,
                    child: bloc.groceryState == GroceryState.normal
                        ? Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Carrito',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                              Expanded(
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: Row(
                                      children: List.generate(
                                        bloc.cart.length,
                                        (index) => Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8.0),
                                          child: Stack(
                                            children: [
                                              Hero(
                                                tag:
                                                    'list_${bloc.cart[index].product.name}details',
                                                child: CircleAvatar(
                                                  backgroundColor: Colors.white,
                                                  foregroundImage: NetworkImage(
                                                      bloc.cart[index].product
                                                          .image),
                                                ),
                                              ),
                                              Positioned(
                                                right: 0,
                                                child: CircleAvatar(
                                                  radius: 10,
                                                  backgroundColor: Colors.red,
                                                  child: Text(
                                                    bloc.cart[index].quantity
                                                        .toString(),
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              CircleAvatar(
                                backgroundColor: Color(0xFFF4C459),
                                child: Text(
                                  bloc.totalCartElements().toString(),
                                ),
                              ),
                            ],
                          )
                        : const SizedBox.shrink(),
                  ),
                )),
          ),
          Expanded(child: GroceryStoreCart()),
        ],
      ),
    );
  }
}

class AppBarGrocery extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: kToolbarHeight,
        color: backgroundColor,
        child: Row(
          children: [
            const BackButton(
              color: Colors.black,
            ),
            const SizedBox(
              width: 10,
            ),
            const Expanded(
                child: Text(
              'Helados',
              style: TextStyle(color: Colors.black),
            )),
            IconButton(
              icon: const Icon(Icons.settings),
              // ignore: avoid_returning_null_for_void
              onPressed: () => null,
            )
          ],
        ),
      ),
    );
  }
}
