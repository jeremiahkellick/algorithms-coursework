class UnionFind
  attr_reader :store

  def initialize(n)
    @store = (0...n).to_a
    @size = Array.new(n, 1)
  end

  def connected?(a, b)
    root(a) == root(b)
  end

  def union(a, b)
    min_root = root(a)
    max_root = root(b)
    max_root, min_root = min_root, max_root if @size[min_root] > @size[max_root]
    @store[min_root] = @store[max_root]
    @size[max_root] += @size[min_root]
  end

  private

  def root(i)
    return i if @store[i] == i
    root(@store[i])
  end
end
