import 'package:flutter/material.dart';
import 'package:movie_db/src/ui/theme.dart' as CustonTheme;

typedef void RatingChangeCallback(double rating);

class StarRating extends StatelessWidget {
  final int starCount;
  final dynamic rating;
  final Color color;
  // final RatingChangeCallback onRatingChanged;

  StarRating({
    this.starCount = 5, 
    this.rating = .0, 
    this.color,
    // this.onRatingChanged,
    });

  Widget buildStar(BuildContext context, int index) {
    IconData icon;
    // if larger than or equals rating
    if (index >= rating) {
      icon = Icons.star_border;
    } // if smaller than rating and larger than rating.base
    else if (index < rating && index > rating - 1) {
      icon = Icons.star_half;
    } // if smaller than rating
    else {
      icon = Icons.star;
    }
    // if larger than rating
    return Icon(
      icon,
      color: color ?? Theme.of(context).primaryColor,
    );

    ///Uncomment this return to use the tapToRate widget: https://stackoverflow.com/questions/46637566/how-to-create-rating-star-bar-properly
    //return new InkResponse(
      // onTap: onRatingChanged == null ? null : onRatingChanged(index + 1.0),
      // child: Icon(
        // icon,
        // color: color ?? Theme.of(context).primaryColor
      // )
    // );
  }

  @override
  Widget build(BuildContext context) {
    return new Row(
      children:
          new List.generate(starCount, (index) => buildStar(context, index)),
    );
  }
}
