import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

const Duration _kScrollDuration = Duration(milliseconds: 150);
const EdgeInsetsGeometry _kTabMargin = EdgeInsets.symmetric(vertical: 5, horizontal: 8);
const EdgeInsetsGeometry _kTabPadding = EdgeInsets.symmetric(vertical: 5, horizontal: 12);

const SizedBox _kSizedBoxW8 = SizedBox(width: 8);

/// Create a new [ScrollToAnimateTab]
class ScrollToAnimateTab extends StatefulWidget {

  /// List of tabs to be rendered.
  final List<ScrollableListTab> tabs;

  /// Height of the tab at the top of the view.
  final double? tabHeight;

  /// Duration of tab change animation.
  final Duration? tabAnimationDuration;

  /// Duration of inner scroll view animation.
  final Duration? bodyAnimationDuration;

  /// Animation curve used when animating tab change.
  final Curve? tabAnimationCurve;

  /// Animation curve used when changing index of inner [ScrollView]s.
  final Curve? bodyAnimationCurve;

  /// Change Tab Background Color
  final Color? backgroundColor;

  /// Change Tab border
  final bool isOutlineBorder;


  /// Create a new [ScrollToAnimateTab]
  const ScrollToAnimateTab({
    required this.tabs,
    super.key,
    this.tabHeight = kToolbarHeight,
    this.tabAnimationDuration = _kScrollDuration,
    this.bodyAnimationDuration = _kScrollDuration,
    this.tabAnimationCurve = Curves.decelerate,
    this.bodyAnimationCurve = Curves.decelerate,
    this.backgroundColor = Colors.transparent,
    this.isOutlineBorder = false,
  });

  @override
  _ScrollToAnimateTabState createState() => _ScrollToAnimateTabState();
}

class _ScrollToAnimateTabState extends State<ScrollToAnimateTab> {
  final ValueNotifier<int> _index = ValueNotifier<int>(0);

  final ItemScrollController _bodyScrollController = ItemScrollController();
  late ItemPositionsListener _bodyPositionsListener;
  final ItemScrollController _tabScrollController = ItemScrollController();

  @override
  void initState() {
    super.initState();
    _bodyPositionsListener = ItemPositionsListener.create();
    _bodyPositionsListener.itemPositions.addListener(_onInnerViewScrolled);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: widget.tabHeight,
          color: widget.backgroundColor,
          child: ScrollablePositionedList.builder(
            itemCount: widget.tabs.length,
            scrollDirection: Axis.horizontal,
            itemScrollController: _tabScrollController,
            padding: const EdgeInsets.symmetric(vertical: 2.5),
            itemBuilder: (context, index) {
              final tab = widget.tabs[index].tab;
              return ValueListenableBuilder<int>(
                valueListenable: _index,
                builder: (_, i, __) {
                  final selected = index == i;

                  return GestureDetector(
                    onTap: () => _onTabPressed(index),
                    child: Container(
                      margin: _kTabMargin,
                      padding: _kTabPadding,
                      alignment: Alignment.center,
                      decoration: widget.isOutlineBorder ? BoxDecoration(
                        color: selected ? tab.tabActiveColor : tab.tabInactiveColor,
                        borderRadius: tab.borderRadius,
                        border: Border.all(
                          color: selected ? tab.tabActiveColor : tab.borderColor
                        )
                      ) : BoxDecoration(
                          border: Border(
                          bottom: BorderSide(
                            color: selected ? tab.tabActiveColor : tab.tabInactiveColor,
                            width: 1.5
                          )
                        )
                      ),
                      child:  _buildTab(index),
                    )
                  );
                },
              );
            },
          ),
        ),
        Expanded(
          child: ScrollablePositionedList.builder(
            shrinkWrap: true,
            itemScrollController: _bodyScrollController,
            itemPositionsListener: _bodyPositionsListener,
            itemCount: widget.tabs.length,
            itemBuilder: (_, index) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: _kTabMargin.add(const EdgeInsets.all(5)),
                  child: _buildInnerTab(index),
                ),
                Flexible(
                  child: widget.tabs[index].body,
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInnerTab(int index) {
    final tab = widget.tabs[index].tab;
    const textStyle = TextStyle(
      fontWeight: FontWeight.w500,
      color: Colors.black,
      fontSize: 16
    );

    return Builder(
      builder: (_) {
        if (tab.icon == null) return tab.label;
        if (!tab.showIconOnList) {
          return DefaultTextStyle(style: textStyle, child: tab.label);
        }
        return DefaultTextStyle(
          style: textStyle,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [tab.icon ?? const SizedBox(), _kSizedBoxW8, tab.label],
          ),
        );
      },
    );
  }

  Widget _buildTab(int index) {
    final tab = widget.tabs[index].tab;
    if (tab.icon == null) return tab.label;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        tab.icon ?? const SizedBox(),
        _kSizedBoxW8,
        tab.label
      ],
    );
  }

  Future<void> _onInnerViewScrolled() async {
    final positions = _bodyPositionsListener.itemPositions.value;

    /// Target [ScrollView] is not attached to any views and/or has no listeners.
    if (positions.isEmpty) return;

    /// Capture the index of the first [ItemPosition]. If the saved index is same
    /// with the current one do nothing and return.
    final firstIndex = _bodyPositionsListener.itemPositions.value.elementAt(0).index;
    if (_index.value == firstIndex) return;

    /// A new index has been detected.
    await _handleTabScroll(firstIndex);
  }

  Future<void> _handleTabScroll(int index) async {
    _index.value = index;
    await _tabScrollController.scrollTo(
      index: _index.value,
      duration: widget.tabAnimationDuration ?? _kScrollDuration,
      curve: widget.tabAnimationCurve ?? Curves.linear,
    );
  }

  /// When a new tab has been pressed both [_tabScrollController] and
  /// [_bodyScrollController] should notify their views.
  Future<void> _onTabPressed(int index) async {
    await _tabScrollController.scrollTo(
      index: index,
      duration: widget.tabAnimationDuration ?? _kScrollDuration,
      curve: widget.tabAnimationCurve ?? Curves.linear,
    );
    await _bodyScrollController.scrollTo(
      index: index,
      duration: widget.bodyAnimationDuration ?? _kScrollDuration,
      curve: widget.bodyAnimationCurve ?? Curves.linear,
    );
    _index.value = index;
  }

  @override
  void dispose() {
    _bodyPositionsListener.itemPositions.removeListener(_onInnerViewScrolled);
    return super.dispose();
  }
}


/// Create a new [ListTab]
class ListTab {
  /// Create a new [ListTab]
  const ListTab({
    required this.label,
    this.icon,
    this.borderRadius = const BorderRadius.all(Radius.circular(5)),
    this.tabActiveColor = Colors.blue,
    this.tabInactiveColor = Colors.transparent,
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
  final Color tabActiveColor;

  /// Color to be used when tab is not selected
  final Color tabInactiveColor;

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
