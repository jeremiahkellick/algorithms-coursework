class Array
  def quicksort
    dup.quicksort!
  end

  def quicksort!(lo = 0, hi = length - 1, &prc)
    return self if hi <= lo
    prc ||= Proc.new { |a, b| a <=> b }
    shuffle! if lo == 0 && hi == length - 1
    lt, gt = Array.partition!(self, lo, hi, &prc)
    self.quicksort!(lo, lt - 1, &prc)
    self.quicksort!(gt + 1, hi, &prc)
  end

  private

  def self.partition!(arr, lo = 0, hi = length - 1, &prc)
    prc ||= Proc.new { |a, b| a <=> b }
    lt = lo
    gt = hi
    i = lo
    until i > gt
      case prc.call(arr[i], arr[lt]) <=> 0
      when -1
        arr[lt], arr[i] = arr[i], arr[lt]
        lt += 1
        i += 1
      when 1
        arr[i], arr[gt] = arr[gt], arr[i]
        gt -= 1
      when 0
        i += 1
      end
    end
    [lt, gt]
  end
end
