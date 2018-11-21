class Queue
  def initialize
    @first = nil
    @last = nil
  end

  def push(item)
    node = Node.new(item)
    @last.next = node unless @last.nil?
    @last = node
    @first = node if @first.nil?
  end

  def pop
    return nil if @first.nil?
    item = @first.val
    @first = @first.next
    @last = nil if @first.nil?
    item
  end

  def empty?
    @first.nil?
  end

  Node = Struct.new(:val, :next)

  private_constant :Node
end
