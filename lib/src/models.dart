import 'package:flutter/material.dart';

/// A skeleton class to be used in order to build the scrollable list.
class ScrollableList {
  /// A skeleton class to be used in order to build the scrollable list.
  /// [ScrollableList.label] will be used on both tab bar and scrollable body if [ScrollableList.bodyLabelDecoration] is empty.
  /// [ScrollableList.bodyLabelDecoration] it will take a widget and replay default label
  ScrollableList({
    required this.label,
    required this.body,
    this.bodyLabelDecoration,
  });

  /// A String for tab label and as headline of [ScrollableList.body]
  final String label;

  /// A widget label for decorate body widget
  final Widget? bodyLabelDecoration;

  /// A single widget in the scrollable tab list.
  /// You can use [Column] or any single scrollable widget.
  /// If you want to use [ScrollView] ([ListView]) then we suggest
  /// make sure that [body] is created with [ScrollView.shrinkWrap] = true
  /// and [ScrollView.physics] = [NeverScrollableScrollPhysics].
  final Widget body;
}

/// A skeleton class to be used in order to build the TabDecoration style.
class TabDecoration {
  ///
  /// [TabDecoration.decoration] will take a [Decoration] property to decorate tabs
  /// [TabDecoration.textStyle] will take a [TextStyle] property to decorate tabs label text
  TabDecoration({required this.textStyle, this.decoration});

  /// decoration for tabs
  final Decoration? decoration;

  /// TextStyle for tab label
  final TextStyle textStyle;
}
