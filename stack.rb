class Stack
  def initialize
    @first = Node.new
  end

  def push(item)
    @first = Node.new(item, @first)
  end

  def pop
    return nil if empty?
    item = @first.val
    @first = @first.next
    item
  end

  def empty?
    @first.nil?
  end

  Node = Struct.new(:val, :next)

  private_constant :Node
end
