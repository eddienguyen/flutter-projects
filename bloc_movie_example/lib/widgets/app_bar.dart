import 'package:bloc_movie_example/config/widget_utils.dart';
import 'package:flutter/material.dart';
import 'package:bloc_movie_example/theme/page_styles.dart';

/// MaterialAppBar's content is a 'Row' packed into a 'Padding' and contains 2 elements: the label && the icon.
class MaterialAppBar extends StatelessWidget {
  final String title;
  // final ValueChanged<String> searchOnChange;
  final TextEditingController editingController;

  const MaterialAppBar({Key key, this.title, this.editingController})
      : super(key: key);

  RichText _buildLabel(BuildContext context) {
    return RichText(
      text: TextSpan(
          style: DefaultTextStyle.of(context).style.copyWith(fontSize: 12.0),
          children: [
            TextSpan(
                text: this.title,
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Color(0xfff1f1f1))),
            TextSpan(text: ' ')
          ]),
    );
  }

  Widget _buildSearchField() {
    return Container(
      width: 100.0,
      child: TextField(
        // onChanged: searchOnChange,
        controller: editingController,
        decoration: InputDecoration(
            border: OutlineInputBorder(), hintText: 'Search for a movie'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 2.0,
      child: Container(
        color: Theme.of(context).primaryColor,
        height: appBarHeight(context),
        padding: EdgeInsets.all(screenAwareSize(16.0, context)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [_buildLabel(context), _buildSearchField()],
        ),
      ),
    );
  }
}
