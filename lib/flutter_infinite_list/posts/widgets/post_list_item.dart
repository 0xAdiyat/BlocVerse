import 'package:bloc_verse/flutter_infinite_list/utils/utils.dart';
import 'package:flutter/material.dart';

import '../models/post_model.dart';

class PostListItem extends StatelessWidget {
  const PostListItem({required this.post, super.key});

  final Post post;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Material(
      color: DeviceMode.isLight() ? Colors.white : Colors.black87,
      child: ListTile(
        leading: Text('${post.id}', style: textTheme.bodySmall),
        title: Text(
          post.title,
          style: textTheme.bodySmall
              ?.copyWith(fontWeight: FontWeight.w500, fontSize: 14),
        ),
        isThreeLine: true,
        subtitle: Text(
          post.body,
          style: textTheme.bodySmall,
        ),
        dense: true,
      ),
    );
  }
}
