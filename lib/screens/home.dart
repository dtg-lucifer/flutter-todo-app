import "package:flutter/material.dart";
import "../model/todo.dart";
import "../constants/colors.dart";
import "../widgets/todo_item.dart";

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final todosList = Todo.todoList();
  List<Todo> _foundTodo = [];
  final _todoSearchController = TextEditingController();

  @override
  void initState() {
    _foundTodo = todosList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: bgColor,
        appBar: _buildAppBar(),
        body: Stack(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Column(children: [
                _searchBar(),
                Expanded(
                  child: ListView(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 50, bottom: 20),
                        child: const Text(
                          "All Todos",
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.w500),
                        ),
                      ),
                      for (Todo todo in _foundTodo.reversed)
                        TodoItem(
                          todo: todo,
                          onTodoChanged: _handleTodoChange,
                          deleteItem: _handleDeleteTodo,
                        ),
                    ],
                  ),
                )
              ]),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                children: [
                  Expanded(
                      child: Container(
                    margin:
                        const EdgeInsets.only(bottom: 20, right: 20, left: 20),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.grey,
                            offset: Offset(0.0, 0.0),
                            blurRadius: 10.0,
                            spreadRadius: 0,
                          ),
                        ],
                        borderRadius: BorderRadius.circular(10.0)),
                    child: TextField(
                      controller: _todoSearchController,
                      decoration: const InputDecoration(
                          hintText: "Add a new TODO", border: InputBorder.none),
                    ),
                  )),
                  Container(
                    margin: const EdgeInsets.only(bottom: 20, right: 20),
                    child: ElevatedButton(
                        onPressed: () {
                          _addTodoItem(_todoSearchController.text);
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: blue,
                            minimumSize: const Size(60, 60),
                            elevation: 10),
                        child: const Text("+",
                            style:
                                TextStyle(fontSize: 40, color: Colors.white))),
                  )
                ],
              ),
            )
          ],
        ));
  }

  void _handleTodoChange(Todo todo) {
    setState(() {
      todo.isDone = !todo.isDone;
    });
  }

  void _handleDeleteTodo(String id) {
    setState(() {
      todosList.removeWhere((e) => e.id == id);
    });
  }

  void _addTodoItem(String todo) {
    setState(() {
      todosList.add(Todo(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          todoText: todo));
    });
    _todoSearchController.clear();
  }

  void _runFilter(String keyWord) {
    List<Todo> result = [];
    if (keyWord.isEmpty) {
      result = todosList;
    } else {
      result = todosList
          .where((item) =>
              item.todoText.toLowerCase().contains(keyWord.toLowerCase()))
          .toList();
    }

    setState(() {
      _foundTodo = result;
    });
  }

  Container _searchBar() {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: TextField(
          onChanged: (value) => _runFilter(value),
          decoration: const InputDecoration(
              contentPadding: EdgeInsets.all(0),
              prefixIcon: Icon(Icons.search, color: black, size: 20),
              prefixIconConstraints:
                  BoxConstraints(maxHeight: 20, maxWidth: 20),
              border: InputBorder.none,
              hintText: "Search",
              hintStyle: TextStyle(color: grey)),
        ));
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: bgColor,
      elevation: 0,
      title: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        const Icon(Icons.menu, color: black, size: 30),
        SizedBox(
            height: 40,
            width: 40,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset("assets/images/my_pic.jpg"),
            ))
      ]),
    );
  }
}
