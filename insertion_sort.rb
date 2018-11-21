def insertion_sort(arr, interval = 1, &prc)
  prc ||= Proc.new { |a, b| a <=> b }
  arr.each_index do |i|
    until i - interval < 0 || prc.call(arr[i - interval], arr[i]) <= 0
      arr[i - interval], arr[i] = arr[i], arr[i - interval]
      i -= interval
    end
  end
  arr
end
