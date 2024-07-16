import 'package:badges/badges.dart';
import 'package:ecommerce_app/features/cart/ui/cart.dart';
import 'package:ecommerce_app/features/home/bloc/home_bloc.dart';
import 'package:ecommerce_app/features/home/ui/product_tile_widget.dart';
import 'package:ecommerce_app/features/wishlist/ui/wishlist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:badges/badges.dart' as badges;

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    homeBloc.add(HomeIntialEvent());
    super.initState();
  }

  final HomeBloc homeBloc = HomeBloc();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      bloc: homeBloc,
      listenWhen: (previous, current) => current is HomeActionState,
      buildWhen: (previous, current) => current is! HomeActionState,
      listener: (context, state) {
        if (state is HomeNavigateToCartPageActionState) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => const Cart()));
        } else if (state is HomeNavigateToWishlistPageActionState) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const Wishlist()));
        } else if (state is HomeProductItemCartedActionState) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: const Center(
                child: Text('Item Added to Cart',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Colors.black))),
            backgroundColor: Colors.amber.shade300,
          ));
        } else if (state is HomeProductItemWishlistedActionState) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: const Center(
                child: Text('Item Added to Wishlist',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Colors.black))),
            backgroundColor: Colors.amber.shade300,
          ));
        }
      },
      builder: (context, state) {
        switch (state.runtimeType) {
          case const (HomeLoadingState):
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );

          case const (HomeLoadedSuccessState):
            final successState = state as HomeLoadedSuccessState;
            return Scaffold(
              appBar: AppBar(
                title: const Text(
                  'Clothing App',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                actions: [
                  badges.Badge(
                    position: BadgePosition.topEnd(top: 0, end: 3),
                    badgeContent: const Text(
                      //'${successState.cartItemCount}',
                      '1',
                      style: TextStyle(color: Colors.white),
                    ),
                    child: IconButton(
                        onPressed: () {
                          homeBloc.add(HomeWishlistButtonNavigateEvent());
                        },
                        icon: const Icon(Icons.favorite_border)),
                  ),
                  badges.Badge(
                    position: BadgePosition.topEnd(top: 0, end: 3),
                    badgeContent: const Text(
                      // '${successState.cartItemCount}',
                      '1',
                      style: TextStyle(color: Colors.white),
                    ),
                    child: IconButton(
                        onPressed: () {
                          homeBloc.add(HomeCartButtonNavigateEvent());
                        },
                        icon: const Icon(Icons.shopping_cart_outlined)),
                  ),
                ],
              ),
              ////end of appbar

              body: Padding(
                padding: const EdgeInsets.all(10.0),
                child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10.0,
                            mainAxisSpacing: 10.0,
                            mainAxisExtent: 290),
                    itemCount: successState.products.length,
                    itemBuilder: (context, index) {
                      return ProductTile(
                          homeBloc: homeBloc,
                          productDataModel: successState.products[index]);
                    }),
              ),
            );

          case const (HomeErrorState):
            return const Scaffold(
              body: Center(
                child: Text('Error'),
              ),
            );
          default:
            return const SizedBox();
        }
      },
    );
  }
}
