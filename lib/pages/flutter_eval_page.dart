import 'package:flutter/material.dart';
import 'package:flutter_eval/flutter_eval.dart';

const kLabel = 'Constant';

class FlutterEvalPage extends StatefulWidget {
  const FlutterEvalPage({super.key});

  @override
  State<FlutterEvalPage> createState() => _FlutterEvalPageState();
}

class _FlutterEvalPageState extends State<FlutterEvalPage> {
  late Widget _widget;

  @override
  void initState() {
    super.initState();
    _widget = const Center(
      child: Text('Tap on button'),
    );
  }

  void _updateLabel() {
    const kRemoteWidgets = '''
              import 'package:flutter/material.dart';

              class Body extends StatelessWidget {
                const Body({Key? key}) : super(key: key);

                @override
                Widget build(BuildContext context) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text('Validate $kLabel'),
                        const SizedBox(height: 16.0),
                        ElevatedButton(
                          onPressed: () async {
                            print('Start async action');
                            await Future.delayed(const Duration(seconds: 5));
                            print('End async action');
                          },
                          child: const Text('Async action'),
                        ),
                      ], 
                    ),
                  );
                }
              }
            ''';

    if (mounted) {
      setState(() {
        _widget = const EvalWidget(
          packages: <String, Map<String, String>>{
            'runtime_parser': <String, String>{
              'main.dart': kRemoteWidgets,
            },
          },
          // In debug mode, flutter_eval will continually re-generate a compiled
          // EVC bytecode file for the given program, and save it to the
          // specified assetPath. During runtime, it will instead load the
          // compiled EVC file. To ensure this works, you must add the file path
          // to the assets section of your pubspec.yaml file.
          assetPath: 'assets/program.evc',
          // Specify which library (i.e. which file) to use as an entrypoint.
          library: 'package:runtime_parser/main.dart',
          // Specify which function to call as the entrypoint.
          // To use a constructor, use "ClassName.constructorName" syntax. In
          // this case we are calling a default constructor so the constructor
          // name is blank.
          function: 'Body.',
          // Specify the arguments to pass to the entrypoint. Generally these
          // should be dart_eval [$Value] objects, but when invoking a static or
          // top-level function or constructor, [int]s, [double]s, and [bool]s
          // should be passed directly.
          args: [null],
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('flutter_eval Package'),
      ),
      body: _widget,
      floatingActionButton: FloatingActionButton(
        onPressed: _updateLabel,
        child: const Icon(Icons.search),
      ),
    );
  }
}
