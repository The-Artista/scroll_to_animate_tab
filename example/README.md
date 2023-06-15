# scroll_to_animate_tab

A Flutter widget that is customizable and syncs the ScrollView with the tabs.
Create distinct tabs that are coordinated with the internal ScrollView. The tabs come after the index of the scroll view.

## Demo


## Installation
Add dependency for package on your pubspec.yaml:

    dependencies:
	    scroll_to_animate_tab: <latest>

## ScrollToAnimateTab

| Parameter | Definition |
| -- | -- |
|`List<ScrollableListTab> tabs`| List of tabs to be rendered |
|`double tabHeight`| Height of the tab at the top of the view |
|`Duration? tabAnimationDuration`| [Optional] Duration of tab change animation |
|`Duration? bodyAnimationDuration`| [Optional] Duration of tab change animation |
|`Curve? tabAnimationCurve`| [Optional] Animation curve used when animating tab change |
|`Curve? bodyAnimationCurve`| [Optional] Animation curve used when changing index of inner [ScrollView]s |