import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:tapiten_app/storage/user_mode.dart';
import 'package:tapiten_app/ui/profile/viewModel/profile_user_mode_view_model.dart';
import 'package:tapiten_app/ui/question/styles/text_style.dart';

class ProfileReviewScore extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Row(
          children: [
            ProfileReviewStars(),
          ],
        ),
      ),
    );
  }
}

class ProfileReviewStars extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<ProfileUserMode>(context);

    return Container(
      padding: EdgeInsets.only(bottom: 25),
      child: viewModel.isBusy
          ? Container(width: double.infinity)
          : Column(
              children: [
                Text(
                  '神さまランク',
                  style: kTitleTextStyle.copyWith(
                    fontSize: 15,
                    color: (UserMode.isGod) ? Color(0xFF909090) : Colors.white,
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SmoothStarRating(
                        allowHalfRating: false,
                        onRated: null,
                        starCount: 5,
                        rating: viewModel.godScore,
                        size: 28,
                        isReadOnly: true,
                        filledIconData: Icons.star,
                        halfFilledIconData: Icons.star_half,
                        defaultIconData: Icons.star_border,
                        color: Color(0xffF5DB28),
                        borderColor: Color(0xfff7f7f7),
                        spacing: 0.0),
                    Text(
                      viewModel.godScore != null
                          ? viewModel.godScore.toString()
                          : '',
                      style: kTitleTextStyle.copyWith(
                        fontSize: 20,
                        color:
                            (UserMode.isGod) ? Color(0xFF909090) : Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
    );
  }
}
