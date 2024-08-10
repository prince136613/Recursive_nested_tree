import 'package:flutter/material.dart';
import 'package:flutter_practice/tree_node_model.dart';

class TreeView extends StatefulWidget {

  /// The node to be displayed in this TreeView
  final TreeNode node;

  /// Callback function called when a node is selected
  final void Function(TreeNode) onNodeSelected;

  /// Constructor for TreeView
  const TreeView({
    Key? key,
    required this.node,
    required this.onNodeSelected,
  }) : super(key: key);

  @override
  State<TreeView> createState() => _TreeViewState();
}

/// State class for TreeView
class _TreeViewState extends State<TreeView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        /// Build the current node
        _buildNode(context),

        /// If the node is expanded and has children, build child nodes
        if (widget.node.isExpanded && widget.node.children.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Column(
              children: widget.node.children
                  .map((child) => TreeView(
                node: child,
                onNodeSelected: widget.onNodeSelected,
              ))
                  .toList(),
            ),
          ),
      ],
    );
  }

  /// Build an individual node
  Widget _buildNode(BuildContext context) {
    return GestureDetector(
      onTap: () {

        /// Call the onNodeSelected callback
        widget.onNodeSelected(widget.node);

        /// If the node has children, toggle its expanded state
        if (widget.node.children.isNotEmpty) {
          setState(() {
            widget.node.isExpanded = !widget.node.isExpanded;
          });
        }
      },
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [

            /// Display appropriate icon based on node state
            Icon(
              widget.node.children.isNotEmpty
                  ? (widget.node.isExpanded
                  ? Icons.arrow_drop_up
                  : Icons.arrow_drop_down)
                  : Icons.label,
              color: Colors.black,
            ),
            const SizedBox(width: 8.0),

            /// Display the node name
            Text(widget.node.name),
          ],
        ),
      ),
    );
  }
}