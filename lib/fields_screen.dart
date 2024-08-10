import 'package:flutter/material.dart';
import 'package:flutter_practice/tree_node_model.dart';
import 'package:flutter_practice/tree_view.dart';
import 'package:get_storage/get_storage.dart';

class FieldsScreen extends StatefulWidget {
  const FieldsScreen({Key? key}) : super(key: key);

  @override
  State<FieldsScreen> createState() => _FieldsScreenState();
}

class _FieldsScreenState extends State<FieldsScreen> {
  ///i initialize getStorage for local storage save
  final GetStorage getStorage = GetStorage();

  ///i make a string variable for initial selectedCategory
  String selectedCategory = "Select a category";

  ///i create controller for the destination and area's values management
  final TextEditingController _destinationController = TextEditingController();
  final TextEditingController _areaController = TextEditingController();

  @override
  void dispose() {
    /// i make dispose destination and area textFields controller
    _destinationController.dispose();
    _areaController.dispose();
    super.dispose();
  }

  ///I make Root TreeNode representing the hierarchical structure
  final TreeNode rootNode = TreeNode(
    name: "Root",
    children: [
      TreeNode(
        name: "Categories",
        children: [
          TreeNode(
            name: "Category1",
            children: [
              TreeNode(name: "Subcategory1.1", children: []),
              TreeNode(name: "Subcategory1.2", children: []),
            ],
          ),
          TreeNode(
            name: "Category2",
            children: [
              TreeNode(name: "Subcategory2.1", children: []),
              TreeNode(name: "Subcategory2.2", children: []),
            ],
          ),
        ],
      ),
      TreeNode(
        name: "Areas",
        children: [
          TreeNode(name: "Area1", children: []),
          TreeNode(name: "Area2", children: []),
          TreeNode(
            name: "Area3",
            children: [
              TreeNode(name: "Subarea3.1", children: []),
              TreeNode(name: "Subarea3.2", children: []),
            ],
          ),
        ],
      ),
      TreeNode(
        name: "Destinations",
        children: [
          TreeNode(name: "Destination1", children: []),
          TreeNode(name: "Destination2", children: []),
          TreeNode(
            name: "Destination3",
            children: [
              TreeNode(name: "Subdestination3.1", children: []),
              TreeNode(name: "Subdestination3.2", children: []),
            ],
          ),
        ],
      ),
    ],
  );

  @override
  void initState() {
    super.initState();

    ///I make read selected category from local storage
    selectedCategory = getStorage.read('categoryName') ?? "Select a category";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,

        ///i give title for this screen in app bar
        title: const Text('Fields Screen'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// i build a selector for categories, showing the current selection and allowing the user to choose a new one
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Category",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  GestureDetector(
                    onTap: () {
                      ///i make this widget for select current category
                      _showSelector('categoryName');
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(selectedCategory,
                              style: const TextStyle(fontSize: 16)),
                          const Icon(Icons.arrow_drop_down),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              ///I create a container widget for the Destination input field and below also one area input field
              _nameContainer(
                "Destination",
                const EdgeInsets.only(top: 25),
              ),
              const SizedBox(height: 8),

              ///Textfield for destinationValue
              Container(
                alignment: Alignment.center,
                height: MediaQuery.of(context).size.height * 0.06,
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.only(left: 15),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: TextField(
                  controller: _destinationController,
                  onChanged: (value) {
                    ///I write the destination value to local storage whenever it changes
                    getStorage.write("destinationValue", value);
                  },
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: "Enter Your Destination",
                  ),
                ),
              ),
              _nameContainer(
                "Area",
                const EdgeInsets.only(top: 25),
              ),
              const SizedBox(height: 8),

              ///Textfield for area
              Container(
                alignment: Alignment.center,
                height: MediaQuery.of(context).size.height * 0.06,
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.only(left: 15),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: TextField(
                  controller: _areaController,
                  onChanged: (value) {
                    /// I write the area value to local storage whenever it changes
                    getStorage.write("areaValue", value);
                  },
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: "Enter Your Area",
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),

              /// I build a widget to display the currently selected category, area, and destination values
              _buildSelectionDisplay(),
            ],
          ),
        ),
      ),
    );
  }

  ///widget for name container for destination and area
  Widget _nameContainer(String text, EdgeInsets margin) {
    return Container(
      margin: margin,
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  void _showSelector(String storageKey) {
    rootNode.resetExpansion();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.8,
          minChildSize: 0.5,
          maxChildSize: 0.95,
          expand: false,
          builder: (BuildContext context, ScrollController scrollController) {
            return Column(
              children: [
                AppBar(
                  title: Text('Select ${storageKey.replaceAll('Name', '')}'),
                  leading: IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                  shape: const RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(20)),
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    controller: scrollController,
                    child: TreeView(
                      node: rootNode,
                      onNodeSelected: (node) {
                        if (node.children.isEmpty) {
                          /// I save the selected value to local storage and update the state if the node has no children
                          getStorage.write(storageKey, node.name);

                          /// Update the state based on the storage key
                          if (storageKey == 'categoryName') {
                            setState(() {
                              selectedCategory = node.name;
                            });
                          }
                          Navigator.pop(context);
                        }
                      },
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Widget _buildSelectionDisplay() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// I display the selected category from local storage
          Text('Selected Category: $selectedCategory'),
          const SizedBox(height: 8),

          /// I display the selected area value from local storage
          Text('Selected Area: ${getStorage.read("areaValue")}'),
          const SizedBox(height: 8),

          /// I display the selected destination value from local storage
          Text('Selected Destination:"${getStorage.read("destinationValue")}"'),
        ],
      ),
    );
  }
}
