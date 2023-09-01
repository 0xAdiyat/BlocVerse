import 'package:bloc/bloc.dart';
import 'package:bloc_verse/flutter_infinite_list/app.dart';
import 'package:bloc_verse/flutter_infinite_list/simple_bloc_observer.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = const SimpleBlocObserver();
  runApp(InfiniteListApp());
}
