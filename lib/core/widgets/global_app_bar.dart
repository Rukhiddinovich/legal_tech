import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:legal_tech/core/constants/app_colors.dart';

class GlobalAppBar extends StatelessWidget implements PreferredSize {
  const GlobalAppBar({
    super.key,
    this.title,
    this.actionWidget,
    this.centerTitle,
    this.bottomWidgets,
    this.backgroundColor,
    this.statusBarColor,
    this.iconThemeColor,
    this.leading,
    this.toolbarHeight,
    this.autoBackBtn,
    this.elevation,
  });

  final Widget? title;
  final Widget? actionWidget;
  final Widget? leading;
  final bool? centerTitle;
  final PreferredSize? bottomWidgets;
  final Color? backgroundColor;
  final Color? statusBarColor;
  final Color? iconThemeColor;
  final double? toolbarHeight;
  final bool? autoBackBtn;
  final double? elevation;

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
        statusBarColor: statusBarColor ?? Colors.transparent,
        systemNavigationBarColor: Colors.black,
        systemNavigationBarIconBrightness: Brightness.dark,
        systemNavigationBarDividerColor: Colors.transparent,
      ),
      child: AppBar(
        bottom: bottomWidgets,
        automaticallyImplyLeading: true,
        scrolledUnderElevation: 0,
        toolbarHeight: toolbarHeight ?? 56,
        iconTheme: IconThemeData(color: AppColors.black),
        backgroundColor:
            backgroundColor ?? (isDark ? Colors.white : AppColors.white),
        elevation: elevation ?? 0,
        leading: leading,
        title: title,
        centerTitle: centerTitle ?? true,
        actions: actionWidget != null ? [actionWidget!] : null,
      ),
    );
  }

  @override
  Widget get child => throw UnimplementedError();

  @override
  Size get preferredSize => Size(
    double.infinity,
    (toolbarHeight ?? 56) + (bottomWidgets?.preferredSize.height ?? 0),
  );
}
