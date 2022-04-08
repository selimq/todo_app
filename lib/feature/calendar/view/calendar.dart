import 'package:another_flushbar/flushbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'notification_service.dart';
import 'dart:collection';
import '../../../core/extension/context_extension.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';

import '../../test/model/note.dart';

class Calendar extends StatefulWidget {
  const Calendar({Key? key}) : super(key: key);

  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  @override
  Widget build(BuildContext context) {
    return const TableEventsExample();
  }
}

extension DateOnlyCompare on DateTime {
  bool isSameDate(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }
}

class TableEventsExample extends StatefulWidget {
  const TableEventsExample({Key? key}) : super(key: key);

  @override
  _TableEventsExampleState createState() => _TableEventsExampleState();
}

class _TableEventsExampleState extends State<TableEventsExample> {
//  List<Note> _selectedNotes = [];
  late final ValueNotifier<List<Note>> _selectedEvents;
  bool isLoading = true;
  var checked = false;
  List<Map<String, List<Note>>> listNotes = [];
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  CollectionReference notes = FirebaseFirestore.instance.collection('notesAll');
  TextEditingController title = TextEditingController();
  TextEditingController saat = TextEditingController();
  @override
  void initState() {
    _selectedDay = _focusedDay;
    super.initState();

    // _selectedEvents = ValueNotifier(_getEventsForDay(_focusedDay));
    getAllNotes();
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

  List<Note> _getEventsForDay(DateTime day) {
    // Implementation example
    //// print(kEvents[day]);
    FirebaseFirestore.instance
        .collection("notesAll")
        .doc(day.toIso8601String().toString().substring(0, 10))
        .set({"date": day});
    return listNotes
            .where((element) => element
                .containsKey(day.toIso8601String().toString().substring(0, 10)))
            .first[day.toIso8601String().toString().substring(0, 10)] ??
        [];
  }

  List<Note> getNotesFromDayInListNotes(DateTime day) {
    return listNotes
            .where((element) => element
                .containsKey(day.toIso8601String().toString().substring(0, 10)))
            .first[day.toIso8601String().toString().substring(0, 10)] ??
        [];
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    selectedDay =
        DateTime(selectedDay.year, selectedDay.month, selectedDay.day);
    //print(_selectedNotes.first != null ? _selectedNotes.first.time : '');
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
      });
      FirebaseFirestore.instance
          .collection("notesAll")
          .doc(selectedDay.toIso8601String().toString().substring(0, 10))
          .set({"date": selectedDay});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('<3'),
        backgroundColor: Colors.deepPurple,
      ),
      body: isLoading
          ? Center(
              child: const CircularProgressIndicator(),
            )
          : Column(
              children: [
                calendar(),
                const SizedBox(height: 8.0),
                const Divider(),
                bottomNotes()
              ],
            ),
      floatingActionButton: addButton(context),
    );
  }

  StreamBuilder<QuerySnapshot<Object?>> bottomNotes() {
    return StreamBuilder<QuerySnapshot>(
      stream: notes
          .doc(_selectedDay!.toIso8601String().toString().substring(0, 10))
          .collection('notes')
          .where('time',
              isLessThan: DateTime(_selectedDay!.year, _selectedDay!.month,
                  _selectedDay!.day, 23, 59),
              isGreaterThan: DateTime(_selectedDay!.year, _selectedDay!.month,
                  _selectedDay!.day, 1))
          .orderBy("time")
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
    );
  }

  TableCalendar<Note> calendar() {
    return TableCalendar<Note>(
      headerStyle: const HeaderStyle(
          decoration: BoxDecoration(color: Colors.pink),
          formatButtonVisible: false,
          titleCentered: true),
      firstDay: kFirstDay,
      lastDay: kLastDay,
      startingDayOfWeek: StartingDayOfWeek.monday,
      focusedDay: _focusedDay,
      onDaySelected: _onDaySelected,
      selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
      onPageChanged: (focusedDay) {
        _focusedDay = focusedDay;
      },
      calendarStyle: const CalendarStyle(
        canMarkersOverflow: true,
        isTodayHighlighted: true,
        markerSize: 7,
        markerDecoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
      ),
      eventLoader: _getEventsForDay,
      onCalendarCreated: (pageController) {
        //  getAllNotes();
      },
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
                                    .collection('notesAll')
                                    .doc(_selectedDay
                                        ?.toIso8601String()
                                        .toString()
                                        .substring(0, 10))
                                    .collection("notes")
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

                                getNotesFromDayInListNotes(_selectedDay!)
                                    .add(Note());

                                //  getAllNotes();
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
                                  .collection('notesAll')
                                  .doc(_selectedDay!
                                      .toIso8601String()
                                      .toString()
                                      .substring(0, 10))
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
                      query
                          .doc(_selectedDay!
                              .toIso8601String()
                              .toString()
                              .substring(0, 10))
                          .collection('notes')
                          .doc(snapshot.data!.docs[index].id)
                          .delete();
                      getNotesFromDayInListNotes(_selectedDay!).removeAt(0);
                      setState(() {});
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

  Future<void> getAllNotes() async {
    kEvents = LinkedHashMap<DateTime, List<Note>>(
      equals: isSameDay,
      hashCode: getHashCode,
    );
    FirebaseFirestore.instance.collection("notesAll").get().then((value) async {
      //  print(value.docs);

      for (var e in value.docs) {
        FirebaseFirestore.instance
            .collection("notesAll")
            .doc(e.id)
            .collection("notes")
            .get()
            .then((value) {
          List<Note> notes = [];
          value.docs.forEach((element) {
            notes.add(Note(
                time: element.data()['time'].toDate(),
                isFinished: element.data()['finished'],
                title: element.data()['title']));
          });
          print("adding..");
          listNotes.add({
            (e.data()['date']?.toDate() as DateTime)
                .toIso8601String()
                .toString()
                .substring(0, 10): notes
          });
          //listNotes.add({e.data()['date']: value});
          setState(() {});
        });
      }
      await Future.delayed(Duration(milliseconds: 500));
      setState(() {
        isLoading = false;
      });
    });
  }
}

int getHashCode(DateTime key) {
  return key.day * 19023 + key.month * 129100 + key.year;
}

/// Example event class.

final kToday = DateTime.now();
final kFirstDay = DateTime(kToday.year, kToday.month - 3, kToday.day);
final kLastDay = DateTime(kToday.year, kToday.month + 3, kToday.day);
