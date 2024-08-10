class TreeNode {
  ///name of the node
  final String name;

  ///list of child node
  final List<TreeNode> children;

  ///indicating if the node is expanded
  bool isExpanded;

  ///Constructor
  TreeNode({
    required this.name,
    required this.children,
    ///I initialize default value for expanded
    this.isExpanded = false,
  });

  ///I create the method to reset expansion state recursively
  void resetExpansion() {

    ///I make reset current node's expansion state
    isExpanded = false;

    ///I make Recursively reset expansion state for children by the for loop
    for (var child in children) {
      child.resetExpansion();
    }
  }
}
