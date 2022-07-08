/* Developed by Eng Mouaz M. AlShahmeh */
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_example/controllers/providers/todo.dart';
import 'package:firebase_example/views/screens/crud/create.dart';
import 'package:firebase_example/views/screens/crud/show.dart';
import 'package:firebase_example/views/screens/crud/update.dart';

class TodoList extends StatelessWidget {
  const TodoList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 0), () {
      context.read<TodoProvider>().getTodosList();
    });

    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: const Text('Todos\' List'),
        centerTitle: true,
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height * 0.8,
        width: MediaQuery.of(context).size.width,
        child: Consumer<TodoProvider>(
          builder: (context, list, child) {
            return list.loading == 1
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount:
                        list.listTodos.isNotEmpty ? list.listTodos.length : 0,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(list.listTodos[index]!.title!),
                        subtitle: Text(list.listTodos[index]!.dsc!),
                        trailing: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.3,
                          child: Row(
                            children: [
                              Expanded(
                                child: InkWell(
                                    onTap: () {
                                      list.selectTodo(list.listTodos[index]!);
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  UpdateTodo()));
                                    },
                                    child: const Icon(
                                      Icons.edit,
                                      color: Colors.green,
                                    )),
                              ),
                              SizedBox(
                                  height:
                                      MediaQuery.of(context).size.width * 0.01),
                              Expanded(
                                child: InkWell(
                                    onTap: () {
                                      list.selectTodo(list.listTodos[index]!);
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const ShowTodo()));
                                    },
                                    child: const Icon(
                                      Icons.remove_red_eye,
                                      color: Colors.blue,
                                    )),
                              ),
                            ],
                          ),
                        ),
                        leading: InkWell(
                            onTap: () {
                              list.removeFromList(list.listTodos[index]!.id!);
                            },
                            child: const Icon(
                              Icons.delete,
                              color: Colors.red,
                            )),
                      );
                    },
                  );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => CreateTodo()));
        },
        child: const Icon(Icons.add),
      ),
    ));
  }
}
