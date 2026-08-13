import 'package:flutter/material.dart';
import 'package:movie_app/app/movie_app.dart';
import 'package:provider/provider.dart';

import 'providers/auth_provider.dart';
import 'providers/movie_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),

        ChangeNotifierProvider(create: (_) => MovieProvider()),
      ],
      child: MovieApp(),
    ),
  );
}
