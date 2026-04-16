import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:algolens/core/theme/app_text_styles.dart';
import 'package:algolens/core/widgets/app_background.dart';
import 'package:algolens/core/widgets/offline_banner.dart';

class PageWrapper extends StatelessWidget {
  final Widget child;
  final String? title;
  final bool showBackButton;
  final List<Widget>? actions;
  final bool showOfflineBanner;

  const PageWrapper({
    super.key,
    required this.child,
    this.title,
    this.showBackButton = false,
    this.actions,
    this.showOfflineBanner = true,
  });

  @override
  Widget build(BuildContext context) {
    return AppBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        extendBodyBehindAppBar: true,
        extendBody: true,
        appBar: title != null
            ? AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                scrolledUnderElevation: 0,
                centerTitle: false,
                title: Text(
                  title!,
                  style: AppTextStyles.heading,
                ),
                leading: showBackButton
                    ? IconButton(
                        icon: Icon(
                          Icons.arrow_back_ios_new_rounded,
                          color: Colors.white,
                          size: 20.r,
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      )
                    : null,
                automaticallyImplyLeading: showBackButton,
                actions: actions,
              )
            : null,
        body: SafeArea(
          child: Column(
            children: [
              if (showOfflineBanner) const OfflineBanner(),
              Expanded(
                child: child,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
