require_relative 'binary_search_trees'

# Create a binary search tree from an array of random numbers
my_tree = Tree.new((Array.new(15) { rand(1..100) }))

# Confirm that the tree is balanced by calling #balanced?
p my_tree.balanced?

# Print out all elements in level, pre, post, and in order
my_tree.inorder
my_tree.preorder
my_tree.postorder

# Unbalance the tree by adding several numbers > 100
my_tree.insert(Node.new(140))
my_tree.insert(Node.new(150))
my_tree.insert(Node.new(160))
my_tree.insert(Node.new(170))
my_tree.insert(Node.new(180))
my_tree.insert(Node.new(190))
my_tree.insert(Node.new(200))
my_tree.insert(Node.new(210))
my_tree.insert(Node.new(220))

# Confirm that the tree is unbalanced by calling #balanced? -> FAIL
p my_tree.balanced?

# Balance the tree by calling #rebalance
my_tree.rebalance

# Confirm that the tree is balanced by calling #balanced?
p my_tree.balanced?

# Print out all elements in level, pre, post, and in order
my_tree.inorder
my_tree.preorder
my_tree.postorder
