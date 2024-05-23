import 'package:flutter/material.dart';
import 'package:rfw/formats.dart';
import 'package:rfw/rfw.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const RFWPage(),
    );
  }
}

class RFWPage extends StatefulWidget {
  const RFWPage({super.key});

  @override
  State<RFWPage> createState() => _RFWPageState();
}

class _RFWPageState extends State<RFWPage> {
  late Widget _widget;

  @override
  void initState() {
    super.initState();
    _widget = const Center(
      child: Text('Tap on button'),
    );
  }

  void _updateLabel() {
    final remoteWidgets = parseLibraryFile('''
    // The "import" keyword is used to specify dependencies, in this case,
    // the built-in widgets that are added by initState below.
    import core.widgets;
    // The "widget" keyword is used to define a new widget constructor.
    // The "root" widget is specified as the one to render in the build
    // method below.
    widget root = Container(
      child: Center(
        child: Text(
          text: ["Hello, ", data.greet.name, "!"], textDirection: "ltr"),
      ),
    );
  ''');

    const kCoreName = LibraryName(<String>['core', 'widgets']);
    const kMainName = LibraryName(<String>['main']);

    final runtime = Runtime()
      // Local widget library:
      ..update(kCoreName, createCoreWidgets())
      // Remote widget library:
      ..update(kMainName, remoteWidgets);

    final data = DynamicContent()
      // Configuration data:
      ..update('greet', <String, Object>{'name': 'World (After on tap)'});

    setState(() {
      _widget = RemoteWidget(
        runtime: runtime,
        data: data,
        widget: const FullyQualifiedWidgetName(kMainName, 'root'),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('RFW Package'),
      ),
      body: _widget,
      floatingActionButton: FloatingActionButton(
        onPressed: _updateLabel,
        child: const Icon(Icons.search),
      ),
    );
  }
}
