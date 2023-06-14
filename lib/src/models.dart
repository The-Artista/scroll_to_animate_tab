import 'package:flutter/material.dart';

/// A skeleton class to be used in order to build the scrollable list.
class ScrollableListTab {
  /// A skeleton class to be used in order to build the scrollable list.
  /// [ScrollableListTab.label] will be used on both tab bar and scrollable body if [ScrollableListTab.bodyLabelDecoration] is empty.
  /// [ScrollableListTab.bodyLabelDecoration] it will take a widget and replay default label
  ScrollableListTab({
    required this.label,
    required this.body,
    this.bodyLabelDecoration,
  });

  /// A data class for tab properties
  final String label;

  /// A widget label for decorate body widget
  final Widget? bodyLabelDecoration;

  /// A single widget in the scrollable tab list.
  /// Make sure that [body] is created with [ScrollView.shrinkWrap] = true
  /// and [ScrollView.physics] = [NeverScrollableScrollPhysics].
  /// This will ensure that all the children will layout correctly.
  /// For more details see [ScrollView].
  final ScrollView body;
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
