import 'package:another_flushbar/flushbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:todo_app/core/components/text/locale_text.dart';
import 'package:todo_app/feature/calendar/view/notification_service.dart';
import 'dart:collection';
import '../../../core/extension/context_extension.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';

import 'package:todo_app/feature/test/model/note.dart';
import 'package:todo_app/feature/test/view/test_view.dart';
import 'package:todo_app/generated/locale_keys.g.dart';

class Calendar extends StatefulWidget {
  const Calendar({Key? key}) : super(key: key);

  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  @override
  Widget build(BuildContext context) {
    return TableEventsExample();
  }
}

extension DateOnlyCompare on DateTime {
  bool isSameDate(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }
}

class TableEventsExample extends StatefulWidget {
  @override
  _TableEventsExampleState createState() => _TableEventsExampleState();
}

class _TableEventsExampleState extends State<TableEventsExample> {
//  List<Note> _selectedNotes = [];
  var checked = false;

  List<Note> _allNotes = [];
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  CollectionReference notes = FirebaseFirestore.instance.collection('notes');
  TextEditingController title = TextEditingController();
  TextEditingController saat = TextEditingController();
  @override
  void initState() {
    _selectedDay = _focusedDay;
    super.initState();
    //   getAllNotes();
    // getAllNotes();

    // _selectedNotes = ValueNotifier(_getNoteForDay(_selectedDay!));
  }

  @override
  void dispose() {
    super.dispose();
  }

  var kEvents = LinkedHashMap<DateTime, List<Note>>(
    equals: isSameDay,
    hashCode: getHashCode,
  );

/*   // ignore: prefer_for_elements_to_map_fromiterable, unused_field
  final _kEventSource = Map.fromIterable(List.generate(50, (index) => index),
      key: (item) => DateTime.utc(kFirstDay.year, kFirstDay.month, item * 5),
      value: (item) => List.generate(
          item % 4 + 1, (index) => Note('Event $item | ${index + 1}'))); */

  List<Note> _getEventsForDay(DateTime day) {
    // Implementation example
    return kEvents[day] ?? [];
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    //print(DateTime(selectedDay.year, selectedDay.month, selectedDay.day, 23));
    selectedDay =
        DateTime(selectedDay.year, selectedDay.month, selectedDay.day);
    //print(_selectedNotes.first != null ? _selectedNotes.first.time : '');
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
      });

      // _selectedNotes.value = _getNoteForDay(selectedDay);

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('<3'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Column(
        children: [
          TableCalendar<Note>(
            headerStyle: const HeaderStyle(
                decoration: BoxDecoration(color: Colors.pink),
                formatButtonVisible: false,
                titleCentered: true),
            firstDay: kFirstDay,
            eventLoader: _getEventsForDay,
            lastDay: kLastDay,
            focusedDay: _focusedDay,
            calendarBuilders: CalendarBuilders(
              defaultBuilder: (context, day, focusedDay) {
                (context, date, events) => Container(
                    margin: const EdgeInsets.all(5.0),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(8.0)),
                    child: Text(
                      date.day.toString(),
                      style: const TextStyle(color: Colors.white),
                    ));
              },
            ),
            onCalendarCreated: (pageController) {
              getAllNotes();
            },
            calendarStyle: CalendarStyle(
                canMarkersOverflow: true,
                isTodayHighlighted: true,
                markerSize: 5),
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            startingDayOfWeek: StartingDayOfWeek.monday,
            onDaySelected: _onDaySelected,
            onPageChanged: (focusedDay) {
              _focusedDay = focusedDay;
            },
          ),
          const SizedBox(height: 8.0),
          const Divider(),
          StreamBuilder<QuerySnapshot>(
            stream: notes
                .where('time',
                    isLessThan: DateTime(_selectedDay!.year,
                        _selectedDay!.month, _selectedDay!.day, 23),
                    isGreaterThan: DateTime(_selectedDay!.year,
                        _selectedDay!.month, _selectedDay!.day, 1))
                .orderBy("time")
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return const Text("Something went wrong");
              }

              if (snapshot.hasData && snapshot.data == null) {
                return const Text("Veri yok");
              }

              if (snapshot.connectionState == ConnectionState.active) {
                return Expanded(
                  child: ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      return tileNote(snapshot, index, context, notes);
                    },
                  ),
                );
              }
              return const Text("");
            },
          )
        ],
      ),
      floatingActionButton: addButton(context),
    );
  }

  FloatingActionButton addButton(context) {
    return FloatingActionButton(
      child: const Icon(
        Icons.add,
        color: Colors.white,
      ),
      backgroundColor: Colors.deepPurple,
      onPressed: () {
        //Navigate Form Page
        setState(() {
          checked = false;
        });
        showDialog(
            context: context,
            builder: (context) => StatefulBuilder(
                  builder: (context, setState) {
                    return AlertDialog(
                      actions: [
                        TextButton(
                            onPressed: () {
                              if (title.text != '' && saat.text.length > 4) {
                                DateTime newt = DateTime(
                                    _selectedDay!.year,
                                    _selectedDay!.month,
                                    _selectedDay!.day,
                                    int.parse(saat.text[0] + saat.text[1]),
                                    int.parse(saat.text[3] + saat.text[4]));
                                FirebaseFirestore.instance
                                    .collection('notes')
                                    .add({
                                  "title": title.text,
                                  "time": newt,
                                  "remind": checked,
                                }).then((e) {
                                  e.get().then((es) {
                                    if (es.data()!['remind']) {
                                      NotificationService()
                                          .scheduleNotifications(
                                              newt,
                                              es.data()!['title'],
                                              e.id.hashCode);
                                    }
                                  });
                                });
                                getAllNotes();
                                Navigator.of(context).pop();
                              } else {
                                Flushbar(
                                  messageText: const Text(
                                    "Boş bırakma bebek",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  messageSize: 42,
                                  flushbarPosition: FlushbarPosition.TOP,
                                  backgroundColor: Colors.red.shade900,
                                ).show(context);
                              }
                            },
                            child: const Text("Ekle")),
                        TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text("Vazgeç"))
                      ],
                      content: contentAdd(context, setState),
                    );
                  },
                )).then((value) {
          setState(() {
            title.text = '';
            saat.text = '';
            checked = false;
          });
        });
      },
    );
  }

  SizedBox contentAdd(BuildContext context, setState) {
    return SizedBox(
      height: context.height * 0.25,
      child: Column(
        children: [
          TextField(
            controller: title,
            decoration: const InputDecoration(labelText: "Yapılacak İş"),
          ),
          TextField(
            controller: saat,
            keyboardType: TextInputType.datetime,
            // ignore: prefer_const_constructors
            decoration: InputDecoration(
              labelText: "Saat  ",
            ),
            inputFormatters: [
              MaskedInputFormatter('##:##'),
            ],
          ),
          Row(
            children: [
              Text("Hatırlat"),
              Checkbox(
                  value: checked,
                  onChanged: (e) {
                    setState(() {
                      checked = e!;
                    });
                  }),
            ],
          ),
        ],
      ),
    );
  }

  ListTile tileNote(AsyncSnapshot<QuerySnapshot<Object?>> snapshot, int index,
      BuildContext context, CollectionReference query) {
    Map<String, dynamic> data =
        snapshot.data!.docs[index].data() as Map<String, dynamic>;
    Note note = Note().fromJson(data);
    bool isFinished = data['isFinished'] ?? false;
    bool hatirlat = data['remind'] ?? false;
    return ListTile(
      leading: Checkbox(
          value: data['isFinished'] ?? false,
          onChanged: (deger) {
            FirebaseFirestore.instance
                .collection('notes')
                .doc(snapshot.data!.docs[index].id)
                .update({"isFinished": deger});
            setState(() {
              isFinished = deger!;
            });
          }),
      onTap: () {
        title.text = data['title'];
        saat.text = (data['time'] as Timestamp)
            .toDate()
            .toIso8601String()
            .toString()
            .substring(11, 16);
        var id = snapshot.data!.docs[index].id;
        checked = hatirlat;
        showDialog(
            context: context,
            builder: (context) => StatefulBuilder(
                builder: (context, setState) => AlertDialog(
                      actions: [
                        TextButton(
                          onPressed: () {
                            if (title.text != '' && saat.text.length > 4) {
                              DateTime newt = DateTime(
                                _selectedDay!.year,
                                _selectedDay!.month,
                                _selectedDay!.day,
                                int.parse(saat.text[0] + saat.text[1]),
                                int.parse(saat.text[3] + saat.text[4]),
                              );
                              FirebaseFirestore.instance
                                  .collection('notes')
                                  .doc(id)
                                  .update({
                                "title": title.text,
                                "time": newt,
                                "remind": checked,
                              });
                              if (checked) {
                                NotificationService()
                                    .cancelNotifications(id.hashCode);
                                NotificationService().scheduleNotifications(
                                    newt, title.text, id.hashCode);
                              }

                              Navigator.of(context).pop();
                            } else {
                              Flushbar(
                                messageText: const Text(
                                  "Boş bırakma bebek",
                                  style: TextStyle(color: Colors.white),
                                ),
                                messageSize: 42,
                                flushbarPosition: FlushbarPosition.TOP,
                                backgroundColor: Colors.red.shade900,
                              ).show(context);
                            }
                          },
                          child: const Text("Düzenle"),
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text("Vazgeç"))
                      ],
                      content: contentAdd(context, setState),
                    ))).then((value) {
          setState(() {
            title.text = '';
            saat.text = '';
            checked = false;
          });
        });
      },
      style: ListTileStyle.drawer,
      title: Text(
        note.title!,
        style: isFinished
            ? const TextStyle(decoration: TextDecoration.lineThrough)
            : const TextStyle(),
      ),
      textColor: isFinished ? Colors.grey : Colors.grey.shade700,
      subtitle: Row(
        children: [
          Text(
            "Saat: ${note.time!.toIso8601String().substring(11, 16)}",
            style: isFinished
                ? const TextStyle(decoration: TextDecoration.lineThrough)
                : const TextStyle(),
          ),
          const Icon(Icons.alarm)
        ],
      ),
      trailing: IconButton(
        icon: const Icon(Icons.remove, color: Colors.red),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              content: const Text("Silmek istediğine emin misin ?"),
              actions: [
                TextButton(
                    onPressed: () {
                      query.doc(snapshot.data!.docs[index].id).delete();

                      Navigator.of(context).pop();
                    },
                    child: const Text("Evet")),
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text("Hayır"))
              ],
            ),
          );
        },
      ),
    );
  }

  getAllNotes() {
    kEvents = LinkedHashMap<DateTime, List<Note>>(
      equals: isSameDay,
      hashCode: getHashCode,
    );
    FirebaseFirestore.instance
        .collection("notes")
        .where('isFinished', isEqualTo: false)
        .get()
        .then((value) {
      value.docs.map((e) {
        var date = e.data()['time'].toDate();
        var today = DateTime(date.year, date.month, date.day);
        kEvents.addAll({
          today: [
            ..._getEventsForDay(today),
            Note(time: e.data()['time'].toDate())
          ]
        });
      }).toList();
    });
  }
}

int getHashCode(DateTime key) {
  return key.day * 1000000 + key.month * 10000 + key.year;
}

/// Example event class.

final kToday = DateTime.now();
final kFirstDay = DateTime(kToday.year, kToday.month - 3, kToday.day);
final kLastDay = DateTime(kToday.year, kToday.month + 3, kToday.day);
