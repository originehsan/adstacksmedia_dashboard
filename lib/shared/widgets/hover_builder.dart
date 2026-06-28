import 'package:flutter/material.dart';

// Wraps any widget with MouseRegion to enable web hover states
// Used by nav items, project rows, buttons, icon buttons
// Local _isHovered bool is the only acceptable stateful UI state outside Riverpod
class HoverBuilder extends StatefulWidget {
  final Widget Function(bool isHovered) builder;
  final MouseCursor cursor;

  const HoverBuilder({
    super.key,
    required this.builder,
    this.cursor = SystemMouseCursors.click,
  });

  @override
  State<HoverBuilder> createState() => _HoverBuilderState();
}

class _HoverBuilderState extends State<HoverBuilder> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: widget.cursor,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: widget.builder(_isHovered),
    );
  }
}