import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../common/extensions/barrel.dart';
import '../../../../common/ui/font_weight.dart';
import '../../../../constants.dart';
import '../../../models/artist_model.dart';
import '../bloc/barrel.dart';

class SelectArtistCard extends StatelessWidget {
  const SelectArtistCard({
    Key? key,
    required this.artist,
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
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                color: Colors.black26,
                padding: const EdgeInsets.all(8),
                child: Column(
                  children: [
                    _buildFullName(context),
                    const SizedBox(height: 8),
                    _buildSpecialitiesList(theme),
                  ],
                ),
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
    final height = theme.textTheme.bodyText2!.fontSize! + 8;
    return SizedBox(
      height: height,
      child: ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: artist.specialities.length * 2 - 1,
        itemBuilder: (context, index) {
          return _buildSpecialtiesListItem(theme, index);
        },
      ),
    );
  }

  Widget _buildSpecialtiesListItem(ThemeData theme, int index) {
    final style = theme.textTheme.bodyText2!.copyWith(
      color: Colors.white,
      fontSize: theme.textTheme.bodyText2!.fontSize,
    );
    if (index % 2 == 1) {
      return Text(
        ' - ',
        style: style,
      );
    }
    index = index ~/ 2;
    final key = artist.specialities.keys.elementAt(index);
    final speciality = artist.specialities[key]!;
    return Text(
      speciality.name.getValue()!.toUpperCase(),
      style: style,
    );
  }

  Widget _buildFullName(
    BuildContext context,
  ) {
    return Text(
      artist.profile.fullName,
      style: context.textTheme.headline6!.copyWith(
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
        imageUrl: artist.profile.personalImage!,
      );
    }
    return Image.asset(
      Application.defaultSettings.artistFallbackImagePath,
      fit: BoxFit.cover,
    );
  }
}
