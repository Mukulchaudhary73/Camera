import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;

class FilteredImageListWidget extends StatelessWidget {
  final List<Filters> filters;
  final img.Image image;
  final ValueChanged<Filters> onChangedFilter;

  const FilteredImageListWidget(
      {super.key,
      required this.filters,
      required this.image,
      required this.onChangedFilter});
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class Filters {}
