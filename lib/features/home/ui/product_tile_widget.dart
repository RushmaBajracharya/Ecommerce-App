import 'package:ecommerce_app/features/home/bloc/home_bloc.dart';
import 'package:ecommerce_app/features/home/models/home_product_data_model.dart';
import 'package:flutter/material.dart';

class ProductTile extends StatelessWidget {
  final ProductDataModel productDataModel;
  final HomeBloc homeBloc;
  const ProductTile(
      {super.key, required this.productDataModel, required this.homeBloc});

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 1,
      borderRadius: BorderRadius.circular(16.0),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.0),
            border: Border.all(color: Colors.amber.shade300, width: 2),
            color: Colors.amber.shade200),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16.0),
                  topRight: Radius.circular(16.0)),
              child: Image.network(
                productDataModel.imageUrl,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        productDataModel.name,
                        style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: Colors.black),
                      ),
                      Text(
                        '\$${productDataModel.price}',
                        style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: Colors.black),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                          onPressed: () {
                            homeBloc.add(HomeProductWishlistButtonClickedEvent(
                                clickedProduct: productDataModel));
                          },
                          icon: const Icon(Icons.favorite_border_outlined)),
                      IconButton(
                          onPressed: () {
                            homeBloc.add(HomeProductCartButtonClickedEvent(
                                clickedProduct: productDataModel));
                          },
                          icon: const Icon(Icons.shopping_cart_outlined))
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
