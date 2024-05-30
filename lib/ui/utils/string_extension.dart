extension StringExtension on String {
  String truncateWithEllipsis({int maxLines = 1}) {
    final textLines = split('\n');
    if (textLines.length > maxLines) {
      return '${textLines.take(maxLines).join('\n')}...';
    }
    return this;
  }
}
