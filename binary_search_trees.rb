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
end

arr = [1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324]
my_tree = Tree.new(arr)
my_tree.insert(Node.new(12))
my_tree.delete(Node.new(6345))
my_tree.pretty_print
