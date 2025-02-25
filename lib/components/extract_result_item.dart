import 'package:flutter/material.dart';

class ExtractResultItem extends StatelessWidget {
  final String tag;
  final String length;
  final String data;

  const ExtractResultItem({
    super.key,
    required this.tag,
    required this.length,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
            child: Text(tag),
          ),
          const SizedBox(width: 24),
          Expanded(
            child: Text(length),
          ),
          const SizedBox(width: 24),
          Expanded(
            flex: 6,
            child: Text(data),
          ),
        ],
      ),
    );
  }
}
