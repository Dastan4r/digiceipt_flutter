import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/services.dart';

class CustomAppBarWidget extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  final bool withElevation;

  const CustomAppBarWidget({
    required this.title,
    this.withElevation = false,
  });

  @override
  final Size preferredSize = const Size(double.infinity, 56);

  @override
  _CustomAppBarWidgetState createState() => _CustomAppBarWidgetState();
}

class _CustomAppBarWidgetState extends State<CustomAppBarWidget> {
  final String userProfileIcon = 'assets/icons/user-profile-icon.svg';
  final String notificationIcon = 'assets/icons/notification-icon.svg';

  @override
  Widget build(BuildContext context) {
    final ButtonStyle style = TextButton.styleFrom(
      primary: const Color.fromRGBO(0, 0, 0, 0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
    );

    return AppBar(
      backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
      elevation: widget.withElevation ? 1 : 0,
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
        statusBarBrightness: Brightness.dark, // For iOS (dark icons)
      ),
      title: Padding(
        padding: const EdgeInsets.only(left: 16.0),
        child: Text(
          widget.title,
          style: Theme.of(context).textTheme.headline1,
        ),
      ),
      centerTitle: false,
      titleSpacing: 5,
      leadingWidth: 0,
      actions: [
        SizedBox(
          width: 40,
          height: 40,
          child: TextButton(
            style: style,
            onPressed: () {},
            child: SvgPicture.asset(
              notificationIcon,
              semanticsLabel: 'Notification',
            ),
          ),
        ),
        SizedBox(
          width: 40,
          height: 40,
          child: TextButton(
            style: style,
            onPressed: () {},
            child: SvgPicture.asset(
              userProfileIcon,
              semanticsLabel: 'Profile',
            ),
          ),
        ),
      ],
    );
  }
}
