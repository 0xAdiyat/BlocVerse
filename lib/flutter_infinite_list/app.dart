import 'package:bloc_verse/flutter_infinite_list/posts/view/posts_page.dart';
import 'package:bloc_verse/flutter_infinite_list/utils/utils.dart';
import 'package:flutter/material.dart';

class InfiniteListApp extends MaterialApp {
  InfiniteListApp({super.key})
      : super(
          home: const PostsPage(),
          debugShowCheckedModeBanner: false,
          debugShowMaterialGrid: false,
          theme: ThemeData(
            textTheme: TextTheme(
                bodySmall: TextStyle(
                    color: DeviceMode.isLight() ? Colors.black : Colors.white)),
            appBarTheme: const AppBarTheme(centerTitle: true),
            useMaterial3: false,
            primaryColor: Colors.redAccent,
            floatingActionButtonTheme: const FloatingActionButtonThemeData(
                backgroundColor: Colors.black87),
            colorScheme: const ColorScheme.light(
              secondary: Colors.black54,
            ),
          ),
        );
}
