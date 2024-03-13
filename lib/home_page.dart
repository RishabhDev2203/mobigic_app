import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mobigic_app/primary_button.dart';
import 'container_app.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<List<String>> gridList = [];
  TextEditingController searchTextController = TextEditingController();
  TextEditingController mController = TextEditingController();
  TextEditingController nController = TextEditingController();
  String searchText = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'Mobigic Test',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: Row(
              children: [
                Expanded(
                  child: MyContainer(
                      child: Center(
                    child: TextField(
                      controller: mController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        hintText: "Row(m)",
                        border: InputBorder.none,
                      ),
                    ),
                  )),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                    child: MyContainer(
                  child: Center(
                    child: TextField(
                      controller: nController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        hintText: "Column(n)",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                )),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: PrimaryButton(
                    text: 'Create',
                    onClicked: () {
                      FocusManager.instance.primaryFocus?.unfocus();
                      if (mController.text.trim().isNotEmpty &&
                          nController.text.trim().isNotEmpty) {
                        gridList = List.generate(
                            int.parse(mController.text),
                            (_) =>
                                List.filled(int.parse(nController.text), ''));
                        alphabetInputDialog(
                            context,
                            int.parse(mController.text),
                            int.parse(nController.text));
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Row(
              children: [
                Expanded(
                  child: MyContainer(
                    padding: EdgeInsets.zero,
                    child: Center(
                      child: TextField(
                        controller: searchTextController,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Enter text to search',
                            prefixIcon: const Icon(
                              CupertinoIcons.search,
                              color: Colors.black,
                            ),
                            suffixIcon: searchTextController.text.isEmpty
                                ? null
                                : InkWell(
                                    onTap: () {
                                      searchTextController.clear();
                                      searchText = "";
                                      setState(() {});
                                    },
                                    child: const Icon(
                                      CupertinoIcons.clear_circled,
                                      color: Colors.black,
                                    ),
                                  )),
                        onChanged: (value) {
                          searchText = value;
                          setState(() {});
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(15),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: gridList.isNotEmpty ? gridList[0].length : 1,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15),
              itemCount: gridList.length *
                  (gridList.isNotEmpty ? gridList[0].length : 0),
              itemBuilder: (context, index) {
                int row = index ~/ gridList[0].length;
                int col = index % gridList[0].length;
                String alphabet = gridList[row][col];
                bool isHighlighted = false;
                if (searchText.isNotEmpty && alphabet == searchText[0]) {
                  for (int i = 0; i < searchText.length; i++) {
                    if (row + i < gridList.length &&
                        col + i < gridList.length &&
                        gridList[row + i][col + i] == searchText[i]) {
                      isHighlighted = true;
                    } else {
                      isHighlighted = false;
                      break;
                    }
                  }
                }
                return MyContainer(
                  backGroundColor:
                      isHighlighted ? Colors.lightGreen : Colors.black,
                  child: Center(
                    child: Text(
                      gridList[row][col].toUpperCase(),
                      style: const TextStyle(fontSize: 30, color: Colors.white),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  alphabetInputDialog(BuildContext context, int m, int n) {
    showDialog(
      context: context,
      builder: (context) {
        List<TextEditingController> controllers =
            List.generate(m * n, (_) => TextEditingController());
        return AlertDialog(
          title: const Text(
            'Enter Alphabets',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.black,
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(
                m,
                (i) => Row(
                  children: List.generate(
                    n,
                    (j) => Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: MyContainer(
                          backGroundColor: Colors.white,
                          child: Center(
                            child: TextField(
                              controller: controllers[i * n + j],
                              maxLength: 1,
                              textAlign: TextAlign.center,
                              style: const TextStyle(fontSize: 20),
                              decoration: const InputDecoration(
                                  border: InputBorder.none),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          actions: [
            PrimaryButton(
              borderColor: Colors.white,
              onClicked: () {
                if (controllers[0].text.isNotEmpty) {
                  FocusManager.instance.primaryFocus?.unfocus();
                  for (int i = 0; i < m; i++) {
                    for (int j = 0; j < n; j++) {
                      gridList[i][j] = controllers[i * n + j].text;
                      if (kDebugMode) {
                        print(">>>>>>${gridList[i][j]}");
                      }
                    }
                  }
                  Navigator.of(context).pop();
                  setState(() {});
                }
              },
              text: 'Add Grid',
            ),
          ],
        );
      },
    );
  }
}
