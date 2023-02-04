import 'package:flutter/material.dart';
import 'package:dynamiclist/constants.dart ' as cnst;

class tasksScreen extends StatefulWidget {
  @override
  State<tasksScreen> createState() => _tasksScreenState();
}

class _tasksScreenState extends State<tasksScreen> {
  List<String> tasks = <String>[];
  TextEditingController _addedTaskController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'DList',
          style: cnst.kTaskTextStyle,
        ),
        backgroundColor: Colors.black,
      ),
      body: Container(
          margin: EdgeInsets.all(30), child: ListView(children: _getTasks())),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFFFFE1FE),
        onPressed: () {
          _display(context);
        },
        child: Icon(
          Icons.add,
          color: Colors.black,
        ),
      ),
    );
  }

  void _addTask(String task) {
    setState(() {
      tasks.add(task);
    });
    _addedTaskController.clear();
  }

  Widget _buildTaskItem(String task) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      child: ListTile(
        title: Text(task),
        leading: Icon(Icons.pending_actions, color: Colors.grey),
        textColor: Colors.black,
        trailing: IconButton(
          onPressed: () {
            showMenu(
                context: context,
                position: RelativeRect.fromLTRB(50, 20, 0, 5),
                items: [
                  PopupMenuItem(
                      child: TextButton(
                    child: Text(
                      'Delete',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () {
                      Text(
                        'Delete',
                      );
                      setState(() {
                        tasks.remove(task);
                      }
                      );
                      Navigator.pop(context);
                    },
                  ))
                ]);
          },
          icon: Icon(
            Icons.more_vert,
            color: Colors.grey,
          ),
        ),
        tileColor: Color(0xFFFFE1FE),
      ),
    );
  }

  Future<dynamic> _display(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Color(0xFFFFE1FE),
            title: Text(
              'ADD A NEW TASK',
              style: cnst.kAlertTextStyle,
            ),
            content: TextField(
              controller: _addedTaskController,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
              decoration: cnst.kHintTextStyle,
            ),
            actions: <Widget>[
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.black),
                ),
                child: Text('ADD'),
                onPressed: () {
                  Navigator.of(context).pop();
                  _addTask(_addedTaskController.text);
                },
              ),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.black),
                ),
                child: Text('CANCEL'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  List<Widget> _getTasks() {
    final List<Widget> _taskWidget = <Widget>[];
    for (String title in tasks) {
      _taskWidget.add(_buildTaskItem(title));
    }
    return _taskWidget;
  }
}
