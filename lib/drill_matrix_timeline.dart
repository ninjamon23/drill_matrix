import 'package:flutter/material.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:provider/provider.dart';

import 'bloc/drill_timeline.dart';

class DrillTimeline extends StatelessWidget {
  const DrillTimeline({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<DrillEventList>.value(value: DrillEventList())
      ],
      builder: (context, child) {
        final drillEventBloc = Provider.of<DrillEventList>(context);
        drillEventBloc.fetchEvents();

        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(5),
            child: Column(children: [
              const SizedBox(height: 40),
              // //################################################################################################
              // // Rounded blue MultiSelectDialogField
              // //################################################################################################
              MultiSelectDialogField(
                items: drillEventBloc.getMultiSelectItems(),
                title: const Text("Drill Event"),
                selectedColor: Colors.blue,
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.1),
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  border: Border.all(
                    color: Colors.blue,
                    width: 2,
                  ),
                ),
                buttonIcon: const Icon(
                  Icons.event,
                  color: Colors.blue,
                ),
                buttonText: Text(
                  "Select Drill Event to view",
                  style: TextStyle(
                    color: Colors.blue[800],
                    fontSize: 16,
                  ),
                ),
                onConfirm: (results) {
                  drillEventBloc.selectedEventToView = results;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                  child: drillEventBloc.events.isNotEmpty
                      ? ListView.builder(
                          itemCount: drillEventBloc.eventsToDisplay.length,
                          itemBuilder: ((context, index) {
                            return Row(
                              children: <Widget>[
                                Column(
                                  children: <Widget>[
                                    Container(
                                        width: 2,
                                        height: 50,
                                        color: getOutlineColorByIndex(
                                            index,
                                            drillEventBloc
                                                .eventsToDisplay.length,
                                            true)),
                                    Container(
                                      margin: const EdgeInsets.only(
                                          left: 8, right: 5),
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          // color: colors[(index + 1) % 4],
                                          color: drillEventBloc
                                              .eventsToDisplay[index]
                                              .getStatusColor,
                                          borderRadius:
                                              BorderRadius.circular(50)),
                                      child: Icon(
                                        drillEventBloc
                                            .eventsToDisplay[index].icon,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Container(
                                      width: 2,
                                      height: 50,
                                      color: getOutlineColorByIndex(
                                          index,
                                          drillEventBloc.eventsToDisplay.length,
                                          false),
                                    ),
                                  ],
                                ),
                                Expanded(
                                    child: Container(
                                  margin: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border(
                                        top: BorderSide(
                                          width: 3,
                                          color: drillEventBloc
                                              .eventsToDisplay[index]
                                              .getStatusColor,
                                        ),
                                        left: BorderSide(
                                          width: 3,
                                          color: drillEventBloc
                                              .eventsToDisplay[index]
                                              .getStatusColor,
                                        ),
                                      ),
                                      // ignore: prefer_const_literals_to_create_immutables
                                      boxShadow: [
                                        // ignore: prefer_const_constructors
                                        BoxShadow(
                                          blurRadius: 5,
                                          color: Colors.black26,
                                        )
                                      ]),
                                  // height: 140,
                                  height: 80,
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          drillEventBloc.eventsToDisplay[index]
                                              .nameWithStatus,
                                          style: const TextStyle(
                                            fontSize: 15,
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 5),
                                          child: Text(
                                            drillEventBloc
                                                .eventsToDisplay[index]
                                                .formattedDateOfEvent,
                                            style: const TextStyle(
                                                fontSize: 12, letterSpacing: 2),
                                          ),
                                        ),
                                        // Text(
                                        //   drillEventBloc.eventsToDisplay[index]
                                        //       .description,
                                        //   style: const TextStyle(
                                        //       fontSize: 17, letterSpacing: 2),
                                        // ),
                                      ],
                                    ),
                                  ),
                                ))
                              ],
                            );
                          }))
                      : const Text('No drill events..'))
            ]),
          ),
          persistentFooterButtons: [
            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(
                // <-- Icon
                Icons.event,
                size: 24.0,
              ),
              label: const Text('Add new drill event'), // <-- Text
            ),
          ],
        );
      },
    );
  }

  Color getOutlineColorByIndex(index, eventLength, isTopOutline) {
    if (index == 0) {
      if (isTopOutline) {
        return Colors.transparent;
      } else {
        return Colors.grey;
      }
    }
    if (index == eventLength - 1) {
      if (!isTopOutline) {
        return Colors.transparent;
      }
      return Colors.grey;
    }

    return Colors.grey;
  }
}
