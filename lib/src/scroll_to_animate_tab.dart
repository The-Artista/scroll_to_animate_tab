import 'package:flutter/material.dart';
import 'package:scroll_to_animate_tab/src/types.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

const Duration _kScrollDuration = Duration(milliseconds: 150);
const EdgeInsetsGeometry _kTabMargin = EdgeInsets.symmetric(
  horizontal: 10,
  vertical: 5,
);

const SizedBox _kSizedBoxW8 = SizedBox(width: 8);

/// Create a new [ScrollToAnimateTab]
class ScrollToAnimateTab extends StatefulWidget {
  /// Create a new [ScrollToAnimateTab]
  const ScrollToAnimateTab({
    required this.tabs,
    super.key,
    this.tabHeight = kToolbarHeight,
    this.tabAnimationDuration = _kScrollDuration,
    this.bodyAnimationDuration = _kScrollDuration,
    this.tabAnimationCurve = Curves.decelerate,
    this.bodyAnimationCurve = Curves.decelerate,
  });

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
          color: Theme.of(context).cardColor,
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
                  final borderColor = selected ? tab.activeBackgroundColor : Theme.of(context).dividerColor;
                  return Container(
                    height: 32,
                    margin: _kTabMargin,
                    decoration: BoxDecoration(
                      color: selected ? tab.activeBackgroundColor : tab.inactiveBackgroundColor,
                      borderRadius: tab.borderRadius,
                    ),
                    child: OutlinedButton(
                      style: ButtonStyle(
                        foregroundColor: MaterialStateProperty.all(
                          selected ? Colors.white : Colors.grey,
                        ),
                        backgroundColor: MaterialStateProperty.all(
                          selected ? tab.activeBackgroundColor : tab.inactiveBackgroundColor,
                        ),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        side: MaterialStateProperty.all(
                          BorderSide(
                            color: borderColor,
                          ),
                        ),
                        elevation: MaterialStateProperty.all(0),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: tab.borderRadius)),
                      ),
                      child: _buildTab(index),
                      onPressed: () => _onTabPressed(index),
                    ),
                  );
                },
              );
            },
          ),
        ),
        Expanded(
          child: ScrollablePositionedList.builder(
            itemScrollController: _bodyScrollController,
            itemPositionsListener: _bodyPositionsListener,
            itemCount: widget.tabs.length,
            itemBuilder: (_, index) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: _kTabMargin.add(const EdgeInsets.all(5.0)),
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
      children: [tab.icon ?? const SizedBox(), _kSizedBoxW8, tab.label],
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
