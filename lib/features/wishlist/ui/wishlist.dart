import 'package:ecommerce_app/features/wishlist/bloc/wishlist_bloc.dart';
import 'package:ecommerce_app/features/wishlist/ui/wishlist_tile_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Wishlist extends StatefulWidget {
  const Wishlist({super.key});

  @override
  State<Wishlist> createState() => _WishlistState();
}

class _WishlistState extends State<Wishlist> {
  final WishlistBloc wishlistBloc = WishlistBloc();
  @override
  void initState() {
    wishlistBloc.add(WishlistInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Wishlist Items',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: BlocConsumer<WishlistBloc, WishlistState>(
        bloc: wishlistBloc,
        listenWhen: (previous, current) => current is WishlistActionState,
        buildWhen: (previous, current) => current is! WishlistActionState,
        listener: (context, state) {},
        builder: (context, state) {
          switch (state.runtimeType) {
            case (WishlistSuccessState):
              final successState = state as WishlistSuccessState;
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10.0,
                            mainAxisSpacing: 10.0,
                            mainAxisExtent: 290),
                    itemCount: successState.wishlistItems.length,
                    itemBuilder: (context, index) {
                      return WishlistTileWidget(
                        productDataModel: successState.wishlistItems[index],
                        wishlistBloc: wishlistBloc,
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
