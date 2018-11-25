class Array
  def quicksort
    dup.quicksort!
  end

  def quicksort!(lo = 0, hi = length - 1, &prc)
    return self if hi <= lo
    prc ||= Proc.new { |a, b| a <=> b }
    shuffle! if lo == 0 && hi == length - 1
    pivot_i = Array.partition!(self, lo, hi, &prc)
    self.quicksort!(lo, pivot_i - 1, &prc)
    self.quicksort!(pivot_i + 1, hi, &prc)
  end

  private

  def self.partition!(arr, lo = 0, hi = length - 1, &prc)
    prc ||= Proc.new { |a, b| a <=> b }
    i = lo + 1
    j = hi
    loop do
      i += 1 while prc.call(arr[i], arr[lo]) < 0 && i <= hi
      j -= 1 while prc.call(arr[j], arr[lo]) >= 0 && j > lo
      break if j < i
      arr[i], arr[j] = arr[j], arr[i]
    end
    arr[lo], arr[j] = arr[j], arr[lo]
    j
  end
end
