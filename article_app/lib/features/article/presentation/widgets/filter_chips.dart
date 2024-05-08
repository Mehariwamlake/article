import 'package:article_app/core/utils/converters/real_pixel_to_logical_pixel.dart';
import 'package:article_app/features/article/presentation/widgets/chip_builder.dart';
import 'package:flutter/material.dart';

class FilterChips extends StatelessWidget {
  const FilterChips({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: convertPixelToScreenHeight(context, 27),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: const <Widget>[
          ChipBuilder(
            text: "All",
            isSelected: true,
          ),
          ChipBuilder(
            text: "Sports",
            isSelected: false,
          ),
          ChipBuilder(
            text: "Tech",
            isSelected: false,
          ),
          ChipBuilder(
            text: "Politics",
            isSelected: false,
          ),
        ],
      ),
    );
  }
}
