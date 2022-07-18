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
        body: const DrillMatrixConfigContent(),
        persistentFooterButtons: [
          ElevatedButton.icon(
            onPressed: () {},
            icon: const Icon(
              Icons.add,
              size: 24.0,
            ),
            label: const Text('New Drill Type'),
          ),
        ],
      ),
    );
  }
}

class DrillMatrixConfigContent extends StatelessWidget {
  const DrillMatrixConfigContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<DrillTypeConfig>().getDrillTypes();

    return Consumer<DrillTypeConfig>(
      builder: (context, drillTypeConfig, child) {
        return ListView(
          children: drillTypeConfig.drillTypes
              .map((e) => Padding(
                  padding: const EdgeInsets.all(3),
                  child: ExpansionTile(
                    title: Text(e.name),
                    children: [
                      ListTile(
                        title: Text(e.name),
                      )
                    ],
                  )))
              .toList(),
        );
      },
    );
  }
}
