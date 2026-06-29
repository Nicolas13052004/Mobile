import 'package:flutter/material.dart';

class AdminListTemplate extends StatelessWidget {
  final String title;
  final bool isLoading;
  final List items;
  final Widget Function(dynamic item) itemBuilder;
  final Future<void> Function()? onRefresh;

  const AdminListTemplate({
    super.key,
    required this.title,
    required this.items,
    required this.itemBuilder,
    this.isLoading = false,
    this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: onRefresh ?? () async {},
              child: items.isEmpty
                  ? const Center(child: Text("Aucune donnée"))
                  : ListView.builder(
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        return itemBuilder(items[index]);
                      },
                    ),
            ),
    );
  }
}