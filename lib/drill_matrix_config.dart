import 'package:drill_matrix/bloc/drill_types.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DrillMatrixConfig extends StatelessWidget {
  const DrillMatrixConfig({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<DrillTypeConfig>.value(value: DrillTypeConfig())
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Drill types",
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent,
        ),
        body: ListView.builder(
            itemCount: 15,
            itemBuilder: (BuildContext context, int index) {
              return ExpansionTile(
                  title: Text('Drill type #${index + 1}'),
                  children: <Widget>[
                    ListTile(
                        title: Text(
                            'TODO: Form components for drill type #${index + 1}')),
                  ]);
            }),
        persistentFooterButtons: [
          ElevatedButton.icon(
            onPressed: () {},
            icon: const Icon(
              // <-- Icon
              Icons.add,
              size: 24.0,
            ),
            label: const Text('New Drill Type'), // <-- Text
          ),
        ],
      ),
    );
  }
}
