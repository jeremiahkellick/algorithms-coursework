def selection_sort(arr, &prc)
  prc ||= Proc.new { |a, b| a <=> b }
  arr.each_index do |i|
    min_i = (i...arr.length).min { |a_i, b_i| prc.call(arr[a_i], arr[b_i]) }
    arr[i], arr[min_i] = arr[min_i], arr[i]
  end
  arr
end
