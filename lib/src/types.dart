import 'package:flutter/material.dart';

/// Create a new [ListTab]
class ListTab {
  /// Create a new [ListTab]
  const ListTab({
    this.icon,
    required this.label,
    this.borderRadius = const BorderRadius.all(Radius.circular(5.0)),
    this.activeBackgroundColor = Colors.blue,
    this.inactiveBackgroundColor = Colors.transparent,
    this.showIconOnList = false,
    this.borderColor = Colors.grey,
  });

  /// Trailing widget for a tab, typically an [Icon].
  final Widget? icon;

  /// Label to be shown in the tab, must be non-null.
  final Widget label;

  /// [BorderRadius] for the a tab at the bottom tab view.
  /// This won't affect the tab in the scrollable list.
  final BorderRadiusGeometry borderRadius;

  /// Color to be used when the tab is selected.
  final Color activeBackgroundColor;

  /// Color to be used when tab is not selected
  final Color inactiveBackgroundColor;

  /// If true, the [icon] will also be shown to the user in the scrollable list.
  final bool showIconOnList;

  /// Color of the [Border] property of the inner tab [Container].
  final Color borderColor;
}


/// A skeleton class to be used in order to build the scrollable list.
class ScrollableListTab {
  /// A skeleton class to be used in order to build the scrollable list.
  /// [ScrollableListTab.tab] will be used on both tab bar and scrollable body.
  ScrollableListTab({required this.tab, required this.body});

  /// A data class for tab properties
  final ListTab tab;

  /// A single widget in the scrollable tab list.
  /// Make sure that [body] is created with [ScrollView.shrinkWrap] = true
  /// and [ScrollView.physics] = [NeverScrollableScrollPhysics].
  /// This will ensure that all the children will layout correctly.
  /// For more details see [ScrollView].
  final ScrollView body;
}
