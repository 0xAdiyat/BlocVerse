import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RetroAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;

  const RetroAppBar({
    Key? key,
    required this.title,
    this.actions,
  }) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 45);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 12.0, right: 12.0, top: 20),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: const Color(0xffA2C2D5),
          border: Border.all(
            color: Colors.black,
            width: 2.0,
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0xffA2C2D5).withOpacity(0.7),
              blurRadius: 8.0,
              offset: const Offset(0, 4),
            ),
          ],
          borderRadius: BorderRadius.circular(10)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: Text(title, style: GoogleFonts.lobster(fontSize: 28)),
          actions: actions,
        ),
      ),
    );
  }
}
