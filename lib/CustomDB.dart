import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';

class CustomData extends StatefulWidget {
  CustomData({this.app});
  final FirebaseApp app;
  @override
  _CustomDataState createState() => _CustomDataState();
}

class _CustomDataState extends State<CustomData> {
  final referencesDatabase = FirebaseDatabase.instance;
  final movieName = 'MovieTitle';
  final movieController = TextEditingController();

  DatabaseReference _moviesRef;
  final FirebaseDatabase database = FirebaseDatabase.instance;
  // void initstate() {
  //
  //   _moviesRef = database.reference().child('Movies');

  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    final ref = referencesDatabase.reference();
    return Scaffold(
      appBar: AppBar(
        title: Text('Movies'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Container(
                color: Colors.yellow,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Column(
                  children: [
                    Text(
                      movieName,
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                    TextField(
                      controller: movieController,
                      textAlign: TextAlign.center,
                    ),
                    FlatButton(
                      color: Colors.white,
                      onPressed: () {
                        ref
                            .child('Movies')
                            .push()
                            .child(movieName)
                            .set(movieController.text)
                            .asStream();
                        movieController.clear();
                      },
                      child: Text('Save Movie'),
                      textColor: Colors.lightBlue,
                    ),
                    Flexible(
                      child: new FirebaseAnimatedList(
                        shrinkWrap: true,
                        query: _moviesRef =
                            database.reference().child('Movies'),
                        itemBuilder: (BuildContext context,
                            DataSnapshot snapshot,
                            Animation<double> animation,
                            int index) {
                          return new ListTile(
                            trailing: IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () =>
                                  _moviesRef.child(snapshot.key).remove(),
                            ),
                            title: new Text(snapshot.value['MovieTitle']),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
