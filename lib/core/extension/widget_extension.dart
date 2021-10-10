import 'package:flutter/material.dart';

extension UIExtension on BuildContext {
  Widget uiSpacer({double vertical = 0, double horizontal = 0}) => SizedBox(
        height: vertical,
        width: horizontal,
      );

  EdgeInsets get defaultHorizontalInsets =>
      const EdgeInsets.symmetric(horizontal: 16);

  BorderRadius get borderRadius8 => BorderRadius.circular(8);
  BorderRadius get borderRadius16 => BorderRadius.circular(16);
  BorderRadius get borderRadius24 => BorderRadius.circular(56);
  BorderRadius get borderRadius56 => BorderRadius.circular(56);
  BorderRadius get borderRadius360 => BorderRadius.circular(360);

  EdgeInsetsGeometry get paddindHorizontal36 =>
      const EdgeInsets.symmetric(horizontal: 36);

  EdgeInsetsGeometry get paddingAll16 => const EdgeInsets.all(16);

  EdgeInsetsGeometry get paddindHorizontal8 =>
      const EdgeInsets.symmetric(horizontal: 8);
  EdgeInsetsGeometry get paddindHorizontal18 =>
      const EdgeInsets.symmetric(horizontal: 18);

  List<BoxShadow> get shadowLight => [
        BoxShadow(
          color: Colors.grey.withOpacity(0.3),
          spreadRadius: 1.5,
          blurRadius: 5,
          offset: const Offset(1, 0), // changes position of shadow
        ),
      ];

  List<BoxShadow> get shadowMedium => [
        BoxShadow(
          color: Colors.grey.withOpacity(0.3),
          spreadRadius: 3,
          blurRadius: 10,
          offset: const Offset(1, 0), // changes position of shadow
        ),
      ];
}
