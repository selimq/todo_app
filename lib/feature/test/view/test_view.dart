import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../model/note.dart';
import '../../../core/constants/app/app_constants.dart';
import '../../../core/constants/navigation/navigation_constants.dart';
import '../../../core/init/navigation/navigation_route.dart';
import '../../../core/init/navigation/navigation_service.dart';
import '../../../core/components/text/locale_text.dart';
import '../../../core/base/state/base_state.dart';
import '../../../generated/locale_keys.g.dart';
import '../../../core/extension/context_extension.dart';

class TestView extends StatefulWidget {
  const TestView({Key? key}) : super(key: key);

  @override
  _TestViewState createState() => _TestViewState();
}

class _TestViewState extends BaseState<TestView> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    //CollectionReference notes = FirebaseFirestore.instance.collection('notes');

    return Scaffold(
      appBar: customAppBar(),
      body: Column(
        children: [
          // const Notes(),
          context.uiSpacer(horizontal: 3, vertical: 5),
        ],
      ),
      floatingActionButton: addButton(context),
    );
  }

  AppBar customAppBar() {
    return AppBar(
      title: const LocaleText(value: LocaleKeys.welcome),
      leading: IconButton(
        icon: const Icon(Icons.read_more),
        onPressed: () {},
      ),
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

        showModalBottomSheet(
          isScrollControlled: true,
          context: context,
          builder: (context) => SizedBox(
            height: context.height * 0.85,
            child: Scaffold(appBar: AppBar(), body: Container()),
          ),
        );
      },
    );
  }
}

class Notes extends StatefulWidget {
  final DateTime day;
  const Notes({Key? key, required this.day}) : super(key: key);

  @override
  State<Notes> createState() => _NotesState();
}

class _NotesState extends State<Notes> {
  @override
  void initState() {
    print(widget.day);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    CollectionReference notes = FirebaseFirestore.instance.collection('notes');
    return StreamBuilder<QuerySnapshot>(
      stream: notes.where('time', isGreaterThan: Timestamp.now()).snapshots(),
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
        return const Text("_");
      },
    );
  }

  ListTile tileNote(AsyncSnapshot<QuerySnapshot<Object?>> snapshot, int index,
      BuildContext context, CollectionReference query) {
    Map<String, dynamic> data =
        snapshot.data!.docs[index].data() as Map<String, dynamic>;
    Note note = Note().fromJson(data);
    return ListTile(
      title: Text(note.title!),
      subtitle: Text("Saat: ${note.time!.toIso8601String().substring(11, 16)}"),
      trailing: IconButton(
        icon: const Icon(Icons.remove, color: Colors.red),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              content: Text("Silmek istediğine emin misin?"),
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
}
