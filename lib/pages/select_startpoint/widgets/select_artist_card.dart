import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../common/extensions/barrel.dart';
import '../../../common/models/artist_model.dart';
import '../../../common/models/speciality_model.dart';
import '../../../common/ui/font_weight.dart';
import '../bloc/barrel.dart';

class SelectArtistCard extends StatelessWidget {
  const SelectArtistCard({
    Key key,
    @required this.artist,
  }) : super(key: key);

  final ArtistModel artist;

  @override
  Widget build(
    BuildContext context,
  ) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: () => context
          .blocProvider<SelectStartpointPageBloc>()
          .add(SelectStartpointSelectArtist(artist)),
      child: Card(
        margin: EdgeInsets.all(0),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
              child: _buildPersonalImage(),
            ),
            Positioned(
              bottom: 16,
              left: 16,
              right: 16,
              child: Column(
                children: [
                  _buildFullName(context),
                  const SizedBox(height: 16),
                  _buildSpecialitiesList(theme),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSpecialitiesList(
    ThemeData theme,
  ) {
    final height = 25.0;
    return SizedBox(
      height: height,
      child: ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: artist.specialities.length,
        itemBuilder: (context, index) {
          final key = artist.specialities.keys.elementAt(index);
          final speciality = artist.specialities[key];
          return Padding(
            padding: index > 0
                ? const EdgeInsets.only(left: 8)
                : const EdgeInsets.all(0),
            child: _buildSpecialitiesListItem(
              theme,
              height,
              speciality,
            ),
          );
        },
      ),
    );
  }

  Widget _buildSpecialitiesListItem(
    ThemeData theme,
    double height,
    SpecialityModel speciality,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 4,
        horizontal: 8,
      ),
      decoration: BoxDecoration(
        color: Colors.black45,
        borderRadius: BorderRadius.circular(height / 2),
      ),
      child: Text(
        speciality.name.getValue().toUpperCase(),
        style: theme.textTheme.bodyText2.copyWith(
          color: Colors.white,
          fontSize: theme.textTheme.bodyText2.fontSize * 0.75,
        ),
      ),
    );
  }

  Widget _buildFullName(
    BuildContext context,
  ) {
    return Text(
      artist.profile.fullName,
      style: context.textTheme.headline6.copyWith(
        color: Colors.white,
        fontWeight: TSALFontWeight.bold,
      ),
      maxLines: 2,
      overflow: TextOverflow.fade,
    );
  }

  Widget _buildPersonalImage() {
    if (artist.profile.personalImage?.isNotEmpty == true) {
      return CachedNetworkImage(
        fit: BoxFit.cover,
        imageUrl: artist.profile.personalImage,
      );
    }
    return Image.asset(
      'assets/images/unknown-artist.jpg',
      fit: BoxFit.cover,
    );
  }
}
