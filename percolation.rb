require_relative "union_find"

class Percolation
  attr_reader :open_site_count

  def initialize(n)
    @object_count = n**2 + 2
    @union_find = UnionFind.new(@object_count)
    (1..n).each do |i|
      @union_find.union(0, i)
      @union_find.union(@object_count - 1, @object_count - 1 - i)
    end
    @open = Array.new(n) { Array.new(n, false) }
    @open_site_count = 0
  end

  def open(row, col)
    @open[row][col] = true
    @open_site_count += 1
    id = pos_to_id(row, col)
    open_neighbor_ids(row, col).each do |neighbor_id|
      @union_find.union(id, neighbor_id)
    end
  end

  def open?(row, col)
    @open[row][col]
  end

  def full?(row, col)
    !open?(row, col)
  end

  def percolate?
    @union_find.connected?(0, @object_count - 1)
  end

  private

  def pos_to_id(row, col)
    row * @open.length + col + 1
  end

  def open_neighbor_ids(row, col)
    ids = []
    pos = [row, col]
    [[0, 1], [-1, 0], [0, -1], [1, 0]].each do |offset|
      next if offset == [0, 0]
      neighbor_pos = add_pos(pos, offset)
      if neighbor_pos.all? { |coord| (0...@open.length).cover?(coord) } &&
         open?(*neighbor_pos)

        ids << pos_to_id(*neighbor_pos)
      end
    end
    ids
  end

  def add_pos(a, b)
    [a[0] + b[0], a[1] + b[1]]
  end
end

class PercolationStats
  attr_reader :mean, :stddev, :confidence_lo, :confidence_hi

  def initialize(n, trials)
    raise ArgumentError, "n can't be less than zero" if n < 0
    raise ArgumentError, "trials can't be less than zero" if trials < 0
    results = []
    trials.times do
      percolation = Percolation.new(n)
      positions = (0...n).to_a.product((0...n).to_a).shuffle
      percolation.open(*positions.pop) until percolation.percolate?
      results << percolation.open_site_count.fdiv(n**2)
    end
    @mean = results.sum / trials
    @stddev = Math.sqrt(
      results.reduce(0) { |acc, el| acc + (el - @mean)**2 } / (trials - 1)
    )
    offset = 1.96 * @stddev / Math.sqrt(trials)
    @confidence_lo = @mean - offset
    @confidence_hi = @mean + offset
  end
end

if __FILE__ == $PROGRAM_NAME
  stats = PercolationStats.new(ARGV[0].to_i, ARGV[1].to_i)
  puts "mean: #{stats.mean}"
  puts "stddev: #{stats.stddev}"
  puts "95% confidence interval: " +
       "[#{stats.confidence_lo}, #{stats.confidence_hi}]"
end
