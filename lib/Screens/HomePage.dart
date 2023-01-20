import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/Providers/TaskProvider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose(); //disposes text controller when not in use
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.cyan.shade100,
          title: const Text("ToDo App"),
          centerTitle: true,
        ),
        body: Consumer<TaskProvider>(
          builder: (context, provider, child) {
            if(provider.tasks.isEmpty) {
              return Column(
                children: [
                   Flexible(
                    child: Container(
                      color: Colors.cyan.shade200,
                      child: const Center(
                        child: Text("Add To Do Items"),
                      ),
                    ),
                  ),
                  customTextField(context),
                ],
              );
            } else {
              return Column(
                children: [
                  Flexible(
                    child: Container(
                      color: Colors.cyan.shade200,
                      child: ListView.builder(
                        itemCount: provider.tasks.length,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          String title = provider.tasks[index].title;
                          bool isDone = provider.tasks[index].isDone;
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(30),
                                    topLeft: Radius.circular(30),
                                    topRight: Radius.circular(30),
                                  ),
                              ),
                              child: ListTile(
                                title: isDone == false
                                    ? Text(
                                        title,
                                      )
                                    : Text(
                                        title,
                                        style: const TextStyle(
                                            decoration:
                                                TextDecoration.lineThrough),
                                      ),
                                leading: isDone
                                    ? IconButton(
                                        onPressed: () {
                                          provider.checkBox(
                                              index, title, isDone);
                                        },
                                        icon: const Icon(Icons.check_box,color: Colors.cyan,))
                                    : IconButton(
                                        onPressed: () {
                                          provider.checkBox(
                                              index, title, isDone);
                                        },
                                        icon: const Icon(
                                            Icons.check_box_outline_blank,color: Colors.cyan,)),
                                trailing: IconButton(
                                  onPressed: () {
                                    provider.delete(index);
                                  },
                                  icon: const Icon(Icons.delete,color: Colors.cyan,),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  customTextField(context), //down below
                ],
              );
            }
          },
        ));
  }

  TextField customTextField(BuildContext context) {
    return TextField(
      controller: _controller,
      onSubmitted: (val) {
        Provider.of<TaskProvider>(context, listen: false).addItem(val);
        _controller.clear();
      },
      decoration: InputDecoration(
        suffix: IconButton(
          onPressed: () {
            Provider.of<TaskProvider>(context, listen: false)
                .addItem(_controller.value.text);
            _controller.clear();
          },
          icon: const Icon(Icons.send),
        ),
        hintText: "Type Here",
        contentPadding: const EdgeInsets.all(8.0),
      ),
    );
  }
}
