import 'package:flutter/material.dart';

import '../../../widgets/retro_app_bar.dart';

class Wishlist extends StatelessWidget {
  const Wishlist({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: RetroAppBar(
        title: 'Wishlist',
      ),
    );
  }
}
