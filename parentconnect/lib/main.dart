import 'package:flutter/material.dart';

import 'routes/app_router.dart';

void main() {
  runApp(
    const ParentConnectApp(),
  );
}

class ParentConnectApp
    extends StatelessWidget {

  const ParentConnectApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    return MaterialApp.router(

      debugShowCheckedModeBanner:
          false,

      routerConfig:
          AppRouter.router,

      title: "ParentConnect",

      theme: ThemeData(
        useMaterial3: true,
      ),
    );
  }
}