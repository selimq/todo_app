import 'package:flutter/material.dart';

extension ContextExtension on BuildContext {
  MediaQueryData get mediaQuery => MediaQuery.of(this);
}

extension MediaQueryExtension on BuildContext {
  double get height => mediaQuery.size.height;
  double get width => mediaQuery.size.width;

  double get lowValue => height * 0.01;
  double get normalValue => height * 0.03;
  double get mediumValue => height * 0.05;
  double get highValue => height * 0.1;
}

extension ThemeExtension on BuildContext {
  ThemeData get theme => Theme.of(this);
  TextTheme get texTheme => theme.textTheme;
  ColorScheme get colors => theme.colorScheme;
}

extension PaddingExtension on BuildContext {
  EdgeInsets get paddingLow => EdgeInsets.all(lowValue);
  EdgeInsets get paddingNormal => EdgeInsets.all(normalValue);
  EdgeInsets get paddingMedium => EdgeInsets.all(mediumValue);
  EdgeInsets get paddingHigh => EdgeInsets.all(highValue);

  EdgeInsetsGeometry get paddindHorizontal36 =>
      const EdgeInsets.symmetric(horizontal: 36);
  EdgeInsetsGeometry get paddingAll16 => const EdgeInsets.all(16);
  EdgeInsetsGeometry get paddindHorizontal8 =>
      const EdgeInsets.symmetric(horizontal: 8);
  EdgeInsetsGeometry get paddindHorizontal18 =>
      const EdgeInsets.symmetric(horizontal: 18);
}

extension BorderRadiusExtension on BuildContext {
  BorderRadius get borderRadius8 => BorderRadius.circular(8);
  BorderRadius get borderRadius16 => BorderRadius.circular(16);
  BorderRadius get borderRadius24 => BorderRadius.circular(56);
  BorderRadius get borderRadius56 => BorderRadius.circular(56);
  BorderRadius get borderRadius360 => BorderRadius.circular(360);
}

extension Spacer on BuildContext {
  Widget uiSpacer({double vertical = 0, double horizontal = 0}) => SizedBox(
        height: vertical,
        width: horizontal,
      );
}
