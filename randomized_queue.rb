class RandomizedQueue
  def initialize
    @store = []
  end

  def empty?
    @store.empty?
  end

  def length
    @store.length
  end

  def enqueue(item)
    @store.push(item)
  end

  def dequeue
    rand_i = rand(0...length)
    @store[0], @store[rand_i] = @store[rand_i], @store[0]
    @store.shift
  end

  def sample
    @store.sample
  end
end
