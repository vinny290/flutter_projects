import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shoppers/models/product.dart';
import 'package:shoppers/utils/custom_theme.dart';

class GridCard extends StatelessWidget {
  final int index;
  final void Function() onPress;
  final Product product;

  const GridCard(
      {super.key,
      required this.index,
      required this.onPress,
      required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: index % 2 == 0
            ? const EdgeInsets.only(left: 22)
            : const EdgeInsets.only(right: 22),
        decoration: CustomTheme.getCardDecoration(),
        child: GestureDetector(
          onTap: onPress,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(35),
            child: Column(
              children: [
                Expanded(
                  flex: 7,
                  child: SizedBox(
                    width: double.infinity,
                    child: CachedNetworkImage(
                      imageUrl:
                          // 'https://podacha-blud.com/uploads/posts/2022-10/1665573193_1-podacha-blud-com-p-fud-foto-myasa-2.jpg',
                          product.image,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Center(
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 4),
                          child: Text(
                            // 'title',
                            product.title,
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                        ),
                        Text(
                          product.price.toString(),
                          // 'price',
                          style: Theme.of(context).textTheme.headlineSmall,
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
