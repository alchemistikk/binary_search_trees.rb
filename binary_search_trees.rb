class Node
  include Comparable
  attr_accessor :data, :left, :right

  def initialize(data)
    @data = data
    @left = nil
    @right = nil
  end

  def <=>(other)
    @data <=> other.data
  end
end

class Tree
  attr_accessor :root

  def initialize(arr)
    @root = build_tree(arr)
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end

  def build_tree(raw)
    return if raw.empty?

    arr = raw.uniq.sort

    middle = arr.length / 2

    root = Node.new(arr[middle])
    root.left = build_tree(arr[0...middle])
    root.right = build_tree(arr[middle + 1..-1])
    root
  end

  def insert(value, root = @root)
    return value if root.nil?

    if value < root
      root.left = insert(value, root.left)
    else
      root.right = insert(value, root.right)
    end

    root
  end

  def delete(value, root = @root)
    return root if root.nil?

    if value < root
      root.left = delete(value, root.left)
    elsif value > root
      root.right = delete(value, root.right)
    elsif root.left.nil?
      root = root.right
    elsif root.right.nil?
      root = root.left
    else
      root = min_value(root.right)
      root.right = delete(root, root.right)
    end

    root
  end

  def min_value(node)
    current = node
    while current.left
      current = current.left
    end
    current
  end

  def find(value, root = @root)
    return root if root == value || root.nil?
    return find(value, root.left) if value < root
    return find(value, root.right) if value > root
  end

  def level_order
    i = 0
    queue = [@root]
    arr = []
    values = []
    while queue[i]
      arr << queue[i]
      values << queue[i].data
      queue << queue[i].left if queue[i].left
      queue << queue[i].right if queue[i].right
      i += 1
    end
    return values unless block_given?
    arr.each { |node| yield node }
  end

  # I have tried passing root to a block both implicitly and explicitly, but can't figure it out just yet.
  # For now we can just puts root.data to show that the method does recurse as intended.
  def inorder(root = @root)
    return if root.nil?

    inorder(root.left)
    puts root.data
    inorder(root.right)
  end

  def preorder(root = @root)
    return if root.nil?

    puts root.data
    preorder(root.left)
    preorder(root.right)
  end

  def postorder(root = @root)
    return if root.nil?

    postorder(root.left)
    postorder(root.right)
    puts root.data
  end

  def height(node = @root)
    node = find(node) unless node.nil? || node == @root

    return -1 if node.nil?

    [height(node.left), height(node.right)].max + 1 # Find height for each subtree
  end

  def depth(node)
    height(@root) - height(node)
  end

  def balanced?(left = height(@root.left), right = height(@root.right))
    return true if left - right <= 1 && right - left <= 1

    false
  end

  def rebalance
    @root = build_tree(level_order)
  end
end
