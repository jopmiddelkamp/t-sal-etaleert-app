import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'common/ui/font_weight.dart';
import 'theme.colors.dart';
import 'theme.sizes.dart';

// https://medium.com/flutter-community/themes-in-flutter-part-1-75f52f2334ea
// https://medium.com/flutter-community/themes-in-flutter-part-2-706382bc32c5
// https://medium.com/flutter-community/themes-in-flutter-part-3-71361ffdc344

ThemeData buildAppTheme(
  BuildContext context,
) {
  final colorScheme = _buildColorScheme();

  final textTheme = _buildTextTheme();

  return ThemeData(
    // TODO: Could be removed soon as the PR for the fix for the app bar is already completed
    primaryColor: ThemeColors.primaryColor,
    primaryColorBrightness: Brightness.dark,

    colorScheme: colorScheme,

    scaffoldBackgroundColor: ThemeColors.backgroundColor,
    cardColor: ThemeColors.surfaceColor,
    dividerColor: ThemeColors.dividerColor,

    textTheme: textTheme,
    iconTheme: const IconThemeData.fallback().copyWith(
      color: ThemeColors.onSurfaceColor,
    ),
    buttonTheme: ButtonThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(ThemeSizes.smallBorderRadius),
      ),
    ),
    cardTheme: CardTheme(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(ThemeSizes.mediumBorderRadius),
      ),
      shadowColor: Colors.black26,
    ),
    dialogTheme: DialogTheme(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(ThemeSizes.mediumBorderRadius),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        primary: ThemeColors.accentColor,
        padding: EdgeInsets.all(20.0),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        backgroundColor: Colors.transparent,
        primary: ThemeColors.onSurfaceColor,
        padding: EdgeInsets.all(20.0),
        side: BorderSide(
          color: ThemeColors.borderColor,
          width: 1.5,
        ),
      ),
    ),
    chipTheme: buildChipTheme(
      textTheme: textTheme,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(),
  );
}

ColorScheme _buildColorScheme() {
  return ColorScheme(
    primary: ThemeColors.primaryColor,
    primaryVariant: ThemeColors.primaryColorDarker,
    secondary: ThemeColors.accentColor,
    secondaryVariant: ThemeColors.accentColorLighter,
    surface: ThemeColors.onSurfaceColor,
    background: ThemeColors.backgroundColor,
    error: ThemeColors.errorColor,
    onPrimary: ThemeColors.onPrimaryColor,
    onSecondary: ThemeColors.onPrimaryColor,
    onSurface: ThemeColors.onSurfaceColor,
    onBackground: ThemeColors.onSurfaceColor,
    onError: ThemeColors.onErrorColor,
    brightness: Brightness.light,
  );
}

TextTheme _buildTextTheme() {
  final textTheme = GoogleFonts.sourceSansProTextTheme();

  return textTheme.copyWith(
    // Extremely large text.
    headline1: textTheme.headline1.copyWith(
      fontSize: 112,
    ),
    // Very, very large text. Used for the date in the dialog shown by [showDatePicker].
    headline2: textTheme.headline2.copyWith(
      fontSize: 56,
    ),
    // Very large text.
    headline3: textTheme.headline3.copyWith(
      fontSize: 46,
    ),
    // Large text.
    headline4: textTheme.headline4.copyWith(
      fontSize: 36,
    ),
    // Used for large text in dialogs (e.g., the month and year in the dialog shown by [showDatePicker]).
    headline5: textTheme.headline5.copyWith(
      fontSize: 26,
    ),
    // Used for the primary text in app bars and dialogs (e.g., [AppBar.title] and [AlertDialog.title]).
    headline6: textTheme.headline6.copyWith(
      fontSize: 22,
    ),
    // Used for the primary text in lists (e.g., [ListTile.title])
    subtitle1: textTheme.subtitle1.copyWith(
      fontSize: 18,
    ),
    // For medium emphasis text that's a little smaller than [subtitle1].
    subtitle2: textTheme.subtitle2.copyWith(
      fontSize: 16,
    ),
    // The default text style for [Material].
    bodyText2: textTheme.bodyText2.copyWith(
      fontSize: 16,
    ),
    // Used for emphasizing text that would otherwise be [bodyText2].
    bodyText1: textTheme.bodyText1.copyWith(
      fontSize: 16,
    ),
    // Used for text on [ElevatedButton], [TextButton] and [OutlinedButton].
    button: textTheme.button.copyWith(
      fontWeight: TSALFontWeight.bold,
      fontSize: 16,
    ),
  );
}

enum ChipType { filter, input }

ChipThemeData buildChipTheme({
  @required TextTheme textTheme,
  Color backgroundColor,
  Color deleteIconColor,
  Color disabledColor,
  Color selectedColor,
  Color secondarySelectedColor,
  Color shadowColor,
  Color selectedShadowColor,
  bool showCheckmark,
  Color checkmarkColor,
  EdgeInsetsGeometry labelPadding,
  EdgeInsetsGeometry padding,
  ShapeBorder shape,
  TextStyle labelStyle,
  TextStyle secondaryLabelStyle,
  Brightness brightness,
  double elevation,
  double pressElevation,
}) {
  backgroundColor = backgroundColor ?? ThemeColors.primaryColor;
  assert(backgroundColor != null);
  disabledColor = disabledColor ?? ThemeColors.primaryColor.withOpacity(0.4);
  assert(disabledColor != null);
  selectedColor = selectedColor ?? ThemeColors.primaryColor;
  assert(selectedColor != null);
  secondarySelectedColor = secondarySelectedColor ?? ThemeColors.primaryColor;
  assert(secondarySelectedColor != null);
  padding =
      padding ?? const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0);
  assert(padding != null);
  shape = shape ??
      RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(1000.0)),
        side: BorderSide.none,
      );
  assert(shape != null);
  labelStyle = labelStyle ??
      buildChipThemeTextStyle(
        textTheme: textTheme,
      );
  assert(labelStyle != null);
  secondaryLabelStyle = secondaryLabelStyle ??
      buildChipThemeTextStyle(
        textTheme: textTheme,
      );
  assert(secondaryLabelStyle != null);
  brightness = brightness ?? Brightness.light;
  assert(brightness != null);

  return ChipThemeData(
    backgroundColor: backgroundColor,
    deleteIconColor: deleteIconColor ?? ThemeColors.onPrimaryColor,
    disabledColor: disabledColor,
    selectedColor: selectedColor,
    secondarySelectedColor: secondarySelectedColor,
    shadowColor: shadowColor,
    selectedShadowColor: selectedShadowColor,
    showCheckmark: showCheckmark,
    checkmarkColor: checkmarkColor ?? ThemeColors.onPrimaryColor,
    labelPadding: labelPadding ?? EdgeInsets.fromLTRB(6, 4, 6, 4),
    padding: padding,
    shape: shape,
    labelStyle: labelStyle,
    secondaryLabelStyle: secondaryLabelStyle ?? ThemeColors.onPrimaryColor,
    brightness: brightness,
    elevation: elevation ?? 0,
    pressElevation: pressElevation ?? 0,
  );
}

buildChipThemeTextStyle({
  TextTheme textTheme,
  Color color,
  double fontSize,
}) {
  return TextStyle(
    color: color ?? ThemeColors.onPrimaryColor,
    fontSize: fontSize ?? textTheme?.button?.fontSize ?? 16,
    fontWeight: TSALFontWeight.semiBold,
  );
}
