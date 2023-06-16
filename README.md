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
|`Color? backgroundColor`| [Optional] This property will help you to change the background color of tab bar |
|`TabDecoration? activeTabDecoration`| [Optional] Change active tab decoration |
|`TabDecoration? inActiveTabDecoration`| [Optional] Change inactive tab decoration |

inside this [TabDecoration], it gives us `textStyle` property which is required that helps us to change tab label style and other is optional named `decoration` property which helps us to decorate our tab. 

## How to use

Basic Example ->

```dart
Scaffold(
        body: ScrollToAnimateTab(
          activeTabDecoration: TabDecoration(
              textStyle: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 18),
              decoration: BoxDecoration(border: Border.all(color: Colors.black), borderRadius: const BorderRadius.all(Radius.circular(5)))),
          inActiveTabDecoration: TabDecoration(
              textStyle: const TextStyle(color: Colors.black), 
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black12), 
                borderRadius: const BorderRadius.all(Radius.circular(5))
              )
          ),
          tabs: [
            ScrollableListTab(
                label: "Hello",
                body: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 10,
                  itemBuilder: (_, index) => ListTile(
                    leading: Container(
                      height: 40,
                      width: 40,
                      decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.grey),
                      alignment: Alignment.center,
                      child: Text("${index + 1}"),
                    ),
                    title: Text('List element ${index + 1}'),
                  ),
                )),
            ScrollableListTab(
                label: "hello 2",
                body: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 10,
                  itemBuilder: (_, index) => ListTile(
                    leading: Container(
                      height: 40,
                      width: 40,
                      decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.grey),
                      alignment: Alignment.center,
                      child: Text("${index + 1}"),
                    ),
                    title: Text('List element ${index + 1}'),
                  ),
                )),
            ScrollableListTab(
                label: "Hello000",
                body: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 10,
                  itemBuilder: (_, index) => ListTile(
                    leading: Container(
                      height: 40,
                      width: 40,
                      decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.grey),
                      alignment: Alignment.center,
                      child: Text("${index + 1}"),
                    ),
                    title: Text('List element ${index + 1}'),
                  ),
                )
            ),
            ScrollableListTab(
              label: "hello",
              body: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 10,
                  itemBuilder: (_, index) => ListTile(
                  leading: Container(
                  height: 40,
                  width: 40,
                  decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.grey),
                  alignment: Alignment.center,
                  child: Text("${index + 1}"),
                ),
                title: Text('List element ${index + 1}'),
              ),
             )
            ),
            ScrollableListTab(
              label: "hola",
              body: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 10,
                itemBuilder: (_, index) => ListTile(
                leading: Container(
                  height: 40,
                  width: 40,
                  decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.grey),
                  alignment: Alignment.center,
                  child: Text("${index + 1}"),
                ),
                title: Text('List element ${index + 1}'),
              ),
            )
          ),
        ],
      )
    )
```
