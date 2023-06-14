import 'package:flutter/material.dart';
import 'package:scroll_to_animate_tab/scroll_to_animate_tab.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: ScrollToAnimateTab(
        activeTabDecoration: BoxDecoration(
            color: Colors.red,
            border: Border.all(color: Colors.blue)
        ),
        inActiveTabDecoration: const BoxDecoration(
            color: Colors.transparent,
            border: Border(
                bottom: BorderSide(color: Colors.black, width: 1.5)
            )
        ),
        tabs: [
          ScrollableListTab(
              tab: ListTab(
                label: Text('Label 1'),
                icon: const Icon(Icons.ac_unit, size: 14),
              ),
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
              tab: ListTab(
                label: Text('Label 2'),
                icon: const Icon(Icons.ac_unit, size: 14),
              ),
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
              tab: ListTab(
                label: Text('Label 3'),
                icon: const Icon(Icons.ac_unit, size: 14),
              ),
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
        ]

        /*List.generate(10, (index) => ScrollableListTab(
            tab: ListTab(
              label: Text('Label ${index + 1}'),
              icon: const Icon(Icons.ac_unit, size: 14),
              activeTabDecoration: BoxDecoration(
                  color: Colors.blue,
                  border: Border.all(color: Colors.blue)
              ),
              inActiveTabDecoration: const BoxDecoration(
                  color: Colors.transparent,
                  border: Border(
                      bottom: BorderSide(color: Colors.black, width: 1.5)
                  )
              ),
            ),
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
        ))*/,
      )
    );
  }
}
