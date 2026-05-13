import 'package:admin/controllers/menu_app_controller.dart';
import 'package:admin/responsive.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';

class Header extends StatelessWidget {
  const Header({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              color: (Theme.of(context).brightness == Brightness.dark
                      ? darkSurfaceColor
                      : surfaceColor)
                  .withValues(alpha: 0.5),
              borderRadius: BorderRadius.all(Radius.circular(defaultRadius)),
            ),
            child: IconButton(
              icon: Icon(Icons.menu, color: primaryColor),
              onPressed: context.read<MenuAppController>().toggleMenu,
            ),
          ),
          if (!Responsive.isMobile(context)) SizedBox(width: defaultPadding),
          if (!Responsive.isSmallMobile(context))
            Text(
              "Fulfilmarket Dashboard",
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontWeight: FontWeight.w700,
                    letterSpacing: -0.5,
                  ),
            ),
          if (!Responsive.isMobile(context))
            SizedBox(width: Responsive.isDesktop(context) ? 32 : 16),
          SizedBox(
            width: Responsive.isSmallMobile(context) ? 150 : 300,
            child: SearchField(),
          ),
          if (!Responsive.isSmallMobile(context)) SizedBox(width: defaultPadding),
          ProfileCard()
        ],
      ),
    );
  }
}

class ProfileCard extends StatelessWidget {
  const ProfileCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      margin: EdgeInsets.only(left: defaultPadding),
      padding: EdgeInsets.symmetric(
        horizontal: Responsive.isSmallMobile(context) ? smallPadding : defaultPadding,
        vertical: defaultPadding / 2,
      ),
      decoration: BoxDecoration(
        color: isDark ? darkSecondaryColor : secondaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(defaultRadius)),
        border: Border.all(
          color: isDark ? darkDividerColor : dividerColor,
          width: 1,
        ),
        boxShadow: cardShadow,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          ClipOval(
            child: Image.asset(
              "assets/images/profile_pic.jpg",
              height: Responsive.isSmallMobile(context) ? 32 : 36,
              width: Responsive.isSmallMobile(context) ? 32 : 36,
              fit: BoxFit.cover,
            ),
          ),
          if (!Responsive.isMobile(context))
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: defaultPadding / 2),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Hossam Kerroumi",
                    style: TextStyle(
                      color: isDark ? darkTextPrimary : textPrimary,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  Text(
                    "Admin",
                    style: TextStyle(
                      color: isDark ? darkTextSecondary : textSecondary,
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          Icon(
            Icons.keyboard_arrow_down_rounded,
            color: isDark ? darkTextSecondary : textSecondary,
          ),
        ],
      ),
    );
  }
}

class SearchField extends StatelessWidget {
  const SearchField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return TextField(
      decoration: InputDecoration(
        hintText: "Rechercher...",
        hintStyle: TextStyle(
          color: isDark ? darkTextSecondary : textSecondary,
          fontSize: 14,
        ),
        fillColor: isDark ? darkSecondaryColor : secondaryColor,
        filled: true,
        contentPadding: EdgeInsets.symmetric(
          horizontal: defaultPadding,
          vertical: defaultPadding * 0.8,
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: const BorderRadius.all(Radius.circular(defaultRadius)),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: isDark ? darkDividerColor : dividerColor,
            width: 1,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(defaultRadius)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: primaryColor,
            width: 2,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(defaultRadius)),
        ),
        prefixIcon: Icon(
          Icons.search_outlined,
          color: isDark ? darkTextSecondary : textSecondary,
        ),
        suffixIcon: InkWell(
          onTap: () {},
          borderRadius: BorderRadius.all(Radius.circular(defaultRadius)),
          child: Container(
            margin: EdgeInsets.all(4),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [primaryColor, primaryDarkColor],
              ),
              borderRadius: const BorderRadius.all(Radius.circular(defaultRadius - 2)),
              boxShadow: buttonShadow,
            ),
            child: Icon(
              Icons.tune_rounded,
              color: Colors.white,
              size: 18,
            ),
          ),
        ),
      ),
    );
  }
}
