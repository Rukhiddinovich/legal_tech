import 'package:flutter/cupertino.dart';
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
    this.autoBackBtn, this.elevation,
    this.onBackTap,
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
  final VoidCallback? onBackTap;

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
        statusBarBrightness: isDark ? Brightness.dark : Brightness.light,
        statusBarColor: statusBarColor ?? Colors.transparent,
        systemNavigationBarColor: isDark ? AppColors.darkScaffold : Colors.black,
        systemNavigationBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
        systemNavigationBarDividerColor: Colors.transparent,
      ),
      child: AppBar(
        bottom: bottomWidgets,
        automaticallyImplyLeading: true,
        scrolledUnderElevation: 0,
        toolbarHeight: toolbarHeight ?? 56,
        iconTheme: IconThemeData(color: isDark ? AppColors.white : AppColors.black),
        backgroundColor:
            backgroundColor ?? (isDark ? AppColors.darkScaffold : AppColors.white),
        elevation: elevation ?? 0,
        leading: leading ??
            (ModalRoute.of(context)?.canPop == true
                ? UnconstrainedBox(
                    child: GlobalBackButton(
                      onTap: onBackTap ?? () => Navigator.pop(context),
                    ),
                  )
                : null),
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

class GlobalBackButton extends StatelessWidget {
  const GlobalBackButton({super.key, required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Material(
      color: isDark ? AppColors.darkSurface : AppColors.chipBg,
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: SizedBox(
          width: 38,
          height: 38,
          child: Icon(
            CupertinoIcons.back,
            size: 18,
            color: isDark ? AppColors.darkTextPrimary : AppColors.navyText,
          ),
        ),
      ),
    );
  }
}
