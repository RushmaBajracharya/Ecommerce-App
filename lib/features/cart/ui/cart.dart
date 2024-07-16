import 'package:ecommerce_app/features/cart/bloc/cart_bloc.dart';
import 'package:ecommerce_app/features/cart/ui/cart_tile_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  final CartBloc cartBloc = CartBloc();
  @override
  void initState() {
    cartBloc.add(CartInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Cart Items',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: BlocConsumer<CartBloc, CartState>(
        bloc: cartBloc,
        listener: (context, state) {},
        listenWhen: (previous, current) => current is CartActionState,
        buildWhen: (previous, current) => current is! CartActionState,
        builder: (context, state) {
          switch (state.runtimeType) {
            case const (CartSuccessState):
              final successState = state as CartSuccessState;
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10.0,
                            mainAxisSpacing: 10.0,
                            mainAxisExtent: 290),
                    itemCount: successState.cartItems.length,
                    itemBuilder: (context, index) {
                      return CartTileWidget(
                        productDataModel: successState.cartItems[index],
                        cartBloc: cartBloc,
                      );
                    }),
              );

            default:
          }
          return Container();
        },
      ),
    );
  }
}
