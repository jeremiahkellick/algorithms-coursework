def insertion_sort(arr, &prc)
  prc ||= Proc.new { |a, b| a <=> b }
  arr.each_index do |i|
    until arr[i - 1].nil? || prc.call(arr[i - 1], arr[i]) <= 0
      arr[i - 1], arr[i] = arr[i], arr[i - 1]
      i -= 1
    end
  end
  arr
end
